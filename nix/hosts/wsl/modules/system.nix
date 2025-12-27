{ config, pkgs, ... }:

{
  system.stateVersion = "25.05";

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.interop.includePath = false;

  my.nixos.nh.enable = true;
  my.host.main_user.name = "nixos";
  my.hello.enable = true;
  my.vscode_remote.enable = true;
}
