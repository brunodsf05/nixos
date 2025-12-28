{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "cosmic desktop";
  };

  config = lib.mkIf cfg.enable
  {
    services.displayManager.cosmic-greeter.enable = true;

    services.desktopManager.cosmic.enable = true;
    services.desktopManager.cosmic.xwayland.enable = true;

    # Software
    environment.cosmic.excludePackages = with pkgs; [
      cosmic-player
      cosmic-store
      cosmic-term
    ];

    environment.systemPackages = with pkgs; [
      kitty
      bazaar
    ];
  };
}