{ config, global, inputs, lib, pkgs, ... }:

# This file defines variables that are read by `automatic.nix`.
# The values are set per-host in `./<host>/my.nix`.

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    has.cli = lib.mkEnableOption "flag that tells if the host has a CLI";
    has.gui = lib.mkEnableOption "flag that tells if the host has a GUI";
  };
}
