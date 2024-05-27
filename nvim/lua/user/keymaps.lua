local tools = require('user.tools')

-- Remap leader key.
tools.map(",", "<Nop>", { desc = '' })
vim.g.mapleader = ","
vim.g.maplocalleader = ","
-- Comma is useful for reverse search, so map it to a double comma.
vim.keymap.set('n', "<leader><leader>", ",", { noremap = true, silent = true })

-- Easier to quote insert mode.
tools.imap("jj", "<Esc>")
tools.imap("kk", "<Esc>")
tools.nmap("<leader>/", ":nohlsearch<CR>", { desc = 'Search' })



-- :bd will close buffer + window
-- Using this mapping to keep the window open
-- http://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window#answer-5179609
tools.nmap("<leader>d", ":bprevious<CR>:bdelete #<CR>", { desc = 'Close buffer (keep window)' })
tools.nmap("<leader>bd", ":bd<CR>", { desc = "Delete buffer" })
tools.nmap("<leader>w", ":w<CR>", { desc = "Write file" })
tools.nmap("<leader>cc", ":close<CR>", { desc = "Close the the current window" })
tools.nmap("<leader>cq", ":cclose<CR>", { desc = "Close the quickfix window" })
tools.nmap("<leader>qa", ":qa!<CR>", { desc = "Quit DISCARDING all changes" })

-- Easier copy-paste to system clipboard.
tools.map("<leader>y", '"+y', { desc = 'Clipboard: copy' })
tools.map("<leader>p", '"+p', { desc = 'Clipboard: paste' })
