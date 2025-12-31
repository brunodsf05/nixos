{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg cfgRoot wrapInModule;
  mainUser = cfgRoot.system.host.main_user.name;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "Niri WM with DankMaterialShell";
  };

  config = lib.mkIf cfg.enable
  {
    # Niri WM
    programs.niri.enable = true;

    my.system.platform.home.imports = [
      ({ config, pkgs, ... }: let
        flakePath = "${config.home.homeDirectory}/nixos"; # TODO: Make flake path generated in a function from global.nix
        configPath = "${flakePath}/nix/modules/system/shell/gui/niri/config"; # WARNING: Is not dynamic so changes can break
        mkSymlink = relativePath: config.lib.file.mkOutOfStoreSymlink "${configPath}/${relativePath}";
      in {
        home.file.".config/niri/config.kdl".source = mkSymlink "config.kdl";
        home.file.".config/niri/own".source = mkSymlink "own";
        home.file.".config/niri/own".recursive = true;
      })
    ];

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
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/${mainUser}";
    };

    # Software
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}