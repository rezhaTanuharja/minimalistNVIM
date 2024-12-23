local opts = {}

opts.keymaps = {

  terminal = '<leader>t',
  find_file = '<leader>f',

  normal_mode = '<esc><esc>',

  goto_file = 'gf',

}

opts.window = {

  width = math.floor(vim.o.columns * 0.8),
  height = math.floor(vim.o.lines * 0.8),

  style = 'minimal',
  border = 'single',

}

opts.fzf_command = 'fd --type f | fzf'

return {

  'terminal', dev = true,

  event = 'UIEnter',
  opts = opts,

}
