local tools = require('user.tools')
local neotest = require('neotest')

local function gopls()
  tools.nmap("<leader>s", ":GoTestPkg<cr>", { desc = 'Go test package' })
  tools.nmap("<leader>a", ":GoAlt<cr>", { desc = 'Go alternative file' })
  tools.nmap("<leader>tr", ':lua =require("neotest").run.run({ vim.fn.expand("%:h"), extra_args = { "-short" } })',
    { desc = 'Open Go run test command...' })
end

local function rust_analyzer()
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

return {
  modes = modes,
  get_current = function()
    return current_mode
  end,
}
