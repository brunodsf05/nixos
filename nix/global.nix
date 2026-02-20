# This file contains global vars not meant for configuration.
# If you want global configuration go to `./modules/automatic.nix`.

rec {
  cfg = {
    os.name = "neosh";
    path = {
      modules = ./modules;
    };
  };

  log = import ./lib/logger.nix {
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
    mkModule = import ./lib/mk_module.nix {
      prefix = "my";
      modulesPath = cfg.path.modules;
    };

    mkRelPath = import ./lib/mk_relpath.nix {
      rootStorePath = ./.;
    };

    importModules = (
      let
        getModules = import ./lib/get_modules.nix {
          lastmodFilename = ".lastmod";
          logger = path: log.msg.import path;
        };
      in
        map import (getModules cfg.path.modules)
    );
  };
}
