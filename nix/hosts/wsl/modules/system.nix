{ config, pkgs, ... }:

{
  system.stateVersion = "25.05";

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.interop.includePath = false;

  # TODO: Move all of this and make it global
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];

  environment.systemPackages = with pkgs; [
  	wget
  ];

  programs.nh = {
    enable = true;
    flake = "/home/nixos/nixos";
  };

  programs.nix-ld.enable = true;
}
