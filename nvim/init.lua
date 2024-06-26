--------------------------------------------------------------------------------
-- Start: Package manager
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--------------------------------------------------------------------------------
-- End: Package manager
--------------------------------------------------------------------------------

require 'user.keymaps' -- Call early to setup leader key.

require("lazy").setup("user/plugins")

require 'user.options'
require 'user.inserts'
require 'user.modes'
