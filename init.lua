---
-- @file init.lua
--
-- @brief
-- The starting point of the Neovim config
--
-- @author Tanuharja, R.A.
-- @date 2024-10-12
--

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("", "<space>", "<nop>", { desc = "space is only a leader key now" })

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

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

-- config below is for Lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"

	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})

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

local success, lazy = pcall(require, "lazy")
if not success then
	vim.notify("Failed to load plugin: lazy")
	return
end

lazy.setup({

	lockfile = nil,

	rocks = {
		enabled = false,
		hererocks = false,
	},

	ui = {
		border = "single",
		icons = {
			cmd = "",
			config = "",
			event = "",
			favorite = "",
			ft = "",
			init = "",
			import = "",
			keys = "",
			lazy = "",
			loaded = "●",
			not_loaded = "○",
			plugin = "",
			runtime = "",
			require = "",
			source = "",
			start = "",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},

	change_detection = {
		enabled = false,
		notify = false,
	},

	performance = {

		cache = {
			enabled = true,
		},

		reset_packpath = true,

		rtp = {
			reset = true,
			disabled_plugins = {
				"editorconfig",
				"gzip",
				"man",
				"netrwPlugin",
				"spellfile",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},

	spec = { { import = "plugins" } },

	install = { colorscheme = { "default" } },
})
