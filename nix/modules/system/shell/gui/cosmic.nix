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

    /* TODO: Reenable later
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

    # Default applications
    environment.sessionVariables = {
      TERMINAL = "kitty";
      XTERM = "kitty";
    };

    xdg = (
      let
        app = {
          browser = "firefox.desktop";
          terminal = "kitty.desktop";
        };
      in
      {
        mime = {
          enable = true;
          defaultApplications = {
            "text/html" = app.browser;
            "x-scheme-handler/http" = app.browser;
            "x-scheme-handler/https" = app.browser;
            "application/x-terminal-emulator" = app.terminal;
          };
        };

        terminal-exec = {
          enable = true;
          settings = {
            default = [
              app.terminal
            ];
          };
        };
      }
    );
    */
  };
}
