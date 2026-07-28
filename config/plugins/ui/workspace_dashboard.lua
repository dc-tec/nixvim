local M = {}

local icon_width = 4
local label_width = 52

function M.row(icon, key, label, action, label_highlight)
	local icon_text
	if type(icon) == "table" then
		icon_text = vim.tbl_extend("force", {}, icon, { width = icon_width })
	else
		icon_text = { icon, hl = "icon", width = icon_width }
	end

	return {
		align = "center",
		key = key,
		action = action,
		text = {
			icon_text,
			{ label, hl = label_highlight or "desc", width = label_width },
			{ key, hl = "key" },
		},
	}
end

local function root()
	local cwd = vim.uv.cwd()
	return (cwd and vim.fs.root(cwd, { ".jj", ".git" })) or cwd
end

function M.summary()
	return {
		align = "center",
		padding = 1,
		text = { { require("vcs_status").context(), hl = "file" } },
	}
end

function M.recent_files()
	local items = {}
	local repository_root = root()
	local oldfiles_opts = repository_root and { filter = { [repository_root] = true } } or nil

	for file in Snacks.dashboard.oldfiles(oldfiles_opts) do
		local number = #items + 1
		local display = (repository_root and vim.fs.relpath(repository_root, file))
			or vim.fn.fnamemodify(file, ":~")

		if #display > 50 then
			display = vim.fn.pathshorten(display)
		end
		if #display > 50 then
			display = "…" .. display:sub(-49)
		end

		table.insert(
			items,
			M.row(
				Snacks.dashboard.icon(file, "file"),
				tostring(number),
				display,
				":edit " .. vim.fn.fnameescape(file),
				"file"
			)
		)

		if #items == 4 then
			break
		end
	end

	return items
end

return M
