return {
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	opts = {
	-- 		suggestion = { enabled = true }, -- Desativar sugestões nativas
	-- 		panel = { enabled = false },
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("copilot").setup(opts)
	-- 	end,
	-- },
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"giuxtaposition/blink-cmp-copilot",
		},

		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = { documentation = { auto_show = true } },

			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" }, -- , "copilot" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					--copilot = {
					--	name = "copilot",
					--	module = "blink-cmp-copilot",
					--	score_offset = 100,
					--	async = true,
					--},
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
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
}
