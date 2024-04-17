{ config, lib, ...}: {
  
  imports = [
    # General Configuration
    ./settings.nix
    ./keymaps.nix
  
    # Themes
    ./plugins/themes/default.nix

    # Editor plugins and configurations
    ./plugins/editor/neo-tree.nix
    ./plugins/editor/treesitter.nix

    # Git
    ./plugins/git/lazygit.nix

    # Utils
    ./plugins/utils/telescope.nix
  ];
}
