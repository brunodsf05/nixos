{ config, global, inputs, lib, pkgs, ... }:

{
  my.system = {
    home = {
      enable = true;
      stateVersion = "25.11";
    };

    host.main_user = {
      name = "nixos";
    };

    nixos = {
      nh.enable = true;
      system.stateVersion = "25.05";
    };

    shell.cli = {
      enable = true;
    };
  };

  my.features = {
    development = {
      git.enable = true;
      vscode_remote.enable = true;
    };
  };
}
