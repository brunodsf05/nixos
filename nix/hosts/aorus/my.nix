{ config, global, inputs, lib, pkgs, ... }:

{
  my.system = {
    host = {
      main_user = {
        config = {
          extraGroups = [ "networkmanager" "wheel" ];
          isNormalUser = true;
        };
      };
    };

    platform = {
      home.stateVersion = "25.11";
      nixos.system.stateVersion = "25.11";
    };
  };

  my.variables = {
    has.cli = true;
    has.gui = true;
  };
}
