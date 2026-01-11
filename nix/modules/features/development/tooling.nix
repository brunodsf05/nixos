{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "compilers and sdks";
  };

  config = lib.mkIf cfg.enable
  {
    environment.systemPackages = with pkgs; [
      nodejs_24
    ];
  };
}