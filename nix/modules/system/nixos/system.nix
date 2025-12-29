{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "NixOS system.stateVersion value. This option must be set explicitly.";
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.stateVersion != "";
        message = "The option stateVersion must be set and cannot be empty.";
      }
    ];

    system.stateVersion = cfg.stateVersion;
  };
}
