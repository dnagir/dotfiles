--------------------------------------------------------------------------------
-- Start: Package manager
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--------------------------------------------------------------------------------
-- End: Package manager
--------------------------------------------------------------------------------


require("lazy").setup({
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {}
  },
  { "folke/neoconf.nvim",       cmd = "Neoconf" },
  "folke/neodev.nvim",

  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "petertriho/cmp-git",

  "nvim-treesitter/nvim-treesitter",

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- Telescope extension to pick from arbitrary commands.
  { 'axkirillov/easypick.nvim', dependencies = { 'nvim-telescope/telescope.nvim' } },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    --build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- Git
  "lewis6991/gitsigns.nvim",
  "sindrets/diffview.nvim",

  -- LSPs
  "williamboman/mason.nvim",

  -- Remember the last position in a file.
  {
    "vladdoster/remember.nvim",
    config = function()
      require("remember")
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      multiline = false, -- compact the messages into one line, open with K if needed
      --------------------------------------------------------------------------------
      -- disable the icons
      --------------------------------------------------------------------------------
      icons = false,
      fold_open = "v",      -- icon used for open folds
      fold_closed = ">",    -- icon used for closed folds
      indent_lines = false, -- add an indent guide below the fold icons
      signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
      },
      use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",

      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
    }
  },

  -- Luapad runs your code in context with overwritten print function and
  -- displays the captured input as virtual text right there, where it was
  -- called - in real time!
  'rafcamlet/nvim-luapad',

  -- Smart and powerful comment plugin for neovim.
  -- Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more.
  -- Some of the mappings:
  --
  -- # NORMAL mode:
  -- `gcc` - Toggles the current line using linewise comment
  -- `gbc` - Toggles the current line using blockwise comment
  -- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
  -- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
  -- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
  -- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
  --
  -- # VISUAL mode:
  -- `gc` - Toggles the region using linewise comment
  -- `gb` - Toggles the region using blockwise comment
  --
  -- # Extra mappings:
  -- `gco` - Insert comment to the next line and enters INSERT mode
  -- `gcO` - Insert comment to the previous line and enters INSERT mode
  -- `gcA` - Insert comment to end of the current line and enters INSERT mode
  --
  -- # Example: Linewise
  -- `gcw` - Toggle from the current cursor position to the next word
  -- `gc$` - Toggle from the current cursor position to the end of line
  -- `gc}` - Toggle until the next blank line
  -- `gc5j` - Toggle 5 lines after the current cursor position
  -- `gc8k` - Toggle 8 lines before the current cursor position
  -- `gcip` - Toggle inside of paragraph
  -- `gca}` - Toggle around curly brackets
  --
  -- # Example: Blockwise
  -- `gb2}` - Toggle until the 2 next blank line
  -- `gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
  -- `gbac` - Toggle comment around a class (w/ LSP/treesitter support)
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
    config = function()
      require('Comment').setup()
    end
  },


  -- Markdown preview.
  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
  -- Adds <a-n> and <a-p> as keymaps to move between references and <a-i> as a textobject for the reference illuminated under the cursor.
  'RRethy/vim-illuminate',

  -- color schemes: https://github.com/ray-x/starry.nvim
  {
    'ray-x/starry.nvim',
    config = function()
      require('starry').setup {
        border = false, -- Split window borders
        italics = {
          comments = true,
          strings = false,
          keywords = false,
          functions = false,
          variables = false
        },
        contrast = {       -- Select which windows get the contrast background
          enable = false,  -- Enable contrast
          terminal = true, -- Darker terminal
          filetypes = {},  -- Which filetypes get darker? e.g. *.vim, *.cpp, etc.
        },
        text_contrast = {
          lighter = false, -- Higher contrast text for lighter style
          darker = false   -- Higher contrast text for darker style
        },
        disable = {
          background = false,  -- true: transparent background
          term_colors = false, -- Disable setting the terminal colors
          eob_lines = false    -- Make end-of-buffer lines invisible
        },
        style = {
          fix = false,             -- fix=true - disable random loading
          disable = {},            -- a list of styles to disable, e.g. {'bold', 'underline'}
          darker_contrast = false, -- More contrast for darker style
          daylight_swith = true,   -- Enable day and night style switching
          deep_black = false,      -- Enable a deeper black background
        },
      }
      vim.cmd 'colorscheme starry'
    end
  },
})
