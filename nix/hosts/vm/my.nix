{ config, global, inputs, lib, pkgs, ... }:

{
  my.system = {
    platform = {
      nixos.system.stateVersion = "25.11";

      home.enable = true;
      home.stateVersion = "25.11";
    };

    host = {
      main_user = {
        name = "bruno";
        config = {
          isNormalUser = true;
          extraGroups = [ "networkmanager" "wheel" ];
        };
      };
    };

    shell = {
      gui.niri.enable = true;
    };

    environment = {
      locale.enable = true;
      software.executable.enable = true;
    };
  };

  my.features = {
    apps.enable = true;
    development.editor.gui.enable = true;
    development.git.enable = true;
  };
}
