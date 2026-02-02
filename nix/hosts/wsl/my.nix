{ config, global, inputs, lib, pkgs, ... }:

{
  my.system = {
    platform = {
      nixos.nh.enable = true;
      nixos.system.stateVersion = "25.05";

      home.enable = true;
      home.stateVersion = "25.11";
    };

    host = {
      main_user.name = "nixos";
    };
  };

  my.features = {
    development.editor.cli.enable = true;
    development.git.enable = true;
    development.tooling.enable = true;
    development.vscode_remote.enable = true;
  };
}
