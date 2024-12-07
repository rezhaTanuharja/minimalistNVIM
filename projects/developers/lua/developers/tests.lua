local M = {}

function M.create_autocmd(opts)

  if vim.fn.executable(opts.executable) then

    vim.api.nvim_create_autocmd('FileType', {

      pattern = opts.pattern,
      group = 'tests',

      callback = function(args)

        vim.bo[args.buf].makeprg = opts.makeprg
        vim.bo[args.buf].errorformat = opts.errorformat

        vim.keymap.set('n', '<leader>t', '<cmd>make<return>', { buffer = args.buf })

      end,

    })

  end

end

return M
