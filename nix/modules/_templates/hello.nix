{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    # lib.mkEnableOption generates a description like "Whether to enable ${description}."
    enable = lib.mkEnableOption "hello command";
  };

  config = lib.mkIf cfg.enable
  {
    environment.systemPackages = with pkgs; [
      hello
    ];
  };
}