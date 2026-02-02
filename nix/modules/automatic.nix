{ config, global, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

  my.system.platform.nixos.nh.enable = lib.mkDefault true;
  my.system.shell.cli.enable = lib.mkDefault true;
}
