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

local mode_is_set = false

-- set the mode based on the first buffer that is open
local function set_mode(client_id, modes)
  if mode_is_set then
    return
  end
  local client = vim.lsp.get_client_by_id(client_id)
  local set = modes[client.name]
  if set ~= nil then
    set()
    mode_is_set = true
  end
end

-- setup uses capabilities to setup the lspconfig and
-- call map_buffer on LspAttach.
local function setup(capabilities, map_buffer, modes)
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
      set_mode(ev.data.client_id, modes)
    end
  })
end


return {
  setup = setup,
}
