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

  system.stateVersion = "25.05";

  wsl.enable = true;
  wsl.defaultUser = cfgRoot.host.main_user.name;
  wsl.interop.includePath = false;

  my.nixos.nh.enable = true;
  my.host.main_user.name = "nixos";
  my.vscode_remote.enable = true;
}
