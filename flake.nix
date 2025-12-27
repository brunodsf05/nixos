{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.11";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    ...
  }:
  let
    global = import ./global.nix;

    automaticallyImportedModules = (
      inputs.import-tree global.cfg.path.modules
    );

    mkHost = host: system: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        inherit global;
      };
      modules = [
        { imports = [(automaticallyImportedModules)]; }
        ./nix/hosts/${host}
        { networking.hostName = host; }
      ];
    };
  in
  {
    nixosConfigurations = {
      wsl = mkHost "wsl" "x86_64-linux";
    };
  };
}
