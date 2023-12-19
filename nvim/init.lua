--------------------------------------------------------------------------------
-- Setup package mangager first.
--------------------------------------------------------------------------------
require('user.lazy')

require 'user.options'
vim.cmd 'colorscheme slate'

require 'user.keymaps' -- Call early to setup leader key.
require 'user.inserts'

require 'user.telescope'
require 'user.treesitter'
require 'user.gitsigns'
require 'user.nvim-tree'
require 'user.neotest'

--------------------------------------------------------------------------------
-- Language servers
--------------------------------------------------------------------------------
require('mason').setup()
local cmp = require 'user.cmp'
local lsp = require('user.lsp')
lsp.setup(cmp.capabilities)
require 'user.modes'
