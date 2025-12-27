rec {
  cfg = {
    path = {
      modules = ./nix/modules;
    };
  };

  fun = {
    mkModule = import ./nix/lib/mk_module.nix {
      prefix = "myfeatures";
      modulesPath = cfg.path.modules;
    };
  };
}