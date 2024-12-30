---
-- @file lua/plugins/terminal.lua
--
-- @brief
-- The configuration file for the terminal plugin
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-23
--


local opts = {}

opts.keymaps = {

  terminal = '<leader>t',
  find_file = '<leader>f',
  find_buffer = '<leader>y',
  live_grep = '<leader>g',

  normal_mode = '<esc><esc>',

  goto_file = 'gf',

}

opts.window = {

  width = function() return math.floor(vim.o.columns * 0.8) end,
  height = function() return math.floor(vim.o.lines * 0.8) end,

  style = 'minimal',
  border = 'single',

}

opts.fzf = {

  executable = 'fzf',

  args = {
    '--layout=reverse',
  },

}

opts.rg = {

  executable = 'rg',

  args = {
    '--ignore-case',
  },

}

opts.fd = {

  executable = 'fd',

  args = {
    '--type f',
    '--exclude "*.png"',
    '--exclude "*.pdf"',
    '--exclude "*.jp*g"',
  },
}

return {

  'terminal', dev = true,

  event = 'UIEnter',
  opts = opts,

}
