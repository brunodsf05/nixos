{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg cfgRoot wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "NH nix-wrapper with an already set flake path";
  };

  config = lib.mkIf cfg.enable
  {
    programs.nh = {
      enable = true;
      flake = "/home/${cfgRoot.system.host.main_user.name}/nixos";
    };
  };
}
