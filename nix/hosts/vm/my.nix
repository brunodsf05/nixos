{ config, global, inputs, lib, pkgs, ... }:

{
  my.variables = {
    has.cli = true;
    has.gui = true;
  };

  my.system = {
    platform = {
      nixos.system.stateVersion = "25.11";
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
  };
}
