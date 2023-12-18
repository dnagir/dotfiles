-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- termguicolors should already be set in options
-- vim.opt.termguicolors = true

-- see the default keymaps at https://github.com/nvim-tree/nvim-tree.lua/blob/141c0f97c35f274031294267808ada59bb5fb08e/lua/nvim-tree/keymap.lua

require("nvim-tree").setup {
  renderer = {
    special_files = {
      "Cargo.toml",
      "Makefile",
      "README.md",
      "readme.md",
      "go.mod",
      "go.sum",
      ".editorconfig",
      ".gitignore",
      ".golangci.yml",
      "CODEOWNERS",
      "dependabot.yml",
    },
    icons = {
      web_devicons = {
        file = {
          enable = false,
          color = false,
        },
        folder = {
          enable = false,
          color = false,
        },
      },
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
        diagnostics = true,
        bookmarks = true,
      },
      glyphs = {
        default = "",
        symlink = "🔗",
        bookmark = "🔖",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "\\",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "🔗",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "䷅",
          renamed = "➜",
          untracked = "★",
          deleted = "❌",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "H",
      info = "I",
      warning = "W",
      error = "E",
    },
  },
  filters = {
    git_ignored = true,
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = {},
    exclude = {},
  },
}
