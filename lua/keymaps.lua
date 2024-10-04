---
-- @file lua/keymaps.lua
--
-- @brief
-- The configuration file to define custom keymaps
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


-- alias function to remap keys
local keymap = vim.keymap.set

-- we remap space to leader key so ensure it does nothing
keymap('', '<Space>', '<Nop>', options)

-- custom keymaps in normal mode
local normal_mode_keymaps = {

  ['q'] = { action = '<Nop>', desc = 'Disable macro recording because I do not use it' },

  ['x'] = { action = '"_x', desc = 'Delete character without copying' },

  ['<leader>q'] = { action = '<Cmd>q<CR>', desc = 'Easier quit' },
  ['<leader>w'] = { action = '<Cmd>w<CR>', desc = 'Easier save' },

  ['<C-h>'] = { action = '<C-w>h', desc = 'Move focus to the pane on the left' },
  ['<C-j>'] = { action = '<C-w>j', desc = 'Move focus to the pane below' },
  ['<C-k>'] = { action = '<C-w>k', desc = 'Move focus to the pane above' },
  ['<C-l>'] = { action = '<C-w>l', desc = 'Move focus to the pane on the right' },

  ['<S-l>'] = { action = '<Cmd>bnext<CR>', desc = 'Switch to the next buffer' },
  ['<S-h>'] = { action = '<Cmd>bprevious<CR>', desc = 'Switch to the previous buffer' },

  ['[d'] = { action = '<Cmd>lua vim.diagnostic.goto_prev()<CR>', desc = 'Go to the previous diagnostic' },
  [']d'] = { action = '<Cmd>lua vim.diagnostic.goto_next()<CR>', desc = 'Go to the next diagnostic' },

  ['<leader>v'] = { action = '<Cmd>sp<CR>', desc = 'Horizontal split' },
  ['<leader>h'] = { action = '<Cmd>vs<CR>', desc = 'Vertical split' },

  ['<C-m>'] = { action = '<Cmd>vertical resize -2<CR>', desc = 'Reduce current window vertical size' },
  ['<C-n>'] = { action = '<Cmd>vertical resize +2<CR>', desc = 'Increase current window vertical size' },
  ['<C-,>'] = { action = '<Cmd>horizontal resize -2<CR>', desc = 'Reduce current window horizontal size' },
  ['<C-.>'] = { action = '<Cmd>horizontal resize +2<CR>', desc = 'Increase current window horizontal size' },

  ['<S-m>'] = { action = '<Cmd>nohlsearch<CR>', desc = 'Stop highlighting search results' },

  ['<leader>t'] = { action = '<Cmd>terminal<CR>', desc = 'Open a terminal in the current buffer' },
  ['<leader>j'] = { action = '<Cmd>botright new | resize 10 | terminal<CR>', desc = 'Open a terminal in VS Code style' },

  ['<leader>a'] = { action = 'za', desc = 'Fold the scope under cursor' },
  ['<leader>r'] = { action = 'zR', desc = 'Expand all folds in the current buffer' },

  ['<C-g>'] = { action = '<Cmd>Gitsigns stage_hunk<CR>', desc = 'Stage current hunk' }
  ['<C-b>'] = { action = '<Cmd>Gitsigns stage_buffer<CR>', desc = 'Stage current buffer' }

}

for keys, map in pairs(normal_mode_keymaps) do
  keymap('n', keys, map.action, { noremap = true, silent = true, desc = map.desc })
end


-- custom keymaps in visual mode
local visual_mode_keymaps = {
  ['<'] = { action = '<gv', desc = 'Reduce indentation but stay in visual mode' },
  ['>'] = { action = '>gv', desc = 'Increase indentation but stay in visual mode' },
}

for keys, map in pairs(visual_mode_keymaps) do
  keymap('v', keys, map.action, { noremap = true, silent = true, desc = map.desc })
end


-- custom keymaps in visual block mode
local visual_block_mode_keymaps = {

  ['J'] = { action = ":move '>+1<CR>gv-gv", desc = 'Move highlighted text down' },
  ['K'] = { action = ":move '<-2<CR>gv-gv", desc = 'Move highlighted text up' },

  ['<leader>s'] = {
    action = "<Cmd>lua vim.api.nvim_feedkeys(':ExactReplace ', 'c', false)<CR>",
    desc = 'Search and replace exact words in highlighted text'
  },

  ['<leader>a'] = {
    action = ":s/$/",
    desc = 'Create multiple cursors and add text to the end of multiple lines'
  },

  ['<leader>i'] = {
    action = ":s/^/",
    desc = 'Create multiple cursors and add text to the beginning of multiple lines'
  },

  ['<leader>p'] = {
    action = "<Cmd>lua vim.api.nvim_feedkeys(':AppendTo ', 'c', false)<CR>",
    desc = 'Search and add text following the search results'
  },

}

for keys, map in pairs(visual_block_mode_keymaps) do
  keymap('x', keys, map.action, { noremap = true, silent = true, desc = map.desc })
end

-- terminal functionalities
keymap('t', 'qq', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit insert mode in terminal' })
-- to prevent highlighting search results
keymap('c', '<C-y>', '/g | nohlsearch<CR>', { noremap = true, silent = true, desc = 'Enter and remove highlight from search results' } )
