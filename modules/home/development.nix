{ config, pkgs, ... }:

{
  # Version control
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "brunodsf05";
      user.email = "brunodsf05.profesional@gmail.com";
    };
  };

  programs.gh = {
    enable = true;
  };
}
