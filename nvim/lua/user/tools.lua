return {
  nmap = function(mapTo, mapFrom)
    vim.keymap.set('n', mapTo, mapFrom, { noremap = true, silent = true })
  end,

  imap = function(mapTo, mapFrom)
    vim.keymap.set('i', mapTo, mapFrom, { noremap = true, silent = true })
  end,

  map = function(mapTo, mapFrom)
    vim.keymap.set('', mapTo, mapFrom, { noremap = true, silent = true })
  end,
}
