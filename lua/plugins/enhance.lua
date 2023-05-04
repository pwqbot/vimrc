return {
    -- show key hint
    {
        "folke/which-key.nvim",
        config = function()
            require 'plugins/config/which-key'
        end
    },

    --  jk to ESC
    {
        "max397574/better-escape.nvim",
        config = function()
            require 'plugins/config/better-escape'
        end,
    },

    -- quickfix window preview
    {
        'kevinhwang91/nvim-bqf',
        config = function()
            require 'plugins/config/bqf'
        end
    },

    -- powerful c-a/c-x
    {
        'monaqa/dial.nvim',
        keys = {
            { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true },
            { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true },
            { "<C-a>", function() return require("dial.map").inc_visual() end, expr = true, mode = "v" },
            { "<C-x>", function() return require("dial.map").dec_visual() end, expr = true, mode = "v" },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group {
                -- default augends used when no group name is specified
                default = {
                    augend.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                    augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
                    augend.constant.alias.bool,    -- boolean value (true <-> false)
                    augend.constant.new {
                        elements = { "and", "or" },
                        word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    },
                    augend.constant.new {
                        elements = { "&&", "||" },
                        word = false,
                        cyclic = true,
                    },
                },
            }
        end
    },

    -- automatically turn off search highlight
    'haya14busa/is.vim',

    {
        'lukas-reineke/indent-blankline.nvim',
        event = { "BufReadPost" },
        config =
        {
            -- for example, context is off by default, use this to turn it on
            show_current_context = false,
            show_current_context_start = true,
        }
    },

    -- resize window
    {
        'anuvyklack/windows.nvim',
        event = "BufReadPost",
        dependencies = {
            "anuvyklack/middleclass",
            -- "anuvyklack/animation.nvim"
            -- disable due to
            -- https://github.com/anuvyklack/windows.nvim/issues/23
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require('windows').setup({
                autowidth = {
                    --		       |windows.autowidth|
                    enable = true,
                    winwidth = 30, --		        |windows.winwidth|
                    filetype = {   --	      |windows.autowidth.filetype|
                        help = 2,
                    },
                },
                ignore = {
                    buftype = { 'quickfix', 'terminal' },
                },
                animation = {
                    enable = true,
                    duration = 300,
                    fps = 120,
                    easing = "in_out_sine"
                }
            })
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader><F1>",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.env.HOME })
                end,
                desc = "Explorer NeoTree (root dir)",
            },
            {
                "<F1>",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols",
            },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
                use_libuv_file_watcher = true,
            },
            window = {
                mappings = {
                    -- ["<space>"] = "none",
                },
            },
            source_selector = {
                winbar = true,
                statusline = false
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },
    {
        'jpalardy/vim-slime',
        init = function()
            vim.cmd [[
            let g:slime_target = "neovim"
            let g:slime_no_mappings = 1
            ]]
        end
    },

    {
        "voldikss/vim-floaterm",
        init = function()
            vim.cmd [[let g:floaterm_keymap_toggle = '<C-t>']]
            vim.cmd [[let g:floaterm_width = 0.8]]
            vim.cmd [[let g:floaterm_height = 0.8]]
            vim.cmd [[let g:floaterm_autoinsert = 1]]
        end
    },
    {
        'willothy/flatten.nvim',
        config = true,
        lazy = false,
        priority = 1001,
    }
}
