{ ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
