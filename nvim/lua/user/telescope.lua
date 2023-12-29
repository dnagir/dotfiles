local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local tools = require('user.tools')
local telescope_builtin = require('telescope.builtin')
local easypick = require("easypick")

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


easypick.setup({
  pickers = {
    -- Show files that changes in git.
    {
      name = "changed_files",
      command = "git diff --name-only HEAD",
      previewer = easypick.previewers.file_diff()
    },

    -- Show git conflicts.
    {
      name = "conflicts",
      command = "git diff --name-only --diff-filter=U --relative",
      previewer = easypick.previewers.file_diff()
    },
  }
})


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


tools.nmap('<leader><leader>', ':Easypick changed_files<CR>', { desc = 'Telescope: find changed_files' })

tools.nmap('<leader>fo', telescope_builtin.oldfiles, { desc = 'Telescope: old files' })
tools.nmap('<leader>ff', telescope_builtin.find_files, { desc = 'Telescope: find files' })
tools.nmap('<leader>fd', function()
  -- Find files from the current file's directory.
  telescope_builtin.find_files({ cwd = vim.fn.expand('%:h') })
end, { desc = 'Telescope: find files in buffer directory' })
tools.nmap('<leader>fm', telescope_builtin.marks, { desc = 'Telescope: marsks' })
tools.nmap('<leader>fq', telescope_builtin.quickfix, { desc = 'Telescope: quickfix' })
tools.nmap('<leader>f<leader>', telescope_builtin.builtin, { desc = 'Telescope: built-in commands' })
tools.nmap('<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope: help_tags' })
tools.nmap('<leader>fr', telescope_builtin.resume, { desc = 'Telescope: resume previous search' })

tools.nmap('<leader>fbb', telescope_builtin.buffers, { desc = 'Telecope: buffers' })
tools.nmap('<leader>fbi', telescope_builtin.current_buffer_fuzzy_find, { desc = 'Telescope: search in buffer' })

tools.nmap('<leader>fgl', telescope_builtin.live_grep, { desc = 'Telescope: live_grep' })
tools.nmap('<leader>fgg', live_grep_with_glob, { desc = 'Telescope: grep with glob' })
tools.nmap('<leader>fgs', telescope_builtin.grep_string, { desc = 'Telescope: grep for string at cursor' })

tools.nmap('<leader>fc', telescope_builtin.commands, { desc = 'Telescope: find commands' })
