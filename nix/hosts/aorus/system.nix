# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine = {
    enable = true;
    style = {
      graphicalTerminal.margin = 0;
      graphicalTerminal.marginGradient = 0;
      wallpapers = [];
    };

    # The value inside "uuid()" is known as PARTUUID can differ across PCs
    # Find your's with: lsblk -o NAME,PARTUUID,FSTYPE,FSVER,LABEL
    # Copy the PARTUUID inside a partition with FSTYPE=vfat FSVER=FAT32
    extraEntries = ''
      /Windows
        protocol: efi_chainload
        path: uuid(81ebe4b4-0fff-44d5-be82-26d142dc11d6):/EFI/Microsoft/Boot/bootmgfw.efi
    '';

    # Colors: [ 0: Black, 1: Red, 2: Green, 3: Yellow, 4: Blue, 5: Magenta, 6: Cyan, 7: Gray ]
    extraConfig = ''
      interface_help_color: 7
    '';
  };

  # Themes names at:
  # https://github.com/NixOS/nixpkgs/blob/nixos-25.11/pkgs/by-name/ad/adi1090x-plymouth-themes/shas.nix
  boot.plymouth = let theme = "hexagon_2"; in {
    enable = true;
    theme = theme;
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ theme ];
      })
    ];
  };

  boot = {
    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Input/Output
  networking.networkmanager.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Software
  programs.firefox.enable = true;
}
