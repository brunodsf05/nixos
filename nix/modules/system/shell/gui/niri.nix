{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "Niri WM with DankMaterialShell";
  };

  config = lib.mkIf cfg.enable
  {
    # Niri WM
    programs.niri.enable = true;

    # DankMaterialShell
    programs.dms-shell = {
      enable = true;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableSystemMonitoring = true;
      enableClipboard = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };

    programs.dsearch = {
      enable = true;

      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
    };

    # DankGreeter
    programs.dms-greeter.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "dms-greeter";
          user = "greeter";
        };
      };
    };
  };
}