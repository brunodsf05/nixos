/*****************************************************************************\
The `mkModule` function helps to declare your own modules by automatically
deriving the namespaces from the path of your module.

When writing custom modules, it is common practice to organize them under
namespaces similar to official modules (e.g. `services.desktopManager.cosmic`).

This usually introduces boilerplate, since the same namespace must be written
multiple times:
1. When declaring options `{ options.namespace = {...} }`.
2. When reading them `{ config = lib.mkIf config.namespace {...} }`.

This pattern has several drawbacks:
1. Readability suffers, especially in small modules.
2. Refactoring module paths or names is costly and error-prone.
3. The path and namespace of the module is not enforced to be the same, so when
   your future self might have a hard time finding the path of some module.

The `mkModule` function improves this situation by:
1. Enforcing path-based namespaces.
2. Declaring module options without writing a namespace.
3. Reading the values of the module's options without writing the namespace.

# Usage

1. Build and configure the 'mkModule':
   ```nix
   mkModule = import ./mk_module.nix {
     lib = inputs.nixpkgs.lib;
     prefix = "myoptions";
     modulesPath = ./modules;
   };
   ```

2. Declare a module, for example ./modules/desktop/cosmic.nix:
   ```nix
   { config, inputs, lib, pkgs, ... }:

   let
     inherit (mkModule __curPos.file config) cfg wrapInModule;
   in
   {
     options = wrapInModule {
       enable = lib.mkEnableOption "Enable the cosmic desktop.";
     };

     config = lib.mkIf cfg.enable
     {
       services.desktopManager.cosmic.enable = true;
       services.displayManager.cosmic-greeter.enable = true;
     };
   }
   ```

3. Use it in your configuration:
   ```nix
   {
     myoptions.desktop.cosmic.enable = true;
   }
   ```
\*****************************************************************************/

{
  prefix, # Prepended to path. Example: "system/gui" (path) -> "prefix.system.gui".
  modulesPath, # The root folder of your modules. Example: ./modules
}:

if builtins.match ".*/.*" prefix != null then
  throw "Error: prefix '${prefix}' cannot contain '/'"
else
let
  # Functions
  str = import ./strings.nix;

  fun = {
    pathToLeafs =
      path:
        builtins.filter builtins.isString
          (builtins.split "/" path);

    getAttrFromPath =
      path: set:
        builtins.foldl'
         (acc: key: acc.${key})
         set
         path;

    setAttrByPath =
      path: value:
        let
          len = builtins.length path;
          atDepth = n:
            if n == len then
              value
            else
              { ${builtins.elemAt path n} = atDepth (n + 1); };
        in
          atDepth 0;
  };

  # Shared
  prefixList = fun.pathToLeafs prefix;
in
  path: # Just write `./` to reference the actual file. If null, `modulesPath` is used
  config: # From nixpkgs

  let
    # Transform `path` from absolute to relative
    # `null` can be used to read `cfgRoot`
    # Examples:
    #   "/nix/store/hash/modules/system/locale.nix" -> "system/locale"
    #   "/nix/store/hash/modules/gui/cosmic/default.nix" -> "gui/cosmic"
    basePath =
      if path == null then
        ""
      else
        path
        |> toString
        |> (str.removePrefix (toString modulesPath + "/"))
        |> (str.removeSuffix ".nix")
        |> (str.removeSuffix "/default");

    # Example: "my" and "system/locale" -> [ "my" "system" "locale" ]
    pathList = fun.pathToLeafs "${prefix}/${basePath}";

    # Generate returned
    cfg = fun.getAttrFromPath pathList config;
    cfgRoot = fun.getAttrFromPath prefixList config;
    wrapInModule = fun.setAttrByPath pathList;
  in
  {
    inherit cfg; # Shortcut to config.${prefix}.${namespace}
    inherit cfgRoot; # Shortcut to config.${prefix}.${namespace}
    inherit wrapInModule; # Receives the module's options attrset
  }