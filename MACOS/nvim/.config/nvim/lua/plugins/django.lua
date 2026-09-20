return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      djls = {
        root_dir = function(pattern)
          local util = require("lspconfig.util")
          -- First try to find manage.py (Django-specific)
          local django_root = util.root_pattern("manage.py")(pattern)
          if django_root then
            return django_root
          end
          -- Fallback to .git or pyproject.toml
          return util.root_pattern(".git", "pyproject.toml")(pattern)
        end,
      },
    },
  },
}
