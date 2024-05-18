-- :help options
vim.opt.backup = false       -- creates a backup file
vim.opt.swapfile = false     -- creates a swapfile
-- vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.hlsearch = true      -- highlight all matches on previous search pattern
vim.opt.ignorecase = true    -- ignore case in search patterns
vim.opt.smartcase = true     -- smart case
vim.opt.mouse = "a"          -- allow the mouse to be used in neovim
vim.opt.pumheight = 0        -- pop up menu height: Zero means "use available screen space".
vim.opt.smartindent = true   -- make indenting smarter again
vim.opt.splitbelow = true    -- force all horizontal splits to go below current window
vim.opt.splitright = true    -- force all vertical splits to go to the right of current window
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.undofile = true      -- enable persistent undo
vim.opt.writebackup = false  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true     -- convert tabs to spaces
vim.opt.shiftwidth = 2       -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4          -- insert 2 spaces for a tab

vim.opt.number = true        -- set numbered lines
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"   -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false         -- display lines as one long line

-- number of columns and rows to always keep visible when scrolling
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications

vim.opt.shortmess:append "c"

vim.opt.wildignore = ".git,*.o,*.obj,tmp,*swp,*.log,"
