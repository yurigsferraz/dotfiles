return {
	--  {
	--  	"rebelot/kanagawa.nvim",
	--  	config = function()
	--  		vim.cmd.colorscheme("kanagawa-wave")
	--  	end,
	--  },
	{
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd.colorscheme("carbonfox")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = "",
					section_separators = "",
					globalstatus = true,
					always_show_tabline = true,
				},

				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},

				tabline = {
					lualine_a = {
						{
							"buffers",
							show_filename_only = true,
							hide_filename_extension = false,
							show_modified_status = true,
							mode = 2,
							use_mode_colors = true,
							symbols = {
								modified = " ●",
								alternate_file = "#",
								directory = " ",
							},
						},
					},
					lualine_z = {},
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", path = 1 } },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},

				extensions = { "nvim-tree", "fugitive" },
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},

	{
		"airblade/vim-gitgutter",
		-- Event can be set to "BufReadPre" to load the plugin as soon as a buffer is read
		-- or use other lazy-loading strategies.
		event = "BufReadPre",
		config = function()
			-- You can add any specific configuration options here
			vim.g.gitgutter_highlight_add = "GitGutterAdd"
			vim.g.gitgutter_highlight_modify = "GitGutterChange"
			vim.g.gitgutter_highlight_delete = "GitGutterDelete"
			-- Example keymaps for navigating hunks
			vim.keymap.set("n", "]h", ":GitGutterNextHunk<CR>", { desc = "Jump to next hunk" })
			vim.keymap.set("n", "[h", ":GitGutterPrevHunk<CR>", { desc = "Jump to previous hunk" })
		end,
	},
}
