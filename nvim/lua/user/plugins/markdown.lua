return {
    -- TODO: Enable Table of contents generation for nvim 0.12+. Old version is https://github.com/richardbizik/nvim-toc/blob/1324bb865fb446b048025514abb1e26bfe456a17/lua/nvim-toc/init.lua

    -- Markdown preview.
    -- install with yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
}
