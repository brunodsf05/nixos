/*****************************************************************************\
The `getModules` imports all valid `.nix` module files from a given directory.

# Features

1. Contains a filter, so no all `.nix` files are imported.
2. Returns a flat list of `.nix` file paths suitable for `map import`.
3. Also prints every valid module.
4. It is configurable.

# Configuration

You can (optionally) configure the following:
- `lastmodFilename` which its the file name used in the folder filter. 
- `logger` which generates the string printed when importing a module. 

# Filter

There are two:
1. Ignore `.nix` files starting with `_`.
2. If the current folder contains a `lastmodFilename`, then only imports
   the `default.nix` and stops the recursive importing of that folder.  

# Usage

1. Build and configure the 'getModules':
   ```nix
   getModules = import ./get_modules.nix {
     lastmodFilename = ".lastmod";
     logger = path: "Just imported ${path}";
   };
   ```

2. Use it inside as an `imports` value:
   ```nix
   { imports = (map import (getModules ./modules)); }
   ```
\*****************************************************************************/

{
  lastmodFilename ? ".lastmod",
  logger ? (path: "Importing ${path}")
}:

let
  str = import ./strings.nix;

  getModules = dir: getModulesRec dir dir;

  /**
   * Has the real logic of `getModules`.
   *
   * @param rootDir The start directory, used when printing the valid modules in trace.
   * @param dir The current directory to search.
   *
   * @return A list of absolute paths to `.nix` files under `dir`.
   */
  getModulesRec = rootDir: dir:
    let
      entries = builtins.readDir dir; # Read the directory entries (names and their types: "regular" or "directory"). Example: { "config.nix" = "regular"; "lib" = "directory"; "_ignore.nix" = "regular"; }
      paths = builtins.attrNames entries; # Extract only the entry names. Example: [ "config.nix" "lib" "_ignore.nix" ]

      # Detect presence of control files
      hasStopImport = builtins.hasAttr ".lastmod" entries; # True if directory has a .lastmod file
      hasDefault = builtins.hasAttr "default.nix" entries; # True if directory has a default.nix file

      # If .lastmod exists, only include default.nix (if present) and stop recursion
      stopResult =
        if hasDefault then
          let
            path = dir + "/default.nix";
            rel = str.removePrefix (toString rootDir + "/") (toString path);
          in
            [ (builtins.trace (logger rel) path) ]
        else
          [];

      # Filter valid entries and return a list of path names. Example: [ "config.nix" "lib"]
      valid = builtins.filter (name:
        let
          type = entries.${name};
          isFile = type == "regular" && str.hasSuffix ".nix" name;
          isDir  = type == "directory";
          hidden = str.hasPrefix "_" name;
        in
          (isFile || isDir) && !hidden
      ) paths;

    in
      if hasStopImport then
        # Stop recursion and return only default.nix if available
        stopResult
      else
        # Recursively flatten all valid module paths into one list
        builtins.concatMap (name:
          let
            path = dir + ("/" + name);
            t = entries.${name};
          in
            if t == "directory" then
              # Recursive call for subdirectories
              getModulesRec rootDir path
            else
              let
                # Compute relative path for cleaner trace output
                rel = str.removePrefix (toString rootDir + "/") (toString path);
              in
                # Return a one-element list containing the file path
                # The trace is shown during evaluation
                [ (builtins.trace (logger rel) path) ]
        ) valid;
in
  getModules
