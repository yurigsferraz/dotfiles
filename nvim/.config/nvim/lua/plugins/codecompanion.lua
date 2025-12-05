return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"j-hui/fidget.nvim",
		},
		opts = {
			strategies = {
				chat = {
					adapter = "copilot",
					model = "4.1",
				},
			},
			-- NOTE: The log_level is in `opts.opts`
			opts = {
				log_level = "DEBUG",
			},
		},
	},
}
