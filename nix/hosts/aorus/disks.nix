{ ... }:

{
  fileSystems."/mnt/Data" = {
    device = "/dev/disk/by-uuid/963AE3FF3AE3DA6F";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1000" # TODO: Set to username?
      "gid=100"
      "nofail"
      "x-systemd.device-timeout=10"
      "x-gvfs-show" # Shows it in file explorer
    ];
  };
}
