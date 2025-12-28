{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule null config) cfgRoot;
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./modules/home
  ];

  wsl.enable = true;
  wsl.defaultUser = cfgRoot.host.main_user.name;
  wsl.interop.includePath = false;

  my.nixos.nh.enable = true;
  my.nixos.system.stateVersion = "25.05";
  my.host.main_user.name = "nixos";
  my.home.enable = true;
  my.home.stateVersion = "25.11";
  my.vscode_remote.enable = true;
}
