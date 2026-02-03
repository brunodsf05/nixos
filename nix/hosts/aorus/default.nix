{ inputs, ... }:

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
