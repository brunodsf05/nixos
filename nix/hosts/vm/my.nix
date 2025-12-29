{ config, global, inputs, lib, pkgs, ... }:

{
  my.system = {
    home = {
      enable = true;
      stateVersion = "25.11";
    };

    host.main_user = {
      name = "bruno";
      config = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };

    locale = {
      enable = true;
    };

    nixos = {
      nh.enable = true;
      system.stateVersion = "25.11";
    };

    shell.cli = {
      enable = true;
    };

    shell.gui = {
      cosmic.enable = true;
    };

    software.executable = {
      enable = true;
    };
  };

  my.features = {
    development = {
      git.enable = true;
    };
  };
}
