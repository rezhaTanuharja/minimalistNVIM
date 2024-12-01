local M = {}


function M.setup(opts)

  vim.api.nvim_create_augroup('tests', { clear = true })

  if opts.python then

    vim.api.nvim_create_autocmd( 'FileType', {

      pattern = 'python',
      group = 'tests',

      callback = function(args)

        vim.bo[args.buf].makeprg = opts.python.makeprg
        vim.bo[args.buf].errorformat = opts.python.errorformat

        vim.keymap.set(
          'n', opts.trigger, '<cmd>make<return>', { buffer = args.buf }
        )

      end,

    })

  end

end


return M
