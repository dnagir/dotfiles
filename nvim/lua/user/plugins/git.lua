-- Enable spellcheck for gitcommit.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserFileTypeGitcommit', {}),
  desc = "Settings for gitcommit",
  pattern = "gitcommit",
  callback = function()
    vim.api.nvim_set_option_value('spell', true, { scope = 'local' })
    vim.api.nvim_set_option_value('colorcolumn', '80', { scope = 'local' })
    vim.api.nvim_set_option_value('textwidth', 80, { scope = 'local' })
  end
})

local function setup_keymaps()
  local tools = require('user.tools')

  -- Navigation
  tools.nmap('<leader>gj', ':Gitsigns next_hunk<CR>')
  tools.nmap('<leader>gk', ':Gitsigns prev_hunk<CR>')
  tools.nmap('<leader>gd', ':Gitsigns diffthis<CR>')

  -- Hunk actions
  tools.nmap('<leader>ghp', ':Gitsigns preview_hunk<CR>')
  tools.nmap('<leader>ghs', ':Gitsigns stage_hunk<CR>')
  tools.nmap('<leader>ghr', ':Gitsigns reset_hunk<CR>')

  -- Buffer actions
  tools.nmap('<leader>gs', ':Gitsigns stage_buffer<CR>')

  -- Toggle the diff view.
  tools.nmap('<leader>gg', function()
    local diffview_lib = require('diffview.lib')
    local curr = diffview_lib.get_current_view()
    if curr == nil then
      vim.cmd 'DiffviewOpen'
    else
      vim.cmd 'DiffviewClose'
    end
  end)
end


return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        signs                        = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          follow_files = true
        },
        attach_to_untracked          = true,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        yadm                         = {
          enable = false
        },
      })

      setup_keymaps()
    end,
  },

  {
    "sindrets/diffview.nvim",
    config = function()
      require('diffview').setup({
        file_panel = {
          -- See ':h diffview-config-win_config'
          win_config = {
            width = 70,
          },
        },
      })
  end
  },
}
