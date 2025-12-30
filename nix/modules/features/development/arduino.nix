{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "Arduino SDK";
  };

  config = lib.mkIf cfg.enable
  {
    environment.systemPackages = with pkgs; [
      arduino-ide
    ];
  };
}