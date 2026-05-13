return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- This makes 'L' open files without switching focus
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.commands = opts.filesystem.commands or {}
      opts.filesystem.commands.print_me = function(state)
        local node = state.tree:get_node()
        print(node.name)
      end

      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
      opts.filesystem.window.mappings["L"] = function(state)
        local tree = state.tree
        local ok, node = pcall(tree.get_node, tree)
        if not (ok and node) then
          return
        end
        if node.type == "directory" then
          require("neo-tree.sources.common.commands").toggle_node(state)
        else
          local path = node.path or node:get_id()
          local bufnr = node.extra and node.extra.bufnr
          local neo_winid = vim.api.nvim_get_current_win()
          require("neo-tree.utils").open_file(state, path, "edit", bufnr)
          if vim.api.nvim_win_is_valid(neo_winid) then
            vim.api.nvim_set_current_win(neo_winid)
          end
        end
      end
    end,
  },
}
