{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule null config) cfgRoot;
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./my.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = cfgRoot.host.main_user.name;
  wsl.interop.includePath = false;
}
