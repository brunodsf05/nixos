{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
  logTrace = global.log.trace.info;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "execution of non-nix binaries and AppImages";
  };

  config = lib.mkIf cfg.enable
  {
    environment.systemPackages = with pkgs; logTrace "appimage-run is enabled!" [
      appimage-run
    ];

    programs.nix-ld.enable = logTrace "Dinamically-linked binaries are supported!" true;
  };
}
