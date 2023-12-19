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

    on_attach = function(client)
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

-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
local function setup_lua(lspconfig)
  lspconfig.lua_ls.setup {
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          }
        })

        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end
      return true
    end
  }
end

-- Buffer local mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local function map_buffer(buf)
  local opts = { buffer = buf }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
end

-- setup uses capabilities to setup the lspconfig and
local function setup(capabilities, modes)
  local lspconfig = require('lspconfig')
  setup_lua(lspconfig)
  setup_go(lspconfig, capabilities)
  setup_rust(lspconfig, capabilities)
  lspconfig.terraformls.setup({})

  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      enable_format_on_save()
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      map_buffer(ev.buf)
    end
  })
end


return {
  setup = setup,
}
