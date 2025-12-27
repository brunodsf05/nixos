{ config, pkgs, ... }:

{
  system.stateVersion = "25.05";

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.interop.includePath = false;

  programs.nh = {
    enable = true;
    flake = "/home/nixos/nixos";
  };

  my.hello.enable = true;
  my.vscode_remote.enable = true;
}
