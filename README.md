# NixOS

Welcome to my personal **dotfiles**!

![Fastfetch on WSL2](/docs/screenshot.png)

Right now it declares a [WSL](https://learn.microsoft.com/en-us/windows/wsl/about) terminal with tools, aliases and more.

## Instalation

Copy the line below in a terminal. This will clone the flake and start the install script:
```sh
nix-shell -p git --run "cd ~ && git clone https://github.com/brunodsf05/nixos.git && ~/nixos/install.sh"
```