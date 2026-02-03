{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "programming tools";

    extra = {
      gui.enable = lib.mkEnableOption "GUI code editors" // { default = true; };
      arduino.enable = lib.mkEnableOption "GUI code editors" // { default = true; };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf cfg.extra.gui.enable { /* ... */ })
    {
      environment.systemPackages = lib.mkMerge [
        (lib.mkIf cfg.extra.gui.enable (with pkgs; [
          # Editors
          vscode-fhs
          zed-editor
        ]))
        (lib.mkIf (cfg.extra.gui.enable && cfg.extra.arduino.enable) (with pkgs; [
          # Editors
          arduino-ide
        ]))
        (with pkgs; [
          # Editors
          helix
          # LSPs
          nixd
          # SDKs
          nodejs_24
          pnpm
        ])
      ];
    }
  ]);
}
