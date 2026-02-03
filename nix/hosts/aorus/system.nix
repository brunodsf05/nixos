# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Boot
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
