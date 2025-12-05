return {
	--  {
	--  	"rebelot/kanagawa.nvim",
	--  	config = function()
	--  		vim.cmd.colorscheme("kanagawa-wave")
	--  	end,
	--  },
	{
		"EdenEast/nightfox.nvim",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					always_divide_middle = true,
					globalstatus = true, -- barra única mesmo com splits
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"buffers",
							show_filename_only = true, -- só o nome, não o path completo
							hide_filename_extension = false,
							show_modified_status = true, -- mostra ● se o buffer tiver modificado
							mode = 2, -- 0: id, 1: nome, 2: nome + número
							use_mode_colors = true, -- destaca o buffer ativo
							symbols = {
								modified = " ●",
								alternate_file = "#",
								directory = " ",
							},
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "nvim-tree", "fugitive" },
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
}
