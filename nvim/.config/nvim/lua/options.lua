-- [[ Interface ]]
vim.opt.number = true -- Exibe número da linha atual
vim.opt.relativenumber = true -- Exibe números relativos nas outras linhas

vim.opt.wrap = false -- Desabilita quebra de linha (wrap)

vim.opt.termguicolors = true -- Habilita suporte a cores verdadeiras no terminal

-- [[ Divisões da Janela ]]
vim.opt.splitbelow = true -- Novas divisões horizontais abaixo da atual
vim.opt.splitright = true -- Novas divisões verticais à direita da atual

-- [[ Edição de Texto ]]
vim.opt.expandtab = true -- Converte TABs em espaços
vim.opt.tabstop = 4 -- Número de espaços de um TAB
vim.opt.shiftwidth = 4 -- Número de espaços ao indentar com >> ou <<

vim.opt.virtualedit = "block" -- Permite mover o cursor para posições virtuais no modo visual em blocos

-- [[ Pesquisa ]]
vim.opt.ignorecase = true -- Ignora maiúsculas/minúsculas ao pesquisar (a menos que haja letras maiúsculas na busca)

vim.opt.inccommand = "split" -- Mostra substituições em tempo real numa divisão ao usar :%s

-- [[ Comportamento de Rolagem ]]
vim.opt.scrolloff = 999 -- Mantém o cursor sempre centralizado verticalmente

-- [[ Sistema ]]
vim.opt.clipboard = "unnamedplus" -- Usa o clipboard do sistema para copiar/colar

vim.g.mapleader = " "

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
})

--  Set pop window for Go documentation
vim.g.go_doc_popup_window = 1
vim.opt.cursorline = true
