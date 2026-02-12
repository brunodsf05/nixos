/*****************************************************************************\
The `mkRelPath` is a function that receives a store path and converts it to a
string which is a relative path to another store path.

The common use case for this is to generate relative paths from your flake's
root folder.

This is useful when working with things like home manager and you want to
symlink some file inside your flake's folder.

Here is an example, you want to use symlinks to your "niri" dots.
Normally you must use some function like `mkSymlink` which receives a string.
There are two ways to tell `mkSymlink` what file to symlink.
```nix
# ./modules/niri/default.nix

flakeAbsPath = "/home/user/dotfiles"

method1 = "${flakeAbsPath}/modules/niri/dots/config.kdl"
method2 = "${flakeAbsPath}/{mkRelPath ./dots/config.kdl}"

mkSymlink method2 # Just use method2, less problems :)
```

The advantages are:
1. Centralized source of truth of the path to your flake.
2. Less errors when refactoring.

# Usage

Before using it, you must build the function
```nix
# /home/user/dotfiles/flake.nix

mkRelPath = import ./mk_relpath.nix {
  rootStorePath = .;
};
```

The built function receives `rootStorePath` which is the start of your
relative path.

\*****************************************************************************/

{
  rootStorePath,
}:

let
  flakeStr = toString rootStorePath;
  str = import ./strings.nix;
in

targetStorePath:
  targetStorePath
  |> toString
  |> str.removePrefix (flakeStr + "/")
