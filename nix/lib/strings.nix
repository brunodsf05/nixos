rec {
  /**
   * @return `true` if `str` starts with `prefix`.
   */
  hasPrefix = prefix: str:
    builtins.substring 0 (builtins.stringLength prefix) str == prefix;

  /**
   * @return `true` if `str` ends with `suffix`.
   */
  hasSuffix = suffix: str:
    let
      lenSuffix = builtins.stringLength suffix;
      lenStr = builtins.stringLength str;
    in
      lenSuffix <= lenStr &&
      builtins.substring (lenStr - lenSuffix) lenSuffix str == suffix;

  /**
   * @return `str` with `prefix` removed if it is present at the start.
   */
  removePrefix = prefix: str:
    if hasPrefix prefix str then
      let
        startIndex = builtins.stringLength prefix;
        charsToRead = builtins.stringLength str - startIndex;
      in
        builtins.substring startIndex charsToRead str
    else
      str;

  /**
   * @return `str` with `suffix` removed if it is present at the end.
   */
  removeSuffix = suffix: str:
    if hasSuffix suffix str then
      let
        lenSuffix = builtins.stringLength suffix;
        lenStr = builtins.stringLength str;
      in
        builtins.substring 0 (lenStr - lenSuffix) str
    else
      str;
}
