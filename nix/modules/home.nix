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

    imports = lib.mkOption {
      type = lib.types.listOf lib.types.deferredModule;
      default = [];
      description = "Home Manager modules imported into the mainUser.";
    };
  };

  config = lib.mkIf cfg.enable
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "hm-bak";

    home-manager.users.${mainUser} = {
      imports = cfg.imports;
      home.stateVersion = cfg.stateVersion;
    };
  };
}