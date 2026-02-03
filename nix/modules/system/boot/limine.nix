{ config, global, inputs, lib, pkgs, ... }:

let
  inherit (global.fun.mkModule __curPos.file config) cfg wrapInModule;
in
{
  options = wrapInModule {
    enable = lib.mkEnableOption "limine boot loader with some config";

    windows.uuid = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "d153e353-2a32-4763-b930-b27fbc980da5";
      description = ''
        If this value is set, a Windows entry will be added.
        This value must be PARTUUID of the disk with your Windows bootloader.
        To find your disks PARTUUID:
        1. Open a terminal.
        2. Execute: `lsblk -o NAME,PARTUUID,FSTYPE,FSVER,LABEL`.
        3. Copy the PARTUUID inside a partition with FSTYPE=vfat and FSVER=FAT32.
      '';
    };
  };

  config = lib.mkIf cfg.enable
  {
    boot.loader.efi.canTouchEfiVariables = true;

    boot.loader.limine = {
      enable = true;
      style = {
        graphicalTerminal.margin = 0;
        graphicalTerminal.marginGradient = 0;
        wallpapers = [];
      };

      # The value inside "uuid()" is known as PARTUUID can differ across PCs
      # Find your's with: lsblk -o NAME,PARTUUID,FSTYPE,FSVER,LABEL
      # Copy the PARTUUID inside a partition with FSTYPE=vfat FSVER=FAT32
      extraEntries = lib.mkIf (cfg.windows.uuid != null) ''
        /Windows
          protocol: efi_chainload
          path: uuid(${cfg.windows.uuid}):/EFI/Microsoft/Boot/bootmgfw.efi
      '';

      # Colors: [ 0: Black, 1: Red, 2: Green, 3: Yellow, 4: Blue, 5: Magenta, 6: Cyan, 7: Gray ]
      extraConfig = ''
        interface_help_color: 7
      '';
    };
  };
}
