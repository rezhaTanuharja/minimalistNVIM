---
-- @file lua/profiles/rezha/keymaps.lua
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

-- we remap space to leader key so ensure it does nothing
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', options)

-- faster quit and save
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', options)

-- navigate through windows
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', options)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', options)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', options)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', options)

-- navigate through buffers
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', options)
vim.api.nvim_set_keymap('n', '<S-h>', ':bprevious<CR>', options)

-- remove a buffer without closing window
vim.api.nvim_set_keymap('n', '<leader>c', ':Bdelete!<CR>', options)

-- navigate through diagnostics
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', options)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', options)

-- faster split
vim.api.nvim_set_keymap('n', '<leader>v', ':sp<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>h', ':vs<CR>', options)

-- resize windows
vim.api.nvim_set_keymap('n', '<C-m>', ':vertical resize -2<CR>', options)
vim.api.nvim_set_keymap('n', '<C-n>', ':vertical resize +2<CR>', options)
vim.api.nvim_set_keymap('n', '<C-,>', ':horizontal resize +2<CR>', options)
vim.api.nvim_set_keymap('n', '<C-.>', ':horizontal resize -2<CR>', options)

-- makes searching for text faster
vim.api.nvim_set_keymap('n', '<leader>a', ':/', options)
vim.api.nvim_set_keymap('n', '<S-m>', ':nohlsearch<CR>', options)

-- terminal functionalities
vim.api.nvim_set_keymap('n', '<leader>t', ':terminal<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>j', ':botright new | resize 10 | terminal<CR>', options)
vim.api.nvim_set_keymap('t', 'qq', '<C-\\><C-n>', options)

-- enable repeated indentation
vim.api.nvim_set_keymap('v', '<', '<gv', options)
vim.api.nvim_set_keymap('v', '>', '>gv', options)

-- move highlighted texts up or down
vim.api.nvim_set_keymap('x', 'J', ":move '>+1<CR>gv-gv", options)
vim.api.nvim_set_keymap('x', 'K', ":move '<-2<CR>gv-gv", options)

-- enter exact replacement
vim.api.nvim_set_keymap('x', '<leader>s', ":lua vim.api.nvim_feedkeys(':ExactReplace ', 'c', false)<CR>", options)
vim.api.nvim_set_keymap('x', '<leader>a', ":s/$/", options)
vim.api.nvim_set_keymap('x', '<leader>i', ":s/^/", options)

-- to prevent highlighting search results
vim.api.nvim_set_keymap('c', '<S-CR>', '/g | nohlsearch<CR>', options)
