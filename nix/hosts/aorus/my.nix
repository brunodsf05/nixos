{ ... }:

{
  my.system = {
    boot = {
      limine.windows.uuid = "81ebe4b4-0fff-44d5-be82-26d142dc11d6";
    };

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

  my.features = {
    gaming.enable = true;
  };

  my.variables = {
    has.boot = true;
    has.cli = true;
    has.gui = true;
  };
}
