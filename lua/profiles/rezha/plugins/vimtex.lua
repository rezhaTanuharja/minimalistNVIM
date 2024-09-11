return {

  'lervag/vimtex',

  config = function()

    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      build_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-pdf',
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
        '-outdir=../build',
      },
    }
    vim.g.vimtex_syntax_conceal_disable = 1
    vim.g.vimtex_syntax_enabled = 0

    -- Key mappings for vimtex
    vim.api.nvim_set_keymap('n', '<leader>ll', ':VimtexCompile<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>lv', ':VimtexView<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>lc', ':VimtexCompile!<CR>', { noremap = true, silent = true })

  end,

}
