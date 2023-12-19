local tools = require('user.tools')

local function insert_uuid()
  local f = assert(io.popen('uuidgen', 'r'))
  local uuid = assert(f:read('*a'))
  f:close()
  uuid = uuid:gsub("%s+", "")
  uuid = uuid:lower()

  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. uuid .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
end

tools.imap('<leader>uuid', insert_uuid)

return {
  insert_uuid = insert_uuid,
}
