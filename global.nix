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
  };
}