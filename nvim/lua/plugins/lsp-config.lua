return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "lua_ls", "gopls"},
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        {
            "neovim/nvim-lspconfig",
            init = function()
                vim.lsp.enable({ 'lua_ls', 'gopls' })
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            end,
        },
    },
}
