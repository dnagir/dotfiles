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


-- Buffer local mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local function setup_keymaps_for_buffer(buf)
    local tools = require('user.tools')
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
        local params = vim.lsp.util.make_range_params() --vim.api.nvim_get_current_win(), "utf-8")
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


local function setup_keymaps(telescope_builtin)
    local tools = require('user.tools')
    tools.nmap('<leader>lr', telescope_builtin.lsp_references, { desc = 'LSP: references' })
    tools.nmap('<leader>li', telescope_builtin.lsp_implementations, { desc = 'LSP: implementation' })

    -- Diagnostics
    tools.nmap('<space>e', vim.diagnostic.open_float, { desc = "Diagnostic: open float" })
    tools.nmap('<space>k', vim.diagnostic.goto_prev, { desc = "Diagnostic: next" })
    tools.nmap('<space>j', vim.diagnostic.goto_next, { desc = "Diagnostic: previous" })
    tools.nmap('<space>q', vim.diagnostic.setloclist, { desc = "Diagnostic: send to localist" })
end

-- setup uses capabilities to setup the lspconfig and
local function setup(capabilities)
    vim.lsp.enable('gopls')
    vim.lsp.enable('terraformls')

    local telescope_builtin = require('telescope.builtin')
    setup_keymaps(telescope_builtin)

    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            enable_format_on_save()
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            setup_keymaps_for_buffer(ev.buf)
        end
    })
    local telescope_builtin = require('telescope.builtin')
    setup_keymaps(telescope_builtin)
end


return {
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        config = function()
            -- Must setup plugins in the following order.
            -- mason.nvim
            -- mason-lspconfig.nvim
            require('mason').setup()
            require('mason-lspconfig').setup()
            setup(require('cmp_nvim_lsp').default_capabilities())
        end
    },
}
