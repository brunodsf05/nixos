{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg cfgRoot wrapInModule;
  mainUser = cfgRoot.host.main_user.name;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "HomeManager for the mainUser";
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Sets the value for `home-manager.users.\${mainUser}.home.stateVersion`. Set and keep the value to the release of HM you've installed.";
    };
  };

  config = lib.mkIf cfg.enable
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.users.${mainUser} = {
      home.stateVersion = cfg.stateVersion;
      programs.home-manager.enable = true;
    };
  };
}