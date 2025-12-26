{ config, pkgs, ... }:

{
  # Version control
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "brunodsf05";
      user.email = "231746160+brunodsf05@users.noreply.github.com";
    };
  };

  programs.gh = {
    enable = true;
  };
}
