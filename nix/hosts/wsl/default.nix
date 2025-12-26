{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./modules/home
    ./modules/system.nix
  ];
}
