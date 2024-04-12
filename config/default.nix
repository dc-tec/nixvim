{ config, lib, ...}: {
  
  imports = [
    ./settings.nix
    ./keymaps.nix

    ./plugins/themes/default.nix
  ];
}
