local function nmap(mapTo, mapFrom)
  vim.keymap.set("n", mapTo, mapFrom, { noremap = true, silent = true })
end

local function imap(mapTo, mapFrom)
  vim.keymap.set("i", mapTo, mapFrom, { noremap = true, silent = true })
end

local function map(mapTo, mapFrom)
  vim.keymap.set("", mapTo, mapFrom, { noremap = true, silent = true })
end

-- Remap leader key.
map(",", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Easier to quote insert mode.
imap("jj", "<Esc>")
imap("kk", "<Esc>")
nmap("<leader>/", ":nohlsearch<CR>")


-- :bd will close buffer + window
-- Using this mapping to keep the window open
-- http://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window#answer-5179609
nmap("<leader>d", ":bprevious<CR>:bdelete #<CR>")
nmap("<leader>bd", ":bd<CR>")
nmap("<leader>w", ":w<CR>")
nmap("<leader>c", ":close<CR>")
nmap(";", ":")             -- Avoid using Shift to get to command.
nmap("<leader>l", ":lua ") -- Avoid using Shift to get to command.

-- Easier copy-paste to system clipboard.
map("<leader>y", '"+y')
map("<leader>p", '"+p')

-- Global LSP mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
nmap('<space>e', vim.diagnostic.open_float)
nmap('<space>k', vim.diagnostic.goto_prev)
nmap('<space>j', vim.diagnostic.goto_next)
nmap('<space>q', vim.diagnostic.setloclist)

-- Buffer local mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local function map_buffer(buf)
  local opts = { buffer = buf }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  -- vim.keymap.set('n', '<space>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, opts)
  vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
end


local function map_gitsigns()
  nmap('<leader>gp', ':Gitsigns preview_hunk<CR>')
  nmap('<leader>gj', ':Gitsigns next_hunk<CR>')
  nmap('<leader>gk', ':Gitsigns prev_hunk<CR>')
  nmap('<leader>gd', ':Gitsigns diffthis<CR>')

  nmap('<leader>gs', ':Gitsigns stage_hunk<CR>')
  nmap('<leader>gbs', ':Gitsigns stage_buffer<CR>')
end

local function map_telescope(setup)
  local telescope_builtin = require('telescope.builtin')
  nmap('<leader><leader>', telescope_builtin.buffers)

  nmap('<leader>fo', telescope_builtin.oldfiles)
  nmap('<leader>ff', telescope_builtin.find_files)
  nmap('<leader>fd', function()
    -- Find files from the current file's directory.
    telescope_builtin.find_files({ cwd = vim.fn.expand('%:h') })
  end)
  nmap('<leader>fm', telescope_builtin.marks)
  nmap('<leader>fq', telescope_builtin.quickfix)
  nmap('<leader>f<leader>', telescope_builtin.builtin) -- Run a built-in Telescope command.
  nmap('<leader>fh', telescope_builtin.help_tags)
  nmap('<leader>fr', telescope_builtin.resume)
  nmap('<leader>fb', telescope_builtin.current_buffer_fuzzy_find)

  nmap('<leader>fgl', telescope_builtin.live_grep)
  nmap('<leader>fgg', setup.live_grep_with_glob)
  nmap('<leader>fgs', telescope_builtin.grep_string)
end

local function build_cmp_mapping(cmp_mapping)
  return {
    ['<C-b>'] = cmp_mapping.scroll_docs(-4),
    ['<C-f>'] = cmp_mapping.scroll_docs(4),
    ['<C-Space>'] = cmp_mapping.complete(),
    ['<C-e>'] = cmp_mapping.abort(),
    ['<CR>'] = cmp_mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }
end

local function map_neotest()
  nmap("<leader>tt", function()
    require('neotest').run.run()
  end)

  nmap("<leader>t<leader>", function()
    require('neotest').run.run_last()
  end)

  nmap("<leader>ts", function()
    require('neotest').summary.open({ enter = true })
  end)

  nmap("<leader>to", function()
    require('neotest').output.open({ enter = true })
  end)
end

return {
  build_cmp_mapping = build_cmp_mapping,
  map_buffer = map_buffer, -- Should be called to map buffer specific items when LSP is attached.
  map_gitsigns = map_gitsigns,
  map_neotest = map_neotest,
  map_telescope = map_telescope,

  -- The mode with the LSP name will be called when LSP is attached.
  modes = {
    gopls = function()
      nmap("<leader>a", ":GoAlt<cr>")

      nmap("<leader>ta", function()
        require('neotest').run.run({ suite = true, extra_args = { "-short" } })
      end)

      nmap("<leader>tf", function()
        require('neotest').run.run({ vim.fn.expand("%"), extra_args = { "-short" } })
      end)

      nmap("<leader>tr", ':lua =require("neotest").run.run({ vim.fn.expand("%:h"), extra_args = { "-short" } })')
    end,


    rust_analyzer = function()
      nmap("<leader>ta", function()
        require('neotest').run.run({ suite = true })
      end)
    end
  },
}
