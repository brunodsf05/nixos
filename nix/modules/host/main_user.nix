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
  };

  config = {
    assertions = [
      {
        assertion = cfg.name != "";
        message = "You must set the main user's name.";
      }
    ];
  };
}