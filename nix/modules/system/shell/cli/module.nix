{ pkgs, ... }:

{
  # Shell
  home.sessionVariables = {
    EDITOR = "micro";
    VISUAL = "micro";
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      # General
      c = "clear";
      ff = "fastfetch";
      cff = "clear && fastfetch";
      # Git
      gita = "git add .";
      gitc = { expansion = "git commit -m '%'"; setCursor = true; };
      gitca = "git commit --amend";
      gitl = "git log --all --graph --oneline";
      gits = "git status";
    };
    interactiveShellInit = ''
      set -U fish_greeting
    '';
  };

  # Software
  home.packages = with pkgs; [
    bat
  ];

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
  };

  programs.fastfetch = {
    enable = true;
    settings = import ./settings/fastfetch.nix;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
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
    enableFishIntegration = true;
    settings = import ./settings/starship.nix;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    # flags = [
    #   "--cmd cd"
    # ];
  };
}
