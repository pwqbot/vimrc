return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neodev.nvim", opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
            "williamboman/mason.nvim",
            "glepnir/lspsaga.nvim",
            "williamboman/mason-lspconfig.nvim",
            "glepnir/lspsaga.nvim",
            'p00f/clangd_extensions.nvim',
            'MrcJkb/haskell-tools.nvim',
            "smjonas/inc-rename.nvim",
        },
        config = function()
            require 'lsp/lspconfig'
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "clangd",
                    "rust_analyzer",
                    "bashls",
                    "cmake",
                    "jsonls",
                    "pyright",
                },
            }
        end
    },
    'simrat39/rust-tools.nvim',

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end
    },
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        config = true
    },

    -- <leader>fx to open lsp diagnostic
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>tb", "<cmd>TroubleToggle<cr>" },
        },
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = function()
            require 'plugins/config/trouble'
        end,
    },

    "onsails/lspkind.nvim",

    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        event = "VeryLazy",
        config = function()
            require 'plugins/config/lspsaga'
        end,
    },

    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup({
                backends = { "treesitter", "lsp" },
                on_attach = function(bufnr)
                    -- Toggle the aerial window with <leader>a
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
                end
            })
        end,
    },

    -- lsp adapter
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        config = function()
            require 'plugins/config/null-ls'
        end
    },
    'lervag/vimtex',
}
