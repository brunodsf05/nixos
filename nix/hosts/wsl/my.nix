{ config, global, inputs, lib, pkgs, ... }:

{
  my.variables = {
    has.cli = true;
  };

  my.system = {
    platform = {
      nixos.system.stateVersion = "25.05";

      home.enable = true;
      home.stateVersion = "25.11";
    };

    host = {
      main_user.name = "nixos";
    };

    environment = {
      locale.enable = false;
      software.executable.enable = false;
    };
  };

  my.features = {
    development.vscode_remote.enable = true;
  };
}
