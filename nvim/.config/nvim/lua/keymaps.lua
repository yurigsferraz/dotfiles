local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- ToggleTerm
vim.keymap.set("n", "<Leader>tt", "<cmd>ToggleTerm direction=float<CR>")
vim.keymap.set("t", "<Leader>tt", "<cmd>ToggleTerm direction=float<CR>")

-- Tab navigation
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Nova Tab" })
vim.keymap.set("n", "<leader>te", ":tabedit ", { desc = "Tab Edit (arquivo)" }) -- vai pedir o arquivo
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>", { desc = "Fechar Tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Fechar Tab" })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Deixar só essa Tab" })
vim.keymap.set("n", "<leader>tp", ":tabprev<CR>", { desc = "Tab Anterior" })
vim.keymap.set("n", "<leader>tnx", ":tabnext<CR>", { desc = "Tab Próxima" })
vim.keymap.set("n", "gt", ":tabnext<CR>", { desc = "Tab Próxima" })
vim.keymap.set("n", "gT", ":tabprev<CR>", { desc = "Tab Anterior" })

-- Navegação entre buffers com Tab e Shift+Tab
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Próximo Buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Buffer Anterior" })

-- Fechar buffer atual (com plugin bbye, se quiser)
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Fechar Buffer" })
vim.keymap.set("n", "<leader>bq", ":bdelete<CR>", { desc = "Fechar Buffer" })

-- Splits rápidos
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Split Vertical" })
vim.keymap.set("n", "<leader>h", ":split<CR>", { desc = "Split Horizontal" })

-- Navegação entre splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Janela Esquerda" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Janela Direita" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Janela Baixo" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Janela Cima" })

-- Fechar split atual
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Fechar Split" })

-- Fechar todos os splits menos o atual
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Só esse Split (only)" })

vim.keymap.set("n", "<leader>wh", "<C-w>H", { desc = "Mover Split p/ Esquerda" })
vim.keymap.set("n", "<leader>wj", "<C-w>J", { desc = "Mover Split p/ Baixo" })
vim.keymap.set("n", "<leader>wk", "<C-w>K", { desc = "Mover Split p/ Cima" })
vim.keymap.set("n", "<leader>wl", "<C-w>L", { desc = "Mover Split p/ Direita" })

-- Go
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		-- Testes
		vim.keymap.set(
			"n",
			"<leader>tf",
			":GoTestFunc<CR>",
			{ buffer = true, desc = "Go: Rodar teste atual (TestFunc)" }
		)
		vim.keymap.set(
			"n",
			"<leader>ta",
			":GoTestFile<CR>",
			{ buffer = true, desc = "Go: Rodar todos testes do arquivo" }
		)
		vim.keymap.set("n", "<leader>tc", ":GoCoverageToggle<CR>", { buffer = true, desc = "Go: Toggle test coverage" })

		-- Fmt/Imports/Fix
		vim.keymap.set("n", "<leader>gf", ":GoFmt<CR>", { buffer = true, desc = "Go: Formatar arquivo" })
		vim.keymap.set("n", "<leader>gi", ":GoImports<CR>", { buffer = true, desc = "Go: Organizar imports" })
		vim.keymap.set("n", "<leader>gx", ":GoFix<CR>", { buffer = true, desc = "Go: Go Fix" })

		-- Rename
		vim.keymap.set("n", "<leader>gr", ":GoRename<CR>", { buffer = true, desc = "Go: Renomear (GoRename)" })
	end,
})
