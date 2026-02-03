{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule null config) cfgRoot;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./disks.nix
    ./hardware_auto.nix
    ./hardware_manual.nix
    ./my.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
