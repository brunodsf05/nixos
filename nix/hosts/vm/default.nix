{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware_auto.nix
    ./system.nix
    ./my.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
