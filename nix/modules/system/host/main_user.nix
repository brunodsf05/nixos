{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;

  userConfigDefaults = global.cfg.mainUser.config;

  generatedConfig =
    lib.mkIf (cfg.config != null) (
      lib.mkMerge [
        userConfigDefaults
        cfg.config
      ]
    );
in
{
  options = wrapInModule {
    name = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The name of the main user.";
    };

    config = lib.mkOption {
      type = lib.types.nullOr lib.types.attrs;
      default = null;
      description = ''
        Alias of "users.users.''${cfg.name}".

        By default this option is not declared `null`, meaning that no user
        configuration is added.

        When this option is declared as an attribute set, its contents are
        merged with the `userConfigDefaults`. This allows extending or
        adjusting the final user definition without redefining it entirely.
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

    users.users.${cfg.name} = generatedConfig;
  };
}