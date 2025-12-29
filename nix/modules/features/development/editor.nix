{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "gui code editors";
  };

  config = lib.mkIf cfg.enable
  {
    environment.systemPackages = with pkgs; [
      vscode-fhs
      zed-editor-fhs
      nerd-fonts.jetbrains-mono # editor
      nerd-fonts.cousine # terminal
    ];
  };
}