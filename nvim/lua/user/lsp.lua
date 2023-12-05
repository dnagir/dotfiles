local function enable_format_on_save()
  local group = "AutoFormatting"
  vim.api.nvim_create_augroup(group, {})
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

local function setup_go(lspconfig, capabilities)
  lspconfig.gopls.setup({
    capabilities = capabilities,

    on_attach = function()
      error("heeeello")
    end,

    settings = {
      gopls = {
        completeUnimported = true,
        analyses = {
          -- Full list: https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
          unusedparams = true,
          unusedwrite = true,
          unusedvariable = true,
          shadow = false,
        },
        staticcheck = true,
        gofumpt = false,
      },
    },
  })
end

local function setup_rust(lspconfig, capabilities)
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,

    on_attach=function(client)
      require("completion").on_attach(client)
    end,

    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy"
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true
        },
      }
    }
  })
end

local function attach_lsp(buf, map_buffer)
  enable_format_on_save()
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  map_buffer(buf)
end

-- setup uses capabilities to setup the lspconfig and
-- call map_buffer on LspAttach.
local function setup(capabilities, map_buffer)
  local lspconfig = require('lspconfig')
  setup_go(lspconfig, capabilities)
  setup_rust(lspconfig, capabilities)

  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      attach_lsp(ev.buf, map_buffer)
    end
  })
end

return {
  setup = setup,
}
