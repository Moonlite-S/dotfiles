{ pkgs, lib, ... }:
{
  imports = [
    ./plugins
    ./keymaps
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;

    extraConfig = ''
      set number relativenumber
    '';

    extraPackages = with pkgs; [
      # LSP servers
      pyright
      ruff
      typescript-language-server
      clang-tools # clangd + clang-format
      rust-analyzer # rustfmt already provided system-wide (configuration.nix)
      csharp-ls
      nixd
      # Formatters (ruff/clang-format/rustfmt come from the packages above)
      prettier
      csharpier
      nixfmt
    ];

    # base16-nvim: the colorscheme engine theme.lua drives (matugen
    # calls require('base16-colorscheme').setup({...}) with a
    # wallpaper-derived palette). vim-tmux-navigator: ships its own
    # default <C-h/j/k/l> mappings with zero explicit config needed in
    # this codebase - confirmed absent from every keymaps/*.lua file.
    # Everything else is declared in plugins/default.nix, next to the
    # .lua file that configures it.
    plugins = with pkgs.vimPlugins; [ base16-nvim vim-tmux-navigator ];

    # options.lua sets vim.g.mapleader, which must be set before any
    # <leader>... keymap is defined (vim.keymap.set resolves <leader>
    # at definition time). Import/file order does NOT control the
    # final types.lines merge order in practice - verified by building
    # this for real (home-manager build) and finding mapleader landing
    # AFTER a <leader> keymap despite this module's imports listing
    # ./plugins/./keymaps after this config block. lib.mkBefore is the
    # explicit, documented mechanism for this (the initLua option's own
    # description names it for exactly this purpose) - forces this
    # definition to merge ahead of every default-priority one.
    initLua = lib.mkBefore (builtins.readFile ./options.lua + "\n" + builtins.readFile ./theme.lua);
  };
}
