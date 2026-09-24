# Same auto-discover-and-concatenate pattern as nvim/plugins/default.nix,
# just for *.conf files -> programs.tmux.extraConfig instead of Lua.
{ lib, ... }:
let
  dir = builtins.readDir ./.;
  confFiles = builtins.attrNames (
    lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".conf" name) dir
  );
in
{
  programs.tmux.extraConfig = lib.concatMapStringsSep "\n" (
    name: builtins.readFile (./. + "/${name}")
  ) confFiles;
}
