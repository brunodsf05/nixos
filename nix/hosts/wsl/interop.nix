{ pkgs, ... }:

let
  load-windows-vars = pkgs.writeShellScriptBin "load-windows-vars" ''
    set -eo pipefail

    /mnt/c/Windows/System32/cmd.exe /c "echo export WIN_USERNAME=%USERNAME%&echo export WIN_USERPROFILE=/mnt/c/Users/%USERNAME%" \
      2>/dev/null | tr -d '\r'
  '';

  whoami-windows = pkgs.writeShellScriptBin "whoami-windows" ''
    set -euo pipefail
    eval "$(load-windows-vars)"
    printf "%s\n" "$WIN_USERNAME"
  '';

in
{
  # Allow WSL to execute Windows binaries
  wsl.interop.register = true;
  wsl.interop.includePath = false;

  environment.systemPackages = [
    load-windows-vars
    whoami-windows

    (pkgs.writeShellScriptBin "code" ''
      set -euo pipefail
      eval "$(load-windows-vars)" && \
        exec "$WIN_USERPROFILE/AppData/Local/Programs/Microsoft VS Code/Code.exe" "$@"
    '')

    (pkgs.writeShellScriptBin "zed" ''
      set -euo pipefail
      eval "$(load-windows-vars)" && \
        exec "$WIN_USERPROFILE/AppData/Local/Programs/Zed/Zed.exe" "$@"
    '')
  ];
}
