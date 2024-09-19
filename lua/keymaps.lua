---
-- @file lua/keymaps.lua
--
-- @brief
-- The configuration file to define custom keymaps
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


-- shared options across all keymaps
local options = {
  noremap = true,
  silent = true,
}

local keymap = vim.api.nvim_set_keymap

-- we remap space to leader key so ensure it does nothing
keymap('', '<Space>', '<Nop>', options)

-- faster quit and save
keymap('n', '<leader>q', ':q<CR>', options)
keymap('n', '<leader>w', ':w<CR>', options)

-- navigate through windows
keymap('n', '<C-h>', '<C-w>h', options)
keymap('n', '<C-j>', '<C-w>j', options)
keymap('n', '<C-k>', '<C-w>k', options)
keymap('n', '<C-l>', '<C-w>l', options)

-- navigate through buffers
keymap('n', '<S-l>', ':bnext<CR>', options)
keymap('n', '<S-h>', ':bprevious<CR>', options)

-- remove a buffer without closing window
keymap('n', '<leader>c', ':Bdelete!<CR>', options)

-- navigate through diagnostics
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', options)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', options)

-- faster split
keymap('n', '<leader>v', ':sp<CR>', options)
keymap('n', '<leader>h', ':vs<CR>', options)

-- resize windows
keymap('n', '<C-m>', ':vertical resize -2<CR>', options)
keymap('n', '<C-n>', ':vertical resize +2<CR>', options)
keymap('n', '<C-,>', ':horizontal resize +2<CR>', options)
keymap('n', '<C-.>', ':horizontal resize -2<CR>', options)

-- makes searching for text faster
keymap('n', '<S-m>', ':nohlsearch<CR>', options)

-- terminal functionalities
keymap('n', '<leader>t', ':terminal<CR>', options)
keymap('n', '<leader>j', ':botright new | resize 10 | terminal<CR>', options)
keymap('t', 'qq', '<C-\\><C-n>', options)

-- enable repeated indentation
keymap('v', '<', '<gv', options)
keymap('v', '>', '>gv', options)

-- move highlighted texts up or down
keymap('x', 'J', ":move '>+1<CR>gv-gv", options)
keymap('x', 'K', ":move '<-2<CR>gv-gv", options)

-- enter exact replacement
keymap('n', '<leader>S', ":%s/", options)
keymap('x', '<leader>s', ":lua vim.api.nvim_feedkeys(':ExactReplace ', 'c', false)<CR>", options)
keymap('x', '<leader>a', ":s/$/", options)
keymap('x', '<leader>i', ":s/^/", options)

-- to prevent highlighting search results
keymap('c', '<S-CR>', '/g | nohlsearch<CR>', options)

-- toggle fold
keymap('n', '<leader>a', 'za', options)
keymap('n', '<leader>o', 'zR', options)
