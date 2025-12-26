{ config, pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.nixos = {
    # Home Manager
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

    # Modules
    imports = [
      ./development.nix
      ./shell
    ];

    # Miscellaneous packages
    home.packages = with pkgs; [
    ];
  };
}
