require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

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
