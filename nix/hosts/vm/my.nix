{ config, global, inputs, lib, pkgs, ... }:

{
  my.nixos = {
    nh.enable = true;
    system.stateVersion = "25.11";
  };

  my.system.shell.cli = {
    enable = true;
  };

  my.system.shell.gui = {
    cosmic.enable = true;
  };

  my.system.host.main_user = {
    name = "bruno";
    config = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  my.system.software.executable = {
    enable = true;
  };

  my.system.home = {
    enable = true;
    stateVersion = "25.11";
  };

  my.development = {
    git.enable = true;
    vscode_remote.enable = true;
  };
}
