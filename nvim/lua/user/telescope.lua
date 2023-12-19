local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
local function hidden_files_vimgrep_arguments()
  -- Clone the default Telescope configuration
  local opts = { unpack(telescopeConfig.values.vimgrep_arguments) }

  -- I want to search in hidden/dot files.
  table.insert(opts, "--hidden")
  -- I don't want to search in the `.git` directory.
  table.insert(opts, "--glob")
  table.insert(opts, "!**/.git/*")
  return opts
end

local function hidden_files_find_command()
  return { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
end

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      '.git/',
      --'vendor/',       -- Go
      'target/',       -- Rust
      'node_modules/', -- JavaScript
    },
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = hidden_files_vimgrep_arguments(),
  },
  pickers = {
    find_files = {
      find_command = hidden_files_find_command(),
    },
  },
})



--require('telescope').setup {
--  defaults = {
--    --file_ignore_patterns = {
--    --  '.git/',
--    --  'vendor/',       -- Go
--    --  'target/',       -- Rust
--    --  'node_modules/', -- JavaScript
--    --},
--    pickers = {
--      find_files = {
--        hidden = true,
--      },
--    },
--  },
--}

local session = {
  live_grep_glob = "**/*.",
  live_grep_default_text = "",
}

local function get_last_cached_prompt()
  local cached_pickers = require('telescope.state').get_global_key("cached_pickers") or {}
  local picker = cached_pickers[1]
  if picker == nil then
    return ""
  end
  return picker.cache_picker.cached_prompt
end

local function live_grep_with_glob()
  vim.ui.input({ prompt = 'Glob: ', completion = "file", default = session.live_grep_glob }, function(pattern)
    -- Remember the last search details
    session.live_grep_glob = pattern
    if session.live_grep_default_text == "" then
      session.live_grep_default_text = get_last_cached_prompt()
    end

    -- Find using glob
    local cfg = require("telescope.config")
    -- Clone the default Telescope configuration
    local args = { unpack(cfg.values.vimgrep_arguments) }
    -- Set the glob value.
    table.insert(args, "--glob")
    table.insert(args, pattern)
    require('telescope.builtin').live_grep({ vimgrep_arguments = args, default_text = session.live_grep_default_text })
  end)
end

return {
  live_grep_with_glob = live_grep_with_glob,
}
