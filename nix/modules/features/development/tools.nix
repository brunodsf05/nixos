{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "programming tools";

    extra = {
      gui.enable = lib.mkEnableOption "GUI code editors" // { default = true; };
    };
  };

  config = lib.mkIf cfg.enable lib.mkMerge [
    (lib.mkIf cfg.extra.gui.enable { /* ... */ })
    {
      environment.systemPackages = lib.mkMerge [
        (lib.mkIf cfg.extra.gui.enable (with pkgs; [
          # Editors
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
