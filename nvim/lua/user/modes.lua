local tools = require('user.tools')
local neotest = require('neotest')

local function gopls()
  tools.nmap("<leader>a", ":GoAlt<cr>", { desc = 'Go alternative file' })
  tools.nmap("<leader>ta", function()
    neotest.run.run({ suite = true, extra_args = { "-short" } })
  end, { desc = 'Run all tests (short mode)' })
  tools.nmap("<leader>tf", function()
    neotest.run.run({ vim.fn.expand("%"), extra_args = { "-short" } })
  end, { desc = 'Run tests in current file (short)' })
  tools.nmap("<leader>tr", ':lua =require("neotest").run.run({ vim.fn.expand("%:h"), extra_args = { "-short" } })',
    { desc = 'Open Go run test command...' })
end

local function rust_analyzer()
  tools.nmap("<leader>ta", function()
    neotest.run.run({ suite = true })
  end, { desc = 'Run all tests' })
end

local current_mode = nil
local modes = {
  gopls = gopls,
  rust_analyzer = rust_analyzer,
}

local function set_mode(ev)
  local client_id = ev.data.client_id
  if current_mode ~= nil then
    return
  end
  local client = vim.lsp.get_client_by_id(client_id)
  local set = modes[client.name]
  if set ~= nil then
    set()
    current_mode = client.name
  end
end

-- After the language server attaches to the current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspModes', {}),
  callback = set_mode
})

-- Enable spellcheck for gitcommit.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserFileTypeGitcommit', {}),
  desc = "Settings for gitcommit",
  pattern = "gitcommit",
  callback = function()
    vim.api.nvim_set_option_value('spell', true, { scope = 'local' })
    vim.api.nvim_set_option_value('colorcolumn', '80', { scope = 'local' })
  end
})

return {
  modes = modes,
  get_current = function()
    return current_mode
  end,
}
