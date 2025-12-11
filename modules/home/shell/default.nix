{ config, pkgs, ... }:

{
  # Shell
  home.shellAliases = {
    c = "clear";
    cd = "z";
    ff = "fastfetch";
    gita = "git add .";
    gitc = "git commit -m";
    gitl = "git log --all --graph --oneline";
    gits = "git status";
  };

  home.sessionVariables = {
    EDITOR = "micro";
    VISUAL = "micro";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d '\' cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }
    '';
  };

  # Software
  home.packages = with pkgs; [
    bat
  ];

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    icons = "auto";
  };

  programs.fastfetch = {
    enable = true;
    settings = import ./settings/fastfetch.nix;
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
    settings = import ./settings/starship.nix;
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
}
