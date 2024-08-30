---
-- @file lua/rezha/keymaps.lua
--
-- @brief
-- The configuration file to define custom keymaps
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local commonOptions = {
  noremap = true,     -- prevent recursive mapping
  silent = true,      -- supress keymap display in the command-line window
}

-- Alias function to remap keys
local keymap = vim.api.nvim_set_keymap

-- Remap space as a leader key
keymap("", "<Space>", "<Nop>", commonOptions)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Faster quit and save
keymap("n", "<leader>q", ":q<CR>", commonOptions)
keymap("n", "<leader>w", ":w<CR>", commonOptions)

-- Navigate through windows
keymap("n", "<C-h>", "<C-w>h", commonOptions)
keymap("n", "<C-j>", "<C-w>j", commonOptions)
keymap("n", "<C-k>", "<C-w>k", commonOptions)
keymap("n", "<C-l>", "<C-w>l", commonOptions)

-- Navigate through buffers
keymap("n", "<S-l>", ":bnext<CR>", commonOptions)
keymap("n", "<S-h>", ":bprevious<CR>", commonOptions)

-- Resize windows
keymap("n", "<C-m>", ":vertical resize -2<CR>", commonOptions)
keymap("n", "<C-n>", ":vertical resize +2<CR>", commonOptions)

-- Faster search and remove highlights from search
keymap("n", "<leader>a", ":/", commonOptions)
keymap("n", "<S-m>", ":nohlsearch<CR>", commonOptions)

-- Remove a buffer without closing window
keymap("n", "<leader>c", ":Bdelete!<cr>", commonOptions)

-- Enable repeated indentation
keymap("v", "<", "<gv", commonOptions)
keymap("v", ">", ">gv", commonOptions)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", commonOptions)
keymap("x", "K", ":move '<-2<CR>gv-gv", commonOptions)


-- Keymaps associated with plugins


-- open directory tree (nvim-tree)
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", commonOptions)

-- navigate telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", commonOptions)
keymap("n", "<leader>b", "<cmd>Telescope current_buffer_fuzzy_find<cr>", commonOptions)
keymap("n", "<leader>d", "<cmd>Telescope diagnostics<cr>", commonOptions)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", commonOptions)
