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
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
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
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    --build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  "lewis6991/gitsigns.nvim",
})


vim.cmd "colorscheme slate"

require "user.options"
require "user.telescope"
require "user.treesitter"
require "user.gitsigns"
local cmp = require "user.cmp"
local lsp = require("user.lsp")
local keymaps = require("user.keymaps")

--------------------------------------------------------------------------------
-- Link everything up together.
--------------------------------------------------------------------------------
keymaps.map_telescope()
cmp.setup(keymaps.build_cmp_mapping(cmp.mapping))
lsp.setup(cmp.capabilities, keymaps.map_buffer)

