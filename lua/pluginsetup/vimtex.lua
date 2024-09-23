return {

  'lervag/vimtex',

  ft = 'tex',

  config = function()

    vim.g.vimtex_compiler_method = 'latexmk'

    vim.g.vimtex_compiler_latexmk = {
      out_dir = '../build',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-synctex=1',
      },
    }

    vim.g.vimtex_syntax_conceal_disable = 1
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_view_enabled = 1
    vim.g.vimtex_view_automatic = 0
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_view_forward_search_on_start = 0

    -- Key mappings for vimtex
    vim.api.nvim_set_keymap('n', '<leader>ll', ':VimtexCompile<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>lv', ':VimtexView<CR>', { noremap = true, silent = true })

  end,

}
