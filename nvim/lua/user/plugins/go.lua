return {
    "ray-x/go.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require('go').setup({
            -- default is false, can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
            tag_transform = "camelcase",
            -- remove omitempty as an option, the default was "json=omitempty"
            tag_options = "", -- sets options sent to gomodifytags, i.e., json=omitempty
        })
    end,
}
