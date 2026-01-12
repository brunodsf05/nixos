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
    my.system.platform.home.imports = [
      ({ pkgs, ... }: {
        programs.git = {
          enable = true;
          settings = {
            init.defaultBranch = "main";
            user.name = "brunodsf05";
            user.email = "231746160+brunodsf05@users.noreply.github.com";
            alias.authors = "shortlog -s -n -e";
          };
        };

        programs.gh = {
          enable = true;
        };

        home.packages = with pkgs; [
          git-filter-repo
        ];
      })
    ];
  };
}
