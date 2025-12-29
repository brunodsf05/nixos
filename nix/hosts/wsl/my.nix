{ config, global, inputs, lib, pkgs, ... }:

{
  my.system.nixos = {
    nh.enable = true;
    system.stateVersion = "25.05";
  };

  my.system.shell.cli = {
    enable = true;
  };

  my.system.host.main_user = {
    name = "nixos";
  };

  my.system.home = {
    enable = true;
    stateVersion = "25.11";
  };

  my.features.development = {
    git.enable = true;
    vscode_remote.enable = true;
  };
}
