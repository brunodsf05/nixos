{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    ./modules/home
  ];

  system.stateVersion = "25.05";

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.interop.includePath = false;

  my.nixos.nh.enable = true;
  my.host.main_user.name = "nixos";
  my.vscode_remote.enable = true;
}
