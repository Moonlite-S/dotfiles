# Same auto-discover-and-concatenate pattern as ../plugins/default.nix,
# see its comment for why load order across files here is safe.
{ lib, ... }:
let
  dir = builtins.readDir ./.;
  luaFiles = builtins.attrNames (
    lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".lua" name) dir
  );
in
{
  programs.neovim.initLua = lib.concatMapStringsSep "\n" (
    name: builtins.readFile (./. + "/${name}")
  ) luaFiles;
}
