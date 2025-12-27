# NixOS

Welcome to my personal **dotfiles**!

![Fastfetch on WSL2](/docs/screenshot.png)

Right now it declares a [WSL](https://learn.microsoft.com/en-us/windows/wsl/about) terminal with tools, aliases and more.

## Installation

### Requirements

-   You must already have **NixOS** installed.
-   The installer must be executed as the **main user of the system profile**.
-   Running the installer from a **TTY** is strongly recommended  
    (avoid running it inside a desktop environment, as it may cause issues).

### Usage

Run the following command in a terminal:

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/brunodsf05/nixos/main/install.sh)
```

This will automatically:
1.  **Clone** this flake's repository to `$HOME/nixos`.
2.  Prompt you to **select a profile**.
3.  **Rebuild the system** and immediately switch to it.