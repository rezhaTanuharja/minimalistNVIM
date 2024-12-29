---
-- @file projects/developers/lua/developers/tests.lua
--
-- @brief
-- The plugin file for developers - tests
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-23
--


local M = {}

function M.set_test(opts)

  if vim.fn.executable(opts.executable) == 1 then

    vim.api.nvim_create_autocmd('FileType', {

      pattern = opts.pattern,
      group = 'tests',

      callback = function(args)

        vim.bo[args.buf].makeprg = opts.makeprg
        vim.bo[args.buf].errorformat = opts.errorformat

        vim.keymap.set('n', '<leader>i', '<cmd>make<return>', { buffer = args.buf })

      end,

    })

  end

end

return M
