{ config, pkgs, ... }:

{
  system.stateVersion = "25.05";

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.interop.includePath = false;

  environment.systemPackages = with pkgs; [
  	wget
  ];

  programs.nh = {
    enable = true;
    flake = "/home/nixos/nixos";
  };

  programs.nix-ld.enable = true;

  myfeatures.hello.enable = true;
}
