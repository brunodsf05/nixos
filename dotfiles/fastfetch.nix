{
  "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

  logo = {
    # type = "file";
    # source = (builtins.toFile "fastfetch_logo.txt" "");
    source = "linux";
  };

  display = {
    separator = "";
    key = {
      width = 15;
    };
  };

  modules = [
    {
      # user
      key = " user";
      type = "title";
      format = "{user-name}";
      keyColor = "31";
    }
    {
      # hostname
      key = "󰇅 hname";
      type = "title";
      format = "{host-name}";
      keyColor = "32";
    }
    {
      # uptime
      key = "󰅐 uptime";
      type = "uptime";
      keyColor = "33";
    }
    {
      # distro
      key = "{icon} distro";
      type = "os";
      keyColor = "34";
    }
    {
      # kernel
      key = " kernel";
      type = "kernel";
      keyColor = "35";
    }
    {
      # desktop environment
      key = "󰇄 desktop";
      type = "de";
      keyColor = "36";
    }
    {
      # terminal
      key = " term";
      type = "terminal";
      keyColor = "31";
    }
    {
      # shell
      key = " shell";
      type = "shell";
      keyColor = "32";
    }
    {
      # cpu
      key = "󰍛 cpu";
      type = "cpu";
      showPeCoreCount = true;
      keyColor = "33";
    }
    {
      # disk
      key = "󰉉 disk";
      type = "disk";
      folders = "/";
      keyColor = "34";
    }
    {
      # memory
      key = " memory";
      type = "memory";
      keyColor = "35";
    }
    {
      # network
      key = "󰩟 network";
      type = "localip";
      format = "{ipv4} ({ifname})";
      keyColor = "36";
    }
    {
      # colors
      key = " colors";
      type = "colors";
      symbol = "circle";
      keyColor = "39";
    }
  ];
}
