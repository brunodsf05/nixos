{ config, global, lib, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfgRoot;
  var = cfgRoot.variables;

  d = lib.mkDefault;
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

  ### SYSTEM ###
  my.system.boot.limine.enable = d var.has.boot;
  my.system.boot.plymouth.enable = d var.has.boot;

  my.system.environment.locale.enable = d true;
  my.system.environment.software.executable.enable = d true;

  my.system.host.main_user.config.description = d "Bruno";
  my.system.host.main_user.name = d "bruno";

  my.system.platform.home.enable = d true;
  my.system.platform.nixos.nh.enable = d true;

  my.system.shell.cli.enable = d true;
  my.system.shell.gui.cosmic.enable = d var.has.gui;
  # my.system.shell.gui.niri.enable = d var.has.gui;

  ### FEATURES ###
  my.features.apps.enable = d var.has.gui;

  my.features.development.git.enable = d true;
  my.features.development.tools.enable = d true;
  my.features.development.tools.extra.gui.enable = d var.has.gui;

  my.features.fonts.enable = d var.has.gui;
}
