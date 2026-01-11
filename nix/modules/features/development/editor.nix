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
    (lib.mkIf cfg.gui.enable {
      environment.systemPackages = with pkgs; [
        vscode-fhs
        zed-editor-fhs
        nerd-fonts.jetbrains-mono # editor
        nerd-fonts.cousine # terminal
      ];
    })

    (lib.mkIf cfg.cli.enable {
      environment.systemPackages = with pkgs; [
        helix
      ];
    })
  ];
}