{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware_auto.nix
    ./hardware_manual.nix
    ./my.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
}
