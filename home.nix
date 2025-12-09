{ config, pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.nixos = {
    # Home Manager
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;

    # Miscellaneous packages
    home.packages = with pkgs; [
      bat
    ];

    # Development
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user.name = "brunodsf05";
        user.email = "brunodsf05.profesional@gmail.com";
      };
    };

    # Shell
    home.shellAliases = {
      c = "clear";
      cd = "z";
      ff = "fastfetch";
      gs = "git status";
    };

    home.sessionVariables = {
      EDITOR = "micro";
      VISUAL = "micro";
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
    };

    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      icons = "auto";
    };

    programs.fastfetch = {
      enable = true;
      settings = import ./dotfiles/fastfetch.nix;
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.micro = {
      enable = true;
      settings = {
      	mkparents = true;
      	colorscheme = "cmc-16";
      };
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = import ./dotfiles/starship.nix;
    };

    programs.yazi = {
      enable = true;
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      # flags = [
      #   "--cmd cd"
      # ];
    };

    # End of config
  };
}
