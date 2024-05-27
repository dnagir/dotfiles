local function setup_keymaps()
  local trouble = require("trouble")
  local tools = require("user.tools")

  tools.nmap("<leader>xx", function() trouble.toggle() end, { desc = "Trouble: toggle" })


  tools.nmap("<leader>xk", function()
    trouble.open()
    trouble.previous({ skip_groups = true, jump = true });
  end, { desc = "Trouble: next item" })

  tools.nmap("<leader>xj", function()
    trouble.open()
    trouble.next({ skip_groups = true, jump = true });
  end, { desc = "Trouble: next item" })
end

return {
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        multiline = false, -- compact the messages into one line, open with K if needed
        --------------------------------------------------------------------------------
        -- disable the icons
        --------------------------------------------------------------------------------
        icons = false,
        fold_open = "v",      -- icon used for open folds
        fold_closed = ">",    -- icon used for closed folds
        indent_lines = false, -- add an indent guide below the fold icons
        signs = {
          -- icons / text used for a diagnostic
          error = "error",
          warning = "warn",
          hint = "hint",
          information = "info"
        },
        use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
      })
      setup_keymaps()
    end,
  },
}
