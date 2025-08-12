---
-- @file init.lua
--
-- @brief
-- The starting point of the Neovim config
--
-- @author Tanuharja, R.A.
-- @date 2024-10-12
--

vim.cmd("colorscheme minimum")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("", "<space>", "<nop>", { desc = "space is only a leader key now" })

vim.g.loaded_netrw = 1

vim.g.loaded_node_provider = 1
vim.g.loaded_perl_provider = 1
vim.g.loaded_python_provider = 1
vim.g.loaded_ruby_provider = 1

local options = {

	-- user interface

	termguicolors = true,
	mouse = "",
	clipboard = "unnamedplus",
	winborder = "single",
	cursorline = true,
	showtabline = 0,
	inccommand = "split",
	timeoutlen = 300,
	updatetime = 200,
	virtualedit = "block",
	splitbelow = true,
	splitright = true,
	showmode = false,
	cmdheight = 0,
	path = ".,,**",
  grepprg = "rg --vimgrep",

	-- tabs and indentations

	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,

	-- number columns

	relativenumber = true,
	number = true,
	numberwidth = 3,

	-- text display

	foldlevelstart = 99,
	foldtext = "",
	foldmethod = "expr",

	foldexpr = "v:lua.vim.treesitter.foldexpr()",

	wrap = false,
	smartindent = true,
	scrolloff = 99,
	sidescrolloff = 6,

	fillchars = {
		eob = " ",
		fold = "-",
		stl = "-",
	},

	pumheight = 8,
	pumwidth = 20,
	pumblend = 15,

	-- text search

	ignorecase = true,
	smartcase = true,
	hlsearch = false,

	-- miscellaneous

	backup = false,
	swapfile = false,
	undofile = false,
	fileencoding = "utf-8",
}

for parameter, value in pairs(options) do
	vim.opt[parameter] = value
end

require("plugin_manager").setup({
	plugins = {
		"blankline",
		"gitsigns",
		"nvim-dap",
		"nvim-tree",
		"treesitter",
		"vimtex",
		"vscode-js-debug",
	},
})

-- require("snippets")
