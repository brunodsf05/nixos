{ config, global, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

  my.system.shell.cli.enable = lib.mkDefault true;
}
