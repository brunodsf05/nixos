{ config, global, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfgRoot;
  var = cfgRoot.variables;

  d = lib.mkDefault;
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

  ### SYSTEM ###
  my.system.environment.locale.enable = d true;
  my.system.environment.software.executable.enable = d true;

  my.system.platform.home.enable = d true;
  my.system.platform.nixos.nh.enable = d true;

  my.system.shell.cli.enable = d true;
  my.system.shell.gui.niri.enable = d var.has.gui;

  ### FEATURES ###
  my.features.apps.enable = d var.has.gui;

  my.features.development.editor.cli.enable = d true;
  my.features.development.editor.gui.enable = d var.has.gui;
  my.features.development.git.enable = d true;
  my.features.development.tooling.enable = d true;
}
