{ config, pkgs, ... }:

{
  system.stateVersion = "25.05";

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.interop.includePath = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.nh = {
    enable = true;
    flake = "/home/nixos/nixos";
  };

  programs.nix-ld.enable = true;
}
