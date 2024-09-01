---
-- @file lua/profiles/rezha/keymaps.lua
--
-- @brief
-- The configuration file to define custom keymaps
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


-- shared optios across all keymaps
local opts = {
  noremap = true,
  silent = true,
}

-- function alias to remap keys
local keymap = vim.api.nvim_set_keymap

-- we remap space to leader key so ensure it does nothing
keymap('', '<Space>', '<Nop>', opts)

-- faster quit and save
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)

-- navigate through windows
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- navigate through buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- remove a buffer without closing window
keymap('n', '<leader>c', ':Bdelete!<CR>', opts)

-- navigate through diagnostics
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- resize windows
keymap('n', '<C-m>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-n>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-,>', ':horizontal resize +2<CR>', opts)
keymap('n', '<C-.>', ':horizontal resize -2<CR>', opts)

-- makes searching for text faster
keymap('n', '<leader>a', ':/', opts)
keymap('n', '<S-m>', ':nohlsearch<CR>', opts)

-- terminal functionalities
keymap('n', '<leader>t', ':terminal<CR>', opts)
keymap('n', '<leader>j', ':botright new | resize 10 | terminal<CR>', opts)
keymap('t', 'qq', '<C-\\><C-n>', opts)

-- enable repeated indentation
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- keymap('v', '<leader>s', ':exact_replace', opts)

-- move highlighted texts up or down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)

-- enter exact replacement
keymap('x', '<leader>s', ":lua vim.api.nvim_feedkeys(':ExactReplace ', 'c', false)<CR>", opts)
keymap('x', '<leader>a', ":s/$/", opts)
keymap('x', '<leader>i', ":s/^/", opts)

-- to prevent highlighting search results
keymap('c', '<S-CR>', '/g | nohlsearch<CR>', opts)
