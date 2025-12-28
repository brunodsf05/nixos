{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;

  useIfWritten = optionName: value:
    lib.mkIf (value != "") (
      global.log.trace.info "${optionName} is set to \"${value}\""
      value
    );
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "my locale preferences";

    overrides = {
      language = lib.mkOption {
        type = lib.types.str;
        default = "es_ES.UTF-8";
        description = "Locale to use for 'i18n.defaultLocale' and 'i18n.extraLocaleSettings.<OPT>'.";
      };

      timeZone = lib.mkOption {
        type = lib.types.str;
        default = "Europe/Madrid";
        description = "Location set to 'time.timeZone'.";
      };

      forceEnglishXdgFolders = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "The creation and use of English XDG folders.";
      };
    };
  };

  config = lib.mkIf cfg.enable
  {
    # Time zone
    time.timeZone = useIfWritten "Time zone" cfg.overrides.timeZone;

    # Language
    i18n.defaultLocale = useIfWritten "Locale language" cfg.overrides.language;
    i18n.extraLocaleSettings = (
      let
        lang = cfg.overrides.language;
      in
        lib.mkIf (lang != "") {
          LC_ADDRESS = lang;
          LC_IDENTIFICATION = lang;
          LC_MEASUREMENT = lang;
          LC_MONETARY = lang;
          LC_NAME = lang;
          LC_NUMERIC = lang;
          LC_PAPER = lang;
          LC_TELEPHONE = lang;
          LC_TIME = lang;
        }
    );

    # English XDG folders
    my.home.imports = lib.mkIf cfg.overrides.forceEnglishXdgFolders [
      ({ config, ... }: {
        xdg.userDirs = {
          enable = true;
          createDirectories = true;
          # By default, each folder's name is in english
        };
      })
    ];
  };
}