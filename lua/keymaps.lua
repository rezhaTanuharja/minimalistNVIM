vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('', '<space>', '<nop>', { desc = 'space is only a leader key now' })

local mode_keymaps = {

  normal = {

    ['q'] = { action = '<nop>', desc = 'do not record macro, ever' },

    ['x'] = { action = '"_x', desc = 'delete a character without storing it in the clipboard' },

    ['<leader>q'] = { action = '<cmd>quit<return>', desc = 'close the current window' },
    ['<leader>w'] = { action = '<cmd>write<return>', desc = 'save changes in the current buffer' },

    ['<C-h>'] = { action = '<C-w>h', desc = 'move focus to the pane on the left' },
    ['<C-j>'] = { action = '<C-w>j', desc = 'move focus to the pane below' },
    ['<C-k>'] = { action = '<C-w>k', desc = 'move focus to the pane above' },
    ['<C-l>'] = { action = '<C-w>l', desc = 'move focus to the pane on the right' },

    ['<S-h>'] = { action = '<cmd>bprev<return>', desc = 'switch to the prev buffer' },
    ['<S-l>'] = { action = '<cmd>bnext<return>', desc = 'switch to the next buffer' },

    ['<leader>v'] = { action = '<cmd>split<return>', desc = 'horizontal split' },
    ['<leader>h'] = { action = '<cmd>vsplit<return>', desc = 'vertical split' },

    ['<C-m>'] = { action = '<cmd>vertical resize -2<return>', desc = 'decrease rows in the current window' },
    ['<C-n>'] = { action = '<cmd>vertical resize +2<return>', desc = 'increase rows in the current window' },
    ['<C-,>'] = { action = '<cmd>horizontal resize -2<return>', desc = 'decrease columns in the current window' },
    ['<C-.>'] = { action = '<cmd>horizontal resize +2<return>', desc = 'increase columns in the current window' },

    ['<S-m>'] = { action = '<cmd>nohlsearch<return>', desc = 'remove highlight from search results' },

  },

  visual = {

    ['H'] = { action = '<gv', desc = 'move highlighted part to the left' },
    ['J'] = { action = ":move '>+1<return>gv", desc = 'move highlighted part to the left' },
    ['K'] = { action = ":move '<-2<return>gv", desc = 'move highlighted part to the left' },
    ['L'] = { action = '>gv', desc = 'move highlighted part to the right' },

    ['<leader>i'] = { action = ':s/^/', desc = 'spawn multiple cursors at the start of highlighted lines' },
    ['<leader>a'] = { action = ':s/$/', desc = 'spawn multiple cursors at the end of highlighted lines' },

  },

  command = {

    ['<C-y>'] = { action = '/g | nohlsearch<return>', desc = 'confirm substitutions' },

  },

}

for mode, keymaps in pairs(mode_keymaps) do
  
  local mode_initial = mode:sub(1, 1)

  for key, maps in pairs(keymaps) do
    vim.keymap.set( mode_initial, key, maps.action, { noremap = true, silent = true, desc = maps.desc } )
  end
end
