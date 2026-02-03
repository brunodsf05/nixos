{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfgRoot;
  var = cfgRoot.variables;
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

  ### SYSTEM ###
  my.system.platform.nixos.nh.enable = lib.mkDefault true;
  my.system.platform.home.enable = lib.mkDefault true;

  my.system.shell.cli.enable = lib.mkDefault true;
  my.system.shell.gui.enable = lib.mkDefault var.has.gui;

  my.system.environment.locale.enable = lib.mkDefault true;
  my.system.environment.software.executable.enable = lib.mkDefault true;

  ### FEATURES ###
  my.features.development.editor.cli.enable = true;
  my.features.development.git.enable = lib.mkDefault true;
  my.features.development.tooling.enable = true;
}
