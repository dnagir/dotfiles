local function enable_format_on_save()
  local filetypes = {
    "go",
    "lua",
    "rust",
  }

  local group = "AutoFormatting"
  vim.api.nvim_create_augroup(group, {})
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    callback = function()
      local curr = vim.bo.filetype
      -- Only autofomat the whitelisted file types
      for _, ft in ipairs(filetypes) do
        if ft == curr then
          vim.lsp.buf.format()
          return
        end
      end
    end,
  })
end

local function setup_go(lspconfig, capabilities)
  lspconfig.gopls.setup({
    capabilities = capabilities,

    on_attach = function(_client)
    end,

    settings = {
      gopls = {
        completeUnimported = true,
        analyses = {
          -- Full list: https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
          unusedwrite = true,
          unusedvariable = true,
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

local function setup_others(lspconfig, capabilities)
  lspconfig.ocamllsp.setup {
    capabilities = capabilities,
  }

  -- JSON: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
  -- requires: npm i -g vscode-langservers-extracted
  lspconfig.jsonls.setup {
    capabilities = capabilities,
  }

  -- YAML: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
  -- requires: npm install -g yaml-language-server
  lspconfig.yamlls.setup {
    capabilities = capabilities,
    settings = {
      yaml = {},
    }
  }

  -- Python 3.6+: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
  -- Config options: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
  lspconfig.pylsp.setup {
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {},
      }
    }
  }

  -- HTML: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
  -- requires: npm i -g vscode-langservers-extracted
  lspconfig.html.setup {
    capabilities = capabilities,
  }

  -- Elm: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#elmls
  lspconfig.elmls.setup {
    capabilities = capabilities,
  }

  -- SQL: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
  -- Config: https://github.com/joe-re/sql-language-server
  -- requires: npm i -g sql-language-server
  lspconfig.sqlls.setup {
    capabilities = capabilities,
  }

  -- TypeScript: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
  lspconfig.tsserver.setup {
    capabilities = capabilities,
  }

  -- Ruby: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruby_ls
  lspconfig.ruby_ls.setup {
    capabilities = capabilities,
  }
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

local tools = require('user.tools')

-- Buffer local mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local function map_buffer(buf)
  tools.nmap('<leader>ld', vim.lsp.buf.definition, { buffer = buf, desc = 'LSP: definition' })
  tools.nmap('<leader>lt', vim.lsp.buf.type_definition, { buffer = buf, desc = 'LSP: type_definition' })

  tools.nmap('K', vim.lsp.buf.hover, { buffer = buf, desc = 'LSP: hover' })
  vim.keymap.set({ 'i', 'n', 'v' }, '<leader>lk',
    vim.lsp.buf.signature_help,
    { buffer = buf, desc = 'LSP: signature_help' })

  tools.nmap('<F2>', vim.lsp.buf.rename, { buffer = buf, desc = 'LSP: rename' })

  tools.nvmap('<space>a', vim.lsp.buf.code_action, { buffer = buf, desc = 'LSP: code_action' })
  tools.nmap('<space>f', function()
    -- Format and Apply edits (e.g. organise imports)
    -- See https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end, { buffer = buf, desc = 'LSP: format' })
end


local function map_global(telescope_builtin)
  tools.nmap('<leader>lr', telescope_builtin.lsp_references, { desc = 'LSP: references' })
  tools.nmap('<leader>li', telescope_builtin.lsp_implementations, { desc = 'LSP: implementation' })

  -- Diagnostics
  tools.nmap('<space>e', vim.diagnostic.open_float, { desc = "Diagnostic: open float" })
  tools.nmap('<space>k', vim.diagnostic.goto_prev, { desc = "Diagnostic: next" })
  tools.nmap('<space>j', vim.diagnostic.goto_next, { desc = "Diagnostic: previous" })
  tools.nmap('<space>q', vim.diagnostic.setloclist, { desc = "Diagnostic: send to localist" })
end

-- setup uses capabilities to setup the lspconfig and
local function setup(capabilities, telescope_builtin)
  local lspconfig = require('lspconfig')
  setup_lua(lspconfig)
  setup_go(lspconfig, capabilities)
  setup_rust(lspconfig, capabilities)
  setup_others(lspconfig, capabilities)
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
  map_global(telescope_builtin)
end


return {
  setup = setup,
}
