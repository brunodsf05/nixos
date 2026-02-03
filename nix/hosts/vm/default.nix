{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule null config) cfgRoot;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./configuration.nix
    ./hardware_auto.nix
    ./system.nix
    ./my.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
