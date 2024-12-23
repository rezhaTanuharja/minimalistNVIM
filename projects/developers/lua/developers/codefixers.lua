---
-- @file projects/developers/lua/developers/codefixers.lua
--
-- @brief
-- The plugin file for developers - codefixers
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-23
--


local M = {}

function M.set_fixer(opts)

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
