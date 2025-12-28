{
  format = "$os $all";
  username = {
    detect_env_vars = [ ];
    format = "[$user]($style) ";
    style_root = "red bold";
    style_user = "yellow bold";
    show_always = false;
    disabled = false;
    aliases = {
      Administrator = "󰢏";
    };
  };
  os = {
    style = "bright-yellow";
    disabled = false;
    symbols.NixOS = "";
  };
}
