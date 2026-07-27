{
  autoGroups = {
    filetypes = { };
  };

  files."ftdetect/terraformft.lua".autoCmd = [
    {
      group = "filetypes";
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [
        "*.tf"
      ];
      command = "setlocal filetype=terraform";
    }
    {
      group = "filetypes";
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [ "*.tfvars" ];
      command = "setlocal filetype=opentofu-vars";
    }
    {
      group = "filetypes";
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [ "*.tofu" ];
      command = "setlocal filetype=opentofu";
    }
    {
      group = "filetypes";
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [ "*.hcl" ];
      command = "setlocal filetype=hcl";
    }
  ];

  files."ftdetect/bicepft.lua".autoCmd = [
    {
      group = "filetypes";
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [
        "*.bicep"
        "*.bicepparam"
      ];
      command = "setlocal filetype=bicep";
    }
  ];
}
