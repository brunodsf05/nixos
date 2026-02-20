{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "opinionated shell configuration and utilities";
  };

  config = lib.mkIf cfg.enable
  {
    programs.fish.enable = true;
    my.system.host.main_user.config.shell = pkgs.fish;

    my.system.platform.home.imports = [
      ./module.nix
    ];
  };
}
