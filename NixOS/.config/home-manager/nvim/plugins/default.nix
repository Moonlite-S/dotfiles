# Auto-discovers and concatenates every *.lua file in this directory
# into programs.neovim.initLua. builtins.attrNames on the readDir
# result is deterministically alphabetically sorted (a core Nix
# language guarantee), so this is reproducible - not filesystem-order-
# dependent - and load order across files here doesn't matter anyway,
# since none of them define anything a *sibling* plugin file needs at
# load time (only nvim/options.lua, loaded earlier by nvim/default.nix,
# has that requirement, for vim.g.mapleader).
{ pkgs, lib, ... }:
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

  # Plugin *packages* can't be reliably auto-derived from the .lua
  # filenames above (no safe 1:1 naming convention - e.g. mini-pick.lua
  # configures a module inside the single mini-nvim package, not a
  # separate "mini-pick-nvim" package), so this stays hand-maintained.
  programs.neovim.plugins = with pkgs.vimPlugins; [
    mini-nvim
    nui-nvim
    noice-nvim
    nvim-lspconfig
    conform-nvim
    bufferline-nvim
    snacks-nvim
    plenary-nvim
    yazi-nvim
    # Per-tab buffer isolation (scope.lua). Marked unfree in nixpkgs -
    # needs nixpkgs.config.allowUnfree (set in home.nix) or this fails
    # to build.
    scope-nvim
    # Completion engine (blink-cmp.lua). Fuzzy matcher ships prebuilt
    # via blink-fuzzy-lib, pulled in automatically as a dependency.
    blink-cmp
    # Diagnostics/refs/symbols list panel (trouble.lua). Icons come
    # from mini.icons automatically - no nvim-web-devicons needed.
    trouble-nvim
    # nvim-treesitter provides the highlight queries (bundled with it
    # for "officially supported" languages, confirmed in nixpkgs
    # source; used for render-markdown.nvim's markdown/markdown_inline
    # highlighting - see treesitter-markdown.lua), while
    # nvim-treesitter-parsers.* provides the actual compiled parser/*.so
    # files - separate packages, both needed on rtp. nvim-treesitter's
    # own `.withPlugins` helper doesn't do this bundling correctly for
    # this package (verified: building it with parsers listed produced
    # a byte-identical, unchanged output) - nixpkgs' own source
    # comments confirm raw grammars need `neovimUtils.grammarToPlugin`
    # first, and nvim-treesitter-parsers.* is already that, pre-done,
    # for supported languages.
    nvim-treesitter
    nvim-treesitter-parsers.markdown
    nvim-treesitter-parsers.markdown_inline
    render-markdown-nvim
    # trouble.nvim does its own treesitter highlighting of LSP
    # definitions/references previews (lua/trouble/view/treesitter.lua,
    # independent of the config-wide highlighting choice above) - one
    # parser per language with an LSP server enabled (lsp.lua), else it
    # falls back to a "parser missing" warning instead of highlighting.
    nvim-treesitter-parsers.python
    nvim-treesitter-parsers.javascript
    nvim-treesitter-parsers.typescript
    nvim-treesitter-parsers.tsx
    nvim-treesitter-parsers.c
    nvim-treesitter-parsers.cpp
    nvim-treesitter-parsers.rust
    nvim-treesitter-parsers.c_sharp
    nvim-treesitter-parsers.nix
  ];
}
