--------------------------------------------------------------------------------
-- Setup package mangager first.
--------------------------------------------------------------------------------
require 'user.plugins'

require 'user.options'

require 'user.markdown'
require 'user.keymaps' -- Call early to setup leader key.
require 'user.inserts'

require 'user.telescope'
require 'user.treesitter'
require 'user.git'
require 'user.nvim-tree'
require 'user.illuminate'
require 'user.neotest'

--------------------------------------------------------------------------------
-- Language servers
--------------------------------------------------------------------------------
require('mason').setup()
local cmp = require 'user.cmp'
local lsp = require 'user.lsp'
lsp.setup(cmp.capabilities, require('telescope.builtin'))
require 'user.modes'
