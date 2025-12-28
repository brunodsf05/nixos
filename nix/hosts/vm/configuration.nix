{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Software
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
  	brave
  ];

  # Networking
  networking.networkmanager.enable = true;

  # Keyboard
  console.keyMap = "es";

  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Hardware
  virtualisation.vmware.guest.enable = true;
}
