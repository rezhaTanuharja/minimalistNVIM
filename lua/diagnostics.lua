vim.diagnostic.config {

  virtual_text = false,

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '!',
      [vim.diagnostic.severity.WARN] = '!',
      [vim.diagnostic.severity.HINT] = '?',
    },
  },

  float = {
    title = 'Diagnostic',
    header = '',
    border = 'single',
    scope = 'line',
  },

}

vim.opt['signcolumn'] = 'yes'

vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<return>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<return>')
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<return>')
