{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    name = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The name of the main user.";
    };

    config = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = ''
        Alias of "users.users.${cfg.name}".

        The contents are applied directly to the user definition.
        Defaults must be provided elsewhere using mkDefault.
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.name != "";
        message = "You must set the main user's name.";
      }
    ];

    users.users.${cfg.name} = cfg.config;
  };
}
