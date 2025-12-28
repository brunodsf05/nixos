{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "Enable the hello command.";
  };

  config = lib.mkIf cfg.enable
  {
    environment.systemPackages = with pkgs; [
      hello
    ];
  };
}