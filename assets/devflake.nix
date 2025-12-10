{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    ...
  }:

  let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forEachSystem =
      mkAttrset:
      nixpkgs.lib.genAttrs supportedSystems (
        system:
        mkAttrset {
          inherit inputs;
          inherit system;
          pkgs = nixpkgs.legacyPackages.${system};
        }
      );
  in
  {
    devShells = forEachSystem (
      {
        pkgs,
        ...
      }:
 
      {
        # NoCC means don't install C toolchain
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            cowsay
            (writeShellScriptBin "mycommand" ''
              echo "Custom command"
            '')
          ];

          env = {
            MYVAR = "Hello :)";
          };

          shellHook = ''
            echo "MYVAR = $MYVAR"
            echo "Loading environment..."
            cowsay "Mooo!"
          '';
        };
      }
    );
  };
}
