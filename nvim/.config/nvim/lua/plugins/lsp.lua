return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.rubocop.setup({ autostart = false })
		end,
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
			ensure_installed = { "lua_ls", "gopls", "pyright", "nginx_language_server", "ruby_lsp" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				lua = { "luacheck" },
				python = { "flake8" },
				ruby = { "rubocop" },
				go = { "golangcilint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			--   group = lint_augroup,
			--   callback = function()
			--     lint.try_lint()
			--   end,
			-- })

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
	{
		"rshkarin/mason-nvim-lint",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-lint",
		},
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					ruby = { "rubocop" },
					sh = { "shellcheck" },
					go = { "lsp_organize_imports", "gofumpt" },
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>l", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })

			-- Autoformat on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					})
				end,
			})
		end,
	},
	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"stevearc/conform.nvim",
		},
		opts = {},
	},
	{
		"fatih/vim-go",
		ft = { "go" }, -- carrega só em arquivos Go
		build = ":GoUpdateBinaries", -- instala/atualiza ferramentas externas
	},
}
