{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    nvim-web-devicons
  ];
}
