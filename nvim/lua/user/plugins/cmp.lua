return {
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "petertriho/cmp-git",

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",

  {
    "hrsh7th/nvim-cmp",

    config = function()
      local cmp = require('cmp')

      -- See https://github.com/hrsh7th/nvim-cmp/blob/538e37ba87284942c1d76ed38dd497e54e65b891/lua/cmp/config/mapping.lua#L44-L52
      local function completeOrNext()
        if cmp.visible() then
          cmp.select_next_item({ behavior = require('cmp.types').cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },

        -- Default mappings are at:
        -- https://github.com/hrsh7th/nvim-cmp/blob/538e37ba87284942c1d76ed38dd497e54e65b891/lua/cmp/config/mapping.lua
        --
        -- Insert mode:
        -- <Down>" - down
        -- "<Up>"  - up
        -- "<C-n>" - trigger completion or next item
        -- "<C-p>" - trigger completion or prev item
        -- "<C-y>" - confirm
        -- "<C-e>" - abort
        --
        -- Command line mode:
        -- "<C-z"    - trigger completion or next item
        -- "<Tab>"   - trigger completion or next item
        -- "<S-Tab>" - trigger completion or prev item
        -- "<C-n>"   - trigger completion or next item
        -- "<C-p>"   - trigger completion or prev item
        -- "<C-y>"   - confirm
        -- "<C-e>"   - abort
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = completeOrNext,

          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          -- Do not accept if not selected so that we do not insert suggestions in comments when hitting Enter.
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          -- { name = 'vsnip' }, -- For vsnip users.
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },
}
