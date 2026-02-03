{ ... }:

{
  my.features = {
    development.vscode_remote.enable = true;
  };

  my.system = {
    environment = {
      locale.enable = false;
      software.executable.enable = false;
    };

    host = {
      main_user.name = "nixos";
    };

    platform = {
      home.stateVersion = "25.11";
      nixos.system.stateVersion = "25.05";
    };
  };

  my.variables = {
    has.cli = true;
  };
}
