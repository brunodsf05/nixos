{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "compatibility to become a VScode Remote features.development host";
  };

  config = lib.mkIf cfg.enable
  {
    programs.nix-ld.enable = true;

    environment.systemPackages = with pkgs; [
      wget
    ];
  };
}