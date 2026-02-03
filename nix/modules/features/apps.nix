{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "my apps";
  };

  config = lib.mkIf cfg.enable
  {
    environment.systemPackages = with pkgs; [
      gearlever
      gimp
      inkscape
      keepassxc
      qbittorrent
      # stremio
      thunderbird
      # upscaler
    ];

    programs.firefox.enable = true;
  };
}
