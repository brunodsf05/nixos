{ config, global, inputs, lib, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "flatpak and a wrapper to install software to `main_user`";

    packages = lib.mkOption {
      description = "Flatpak packages to install (string appId or attribute set)";
      default = [ ];
      type = lib.types.listOf (
        lib.types.oneOf [
          lib.types.str
          (lib.types.submodule {
            options = {
              appId = lib.mkOption {
                type = lib.types.str;
                description = "Flatpak application ID";
              };

              origin = lib.mkOption {
                type = lib.types.str;
                default = "flathub";
                description = "Flatpak remote";
              };
            };
          })
        ]
      );
    };
  };

  config = lib.mkIf cfg.enable
  {
    services.flatpak.enable = true;

    my.system.platform.home.imports = [
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ({ ... }: {
        services.flatpak.packages = cfg.packages;
      })
    ];
  };
}
