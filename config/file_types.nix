{
  autoGroups = {
    filetypes = {};
  };

  files."ftdetect/terraformft.lua".autoCmd = [
    {
      group = "filetypes";
      event = ["BufRead" "BufNewFile"];
      pattern = ["*.tf" " *.tfvars" " *.hcl"];
      command = "set ft=terraform";
    }
  ];
}
