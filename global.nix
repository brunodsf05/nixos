rec {
  cfg = {
    path = {
      modules = ./nix/modules;
    };
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