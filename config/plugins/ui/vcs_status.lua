local M = {}

local cache = {}
local buffer_roots = {}
local cache_ttl_ms = 5000

local function now_ms()
	return vim.uv.hrtime() / 1000000
end

local function buffer_root()
	local bufnr = vim.api.nvim_get_current_buf()
	if buffer_roots[bufnr] ~= nil then
		return buffer_roots[bufnr] or nil
	end

	local name = vim.api.nvim_buf_get_name(bufnr)
	local start = name ~= "" and vim.fs.dirname(name) or vim.uv.cwd()
	local root = start and vim.fs.root(start, { ".jj", ".git" }) or nil
	buffer_roots[bufnr] = root or false
	return root
end

local function refresh_lualine()
	vim.schedule(function()
		local ok, lualine = pcall(require, "lualine")
		if ok then
			lualine.refresh({ place = { "statusline" } })
		end
	end)
end

local function finish(entry)
	entry.pending = entry.pending - 1
	if entry.pending == 0 then
		entry.updated_at = now_ms()
		refresh_lualine()
	end
end

local function parse_jj(entry, result)
	if result.code == 0 then
		local line = vim.trim(result.stdout or "")
		local fields = vim.split(line, "\t", { plain = true })
		entry.jj = {
			change_id = fields[1] or "",
			bookmarks = fields[2] or "",
			description = fields[3] or "",
			conflicted = fields[4] == "!",
		}
	else
		entry.jj = nil
	end
	finish(entry)
end

local forge_definitions = {
	{ label = "GH", patterns = { "github", "github.com" } },
	{ label = "GL", patterns = { "gitlab", "gitlab.com" } },
	{ label = "TG", patterns = { "tangled", "tangled.org" } },
	{ label = "RAD", patterns = { "radicle", "rad://" } },
}

local function parse_forges(entry, result)
	local found = {}
	if result.code == 0 then
		local remotes = string.lower(result.stdout or "")
		for _, forge in ipairs(forge_definitions) do
			for _, pattern in ipairs(forge.patterns) do
				if remotes:find(pattern, 1, true) then
					table.insert(found, forge.label)
					break
				end
			end
		end
	end
	entry.forges = table.concat(found, " ")
	finish(entry)
end

local function refresh(root, entry)
	if entry.pending > 0 then
		return
	end

	local is_jj = vim.uv.fs_stat(root .. "/.jj") ~= nil
	entry.pending = is_jj and 2 or 1

	if is_jj then
		vim.system({
			"jj",
			"--ignore-working-copy",
			"--repository",
			root,
			"log",
			"--no-graph",
			"--revision",
			"@",
			"--template",
			'change_id.shortest(8) ++ "\\t" ++ bookmarks.join(",") ++ "\\t" ++ description.first_line() ++ "\\t" ++ if(conflict, "!", "") ++ "\\n"',
		}, { text = true }, function(result)
			parse_jj(entry, result)
		end)

		vim.system({
			"jj",
			"--ignore-working-copy",
			"--repository",
			root,
			"git",
			"remote",
			"list",
		}, { text = true }, function(result)
			parse_forges(entry, result)
		end)
	else
		entry.jj = nil
		vim.system({ "git", "-C", root, "remote", "--verbose" }, { text = true }, function(result)
			parse_forges(entry, result)
		end)
	end
end

local function current_entry()
	local root = buffer_root()
	if not root then
		return nil
	end

	local entry = cache[root]
	if not entry then
		entry = {
			pending = 0,
			updated_at = 0,
			jj = nil,
			forges = "",
		}
		cache[root] = entry
	end

	if now_ms() - entry.updated_at >= cache_ttl_ms then
		refresh(root, entry)
	end
	return entry
end

function M.jj()
	local entry = current_entry()
	if not entry or not entry.jj then
		return ""
	end

	local parts = { entry.jj.change_id }
	if entry.jj.bookmarks ~= "" then
		table.insert(parts, entry.jj.bookmarks)
	end
	if entry.jj.conflicted then
		table.insert(parts, "!")
	end

	if vim.o.columns >= 140 and entry.jj.description ~= "" then
		local description = entry.jj.description
		if #description > 28 then
			description = description:sub(1, 27) .. "…"
		end
		table.insert(parts, description)
	end

	return table.concat(parts, " ")
end

function M.forges()
	local entry = current_entry()
	return entry and entry.forges or ""
end

local group = vim.api.nvim_create_augroup("vcs_statusline", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
	group = group,
	callback = function(args)
		buffer_roots[args.buf] = nil
	end,
})

vim.api.nvim_create_autocmd({ "DirChanged", "FocusGained" }, {
	group = group,
	callback = function()
		buffer_roots = {}
		local root = buffer_root()
		if root and cache[root] then
			cache[root].updated_at = 0
		end
	end,
})

return M
