{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule null config) cfgRoot;
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./interop.nix
    ./my.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = cfgRoot.system.host.main_user.name;
}
