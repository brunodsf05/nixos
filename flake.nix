{
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  # #                                                                       # #
  # #          888b    888                    .d8888b.  888    888          # #
  # #          8888b   888                   d88P  Y88b 888    888          # #
  # #          88888b  888                   Y88b.      888    888          # #
  # #          888Y88b 888  .d88b.   .d88b.   "Y888b.   8888888888          # #
  # #          888 Y88b888 d8P  Y8b d88""88b     "Y88b. 888    888          # #
  # #          888  Y88888 88888888 888  888       "888 888    888          # #
  # #          888   Y8888 Y8b.     Y88..88P Y88b  d88P 888    888          # #
  # #          888    Y888  "Y8888   "Y88P"   "Y8888P"  888    888          # #
  # #                                                                       # #
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    global = import ./global.nix;

    mkHost = host: system: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        inherit global;
      };
      modules = [
        { imports = global.fun.importModules; }
        ./nix/hosts/${host}
        { networking.hostName = host; }
      ];
    };
  in
  {
    nixosConfigurations = {
      wsl = mkHost "wsl" "x86_64-linux";
      vm = mkHost "vm" "x86_64-linux";
    };
  };
}
