{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg cfgRoot wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "opinionated shell configuration and utilities";
  };

  config = lib.mkIf cfg.enable
  {
    my.system.platform.home.imports = [
      ./module.nix
    ];
  };
}