/*****************************************************************************\
Generates namespaced logging functions.

# Usage

```nix
log = import ./lib/logger.nix {
  prefix = "mynix";
  suffixes = [
    "info"
    "test"
  ];
};

testingTrace = log.trace.test "This message will be traced" "returned value";
generatedMsg = log.msg.info "Just a string, not traced btw.";
```
\*****************************************************************************/

{
  prefix ? "prefix",
  suffixes ? [ "suffix1" "suffix2" "suffix3" ],
}:

let
  fnGenerateMessage = type: message: "[${prefix}::${type}] ${message}";

  mkAttrs = f: builtins.listToAttrs (map (type: { name = type; value = f type; }) suffixes);

  mkMsg = type: message: fnGenerateMessage type message;
  mkTrace = type: message: return: builtins.trace (mkMsg type message) return;
in
{
  msg = mkAttrs (type: mkMsg type);
  trace = mkAttrs (type: mkTrace type);
}