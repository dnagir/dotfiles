-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
local function hidden_files_vimgrep_arguments()
  local telescopeConfig = require("telescope.config")
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

local function setup_keymaps()
  local tools = require('user.tools')
  local telescope_builtin = require('telescope.builtin')

  tools.nmap('<leader>fo', telescope_builtin.oldfiles, { desc = 'Telescope: old files' })
  tools.nmap('<leader>ff', telescope_builtin.find_files, { desc = 'Telescope: find files' })
  tools.nmap('<leader>fd', function()
    -- Find files from the current file's directory.
    telescope_builtin.find_files({ cwd = vim.fn.expand('%:h') })
  end, { desc = 'Telescope: find files in buffer directory' })
  tools.nmap('<leader>fm', telescope_builtin.marks, { desc = 'Telescope: marks' })
  tools.nmap('<leader>fq', telescope_builtin.quickfix, { desc = 'Telescope: quickfix' })
  tools.nmap('<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope: help_tags' })
  tools.nmap('<leader>fr', telescope_builtin.resume, { desc = 'Telescope: resume previous search' })

  tools.nmap('<leader>gf', ':Easypick changed_files<CR>', { desc = 'Telescope: find changed_files' })

  tools.nmap('<leader>f<leader>', telescope_builtin.buffers, { desc = 'Telecope: buffers' })
  tools.nmap('<leader>fb', telescope_builtin.current_buffer_fuzzy_find, { desc = 'Telescope: search in buffer' })

  tools.nmap('<leader>fgl', telescope_builtin.live_grep, { desc = 'Telescope: live_grep' })
  tools.nmap('<leader>fgg', live_grep_with_glob, { desc = 'Telescope: grep with glob' })
  tools.nmap('<leader>fgs', telescope_builtin.grep_string, { desc = 'Telescope: grep for string at cursor' })
  tools.nmap('<leader>fgs', telescope_builtin.grep_string, { desc = 'Telescope: grep for string at cursor' })

  tools.nmap('<leader>fcb', telescope_builtin.builtin, { desc = 'Telescope: built-in commands' })
  tools.nmap('<leader>fcf', telescope_builtin.commands, { desc = 'Telescope: find commands' })
end


return {
  -- Telescope extension to pick from arbitrary commands.
  { 'axkirillov/easypick.nvim', dependencies = { 'nvim-telescope/telescope.nvim' } },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            height = 0.99,
            width = 0.99,
            prompt_position = 'bottom',
            preview_height = 0.5
          },

          file_ignore_patterns = {
            '.git/',
            'vendor/',       -- Go
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


      local easypick = require("easypick")
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

      setup_keymaps()
    end
  },
}
