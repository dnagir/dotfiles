local tools = require('user.tools')

-- Remap leader key.
tools.map(",", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Easier to quote insert mode.
tools.imap("jj", "<Esc>")
tools.imap("kk", "<Esc>")
tools.nmap("<leader>/", ":nohlsearch<CR>")


-- :bd will close buffer + window
-- Using this mapping to keep the window open
-- http://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window#answer-5179609
tools.nmap("<leader>d", ":bprevious<CR>:bdelete #<CR>")
tools.nmap("<leader>bd", ":bd<CR>")
tools.nmap("<leader>w", ":w<CR>")
tools.nmap("<leader>c", ":close<CR>")
tools.nmap(";", ":")             -- Avoid using Shift to get to command.
tools.nmap("<leader>l", ":lua ") -- Avoid using Shift to get to command.

-- Easier copy-paste to system clipboard.
tools.map("<leader>y", '"+y')
tools.map("<leader>p", '"+p')

-- Global LSP mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
tools.nmap('<space>e', vim.diagnostic.open_float)
tools.nmap('<space>k', vim.diagnostic.goto_prev)
tools.nmap('<space>j', vim.diagnostic.goto_next)
tools.nmap('<space>q', vim.diagnostic.setloclist)
