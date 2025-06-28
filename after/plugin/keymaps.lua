---
-- @file after/plugin/keymaps.lua
--
-- @brief
-- The file to set general keymaps
--
-- @author Tanuharja, R.A.
-- @date 2024-10-12
--


local mode_keymaps = {

  normal = {

    ["x"] = { action = '"_x', desc = 'delete a character without storing it in the clipboard' },

    ["<leader>v"] = { action = vim.cmd.split, desc = "horizontal split" },
    ["<leader>h"] = { action = vim.cmd.vsplit, desc = "vertical split" },

    ["<C-b>"] = { action = "<cmd>vertical resize -2<return>", desc = "decrease rows in the current window" },
    ["<C-n>"] = { action = "<cmd>vertical resize +2<return>", desc = "increase rows in the current window" },
    ["<C-,>"] = { action = "<cmd>horizontal resize -2<return>", desc = "decrease columns in the current window" },
    ["<C-.>"] = { action = "<cmd>horizontal resize +2<return>", desc = "increase columns in the current window" },

    ["<leader>r"] = { action = "zR", desc = "unfold everything" },
    ["<leader>m"] = { action = "zM", desc = "fold everything" },

    ["<S-m>"] = {
      action = function ()
        vim.o.hlsearch = not vim.o.hlsearch
      end,
      desc = "toggle highlight from search results"
    },

    ["<leader>j"] = { action = vim.cmd.copen, desc = "open the quickfix list" },
    ["<leader>J"] = { action = vim.cmd.cclose, desc = "close the quickfix list" },

    ["<leader>qj"] = {
      action = function()
        local success = pcall(vim.cmd, "cnext")
        if not success then
          local _ = pcall(vim.cmd, "cfirst")
        end
      end,
      desc = "navigate to the next quickfix item"
    },

    ["<leader>qk"] = {
      action = function()
        local success = pcall(vim.cmd, "cprev")
        if not success then
          local _ = pcall(vim.cmd, "clast")
        end
      end,
      desc = "navigate to the prev quickfix item"
    },

    ["<leader>ql"] = {
      action = function()
        local _ = pcall(vim.cmd, "cnewer")
      end,
      desc = "navigate to the next quickfix list"
    },

    ["<leader>qh"] = {
      action = function()
        local _ = pcall(vim.cmd, "colder")
      end,
      desc = "navigate to the prev quickfix list"
    },

    ["<leader>sd"] = { action = '<cmd>call setqflist([], " ")<return>', desc = "create an empty quickfix list" },
    ["<leader>sf"] = {
      action = function()
        local filename = vim.fn.expand("%")
        local line_number = vim.fn.line(".")
        local column_number = vim.fn.col(".")
        local line_text = vim.fn.getline(".")

        local entry = {
          filename = filename,
          lnum = line_number,
          col = column_number,
          text = line_text,
        }

        vim.fn.setqflist( {entry}, "a" )
      end,
      desc = "add a line into the current quickfix list"
    },

  },

  visual = {

    ["H"] = { action = "<gv", desc = "move highlighted part to the left" },
    ["L"] = { action = ">gv", desc = "move highlighted part to the right" },

    ["<leader>i"] = { action = ":s/\\(\\s*\\)/\\1", desc = "spawn multiple cursors at the start of highlighted lines" },
    ["<leader>a"] = { action = ":s/$/", desc = "spawn multiple cursors at the end of highlighted lines" },

    ['"'] = { action = 'c""<esc>P', desc = "put highlighted text inside pairing chars" },
    ["["] = { action = "c[]<esc>P", desc = "put highlighted text inside pairing chars" },
    ["("] = { action = "c()<esc>P", desc = "put highlighted text inside pairing chars" },
    ["{"] = { action = "c{}<esc>P", desc = "put highlighted text inside pairing chars" },
    ["'"] = { action = "c''<esc>P", desc = "put highlighted text inside pairing chars" },
    ["`"] = { action = "c``<esc>P", desc = "put highlighted text inside pairing chars" },

  },

}

for mode, keymaps in pairs(mode_keymaps) do

  local mode_initial = mode:sub(1, 1)

  for key, maps in pairs(keymaps) do
    vim.keymap.set( mode_initial, key, maps.action, { noremap = true, silent = true, desc = maps.desc } )
  end

end
