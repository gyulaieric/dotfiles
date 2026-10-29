vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

vim.o.number = true
vim.o.relativenumber = true

vim.g.mapleader = " "

vim.pack.add {
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

    -- telescope
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" }
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { "go" },
    callback = function() vim.treesitter.start() end,
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require("lazydev").setup()

vim.lsp.enable("lua_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("clangd")
vim.lsp.enable("pylsp")


vim.cmd.colorscheme "catppuccin-nvim"

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.o.ignorecase = true
            vim.o.autocomplete = true
            vim.o.complete = 'o,.,w,b,u'
            vim.o.completeopt = 'fuzzy,menuone,noselect'
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end
})
