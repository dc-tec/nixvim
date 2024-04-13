{ config, lib, ...}: {
  
  imports = [
    # General Configuration
    ./settings.nix
    ./keymaps.nix
  
    # Themes
    ./plugins/themes/default.nix

    # Syntax Highlighting
    ./plugins/treesitter/default.nix

    # Git
    ./plugins/git/lazygit.nix

    # Utils
    ./plugins/utils/telescope.nix
  ];
}
