local M = {}


function M.setup(opts)

  vim.api.nvim_create_augroup('tests', { clear = true })

  if opts.python then

    vim.api.nvim_create_autocmd(
      'FileType', {
        pattern = 'python',
        group = 'tests',
        callback = function(args)

          vim.bo[args.buf].makeprg = 'pytest \\| grep "Error$"'
          vim.bo[args.buf].errorformat = '%f:%l: %m'

          vim.keymap.set(
            'n', opts.trigger, '<cmd>make<return>', { buffer = args.buf }
          )

        end,
      }
    )

  end

end


return M
