---
-- @file projects/tests.lua
--
-- @brief
-- The file to set test capabilities
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-01
--


local M = {}


function M.setup(opts)

  vim.api.nvim_create_augroup('tests', { clear = true })

  for language, config in pairs(opts.language_config) do

    if vim.fn.executable(config.executable) then

      vim.api.nvim_create_autocmd('FileType', {

        pattern = language,
        group = 'tests',

        callback = function(args)

          vim.bo[args.buf].makeprg = config.makeprg
          vim.bo[args.buf].errorformat = config.errorformat

          vim.keymap.set('n', '<leader>t', '<cmd>make<return>', { buffer = args.buf })

        end,

      })

    end

  end

end


return M
