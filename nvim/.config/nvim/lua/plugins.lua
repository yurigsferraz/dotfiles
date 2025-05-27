-- [[ Bootstrap lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require("lazy").setup({
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd.colorscheme("kanagawa-wave")           
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go" },

                auto_install = true,

                highlight = {
                    enable = true,
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>ss",
                        node_incremental = "<leader>si",
                        scope_incremental = "<leader>sc",
                        node_decremental = "<leader>sd",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'v', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true or false
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "gopls" },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'enter' },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = { documentation = { auto_show = true } },

            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = { 'lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons' },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = {
                enabled = true,
                sources = {
                    explorer = {
                        layout = {
                            layout = {
                                position = "right"
                            }
                        }
                    }
                },
            },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    -- wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            -- Top Pickers & Explorer
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
            { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            -- find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            -- git
            --{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            --{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            --{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            --{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            --{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            --{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
            --{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
            ---- Grep
            --{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            --{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            --{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
            --{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
            ---- search
            --{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
            --{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
            --{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
            --{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            --{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
            --{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
            --{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            --{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            --{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
            --{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
            --{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
            --{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            --{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            --{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
            --{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
            --{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
            --{ "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
            --{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            --{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
            --{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
            --{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
            -- LSP
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            --{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            --{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
            -- Other
            --{ "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
            --{ "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
            --{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            --{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            --{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
            --{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            --{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            --{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            --{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            --{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            --{ "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
            --{ "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
            --{ "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
            --{ "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd

                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.dim():map("<leader>uD")
                end,
            })
        end,
    }
})
