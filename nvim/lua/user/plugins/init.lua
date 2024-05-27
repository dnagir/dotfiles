return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {}
  },
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

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

  -- Remember the last position in a file.
  {
    "vladdoster/remember.nvim",
    config = function()
      require("remember")
    end,
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
}
