{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    # lib.mkEnableOption generates a description like "Whether to enable ${description}."
    enable = lib.mkEnableOption "plymouth for showing a logo during boot";
  };

  config = lib.mkIf cfg.enable
  {
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

    # Enable "Silent boot"
    boot = {
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];
    };
  };
}
