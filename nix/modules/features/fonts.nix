{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "my favourite fonts";
  };

  config = lib.mkIf cfg.enable
  {
    fonts.packages = [
      pkgs.nerd-fonts.cousine # terminal
      pkgs.nerd-fonts.jetbrains-mono # editor
    ];
  };
}
