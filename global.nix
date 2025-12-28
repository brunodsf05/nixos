rec {
  cfg = {
    os.name = "neosh";
    path = {
      modules = ./nix/modules;
    };
    mainUser.config = {
      description = "Bruno";
    };
  };

  log = import ./nix/lib/logger.nix {
    prefix = cfg.os.name;
    suffixes = [
      "config"
      "flatpak"
      "import"
      "info"
      "error"
    ];
  };

  fun = {
    mkModule = import ./nix/lib/mk_module.nix {
      prefix = "my";
      modulesPath = cfg.path.modules;
    };

    importModules = (
      let
        getModules = import ./nix/lib/get_modules.nix {
          lastmodFilename = ".lastmod";
          logger = path: "[import] ${path}";
        };
      in
        map import (getModules cfg.path.modules)
    );
  };
}