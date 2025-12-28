{ config, pkgs, ... }:

{
  home-manager.users.nixos = {
    imports = [
      ./development.nix
    ];
  };
}
