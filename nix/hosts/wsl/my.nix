{ config, global, inputs, lib, pkgs, ... }:

{
  my.nixos = {
    nh.enable = true;
    system.stateVersion = "25.05";
  };

  my.host.main_user = {
    name = "nixos";
  };

  my.home = {
    enable = true;
    stateVersion = "25.11";
  };

  my.vscode_remote.enable = true;
}