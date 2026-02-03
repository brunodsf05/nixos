{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    gui.enable = lib.mkEnableOption "GUI code editors";
    cli.enable = lib.mkEnableOption "CLI code editors";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.cli.enable { /* ... */ })
    (lib.mkIf cfg.gui.enable { /* ... */ })
    {
      environment.systemPackages = lib.mkMerge [
        (lib.mkIf cfg.gui.enable (with pkgs; [
          vscode-fhs
          zed-editor-fhs
        ]))
        [
          # Editors
          helix
          # SDKs
          nodejs_24
          pnpm
        ]
      ];
    }
  ];
}
