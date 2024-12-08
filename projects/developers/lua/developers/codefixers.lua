local M = {}

function M.create_autocmd(opts)

  if vim.fn.executable(opts.executable) == 1 then

    vim.api.nvim_create_autocmd('BufWritePost', {

      pattern = opts.pattern,
      group = 'formatters',

      callback = function()

        for _, action in pairs(opts.actions) do
          vim.cmd(action)
        end

      end,

    })

  end

end

return M
