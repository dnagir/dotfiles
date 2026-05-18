-- From https://github.com/ymic9963/nvim/blob/ec04513a338761ff48aa0c87b8454e10a59fed3f/init.lua#L262-L277
local autogroup = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = autogroup,
    callback = function(args)
        local treesitter = require('nvim-treesitter')
        local lang = vim.treesitter.language.get_lang(args.match)
        if vim.list_contains(treesitter.get_available(), lang) then
            if vim.list_contains(treesitter.get_installed(), lang) then
                vim.treesitter.start(args.buf)
            end
        end
    end,
    desc = "Start treesitter for supported and installed languages"
})

return {
    {
        "nvim-treesitter/nvim-treesitter",
    },
}
