{ config, global, lib, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "enables preconfigured git and github";
  };

  config = lib.mkIf cfg.enable
  {
    my.home.imports = [
      ({ ... }: {
        programs.git = {
          enable = true;
          settings = {
            init.defaultBranch = "main";
            user.name = "brunodsf05";
            user.email = "231746160+brunodsf05@users.noreply.github.com";
          };
        };

        programs.gh = {
          enable = true;
        };
      })
    ];
  };
}
