---
-- @file projects/codefixers.lua
--
-- @brief
-- The file to set formatting and linting capabilities
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-01
--


local M = {}


function M.setup(opts)

  vim.api.nvim_create_augroup('formatters', { clear = true })

  for _, config in pairs(opts.language_config) do

    if vim.fn.executable(config.executable) then

      vim.api.nvim_create_autocmd('BufWritePost', {

        pattern = config.pattern,
        group = 'formatters',

        callback = function()

          for _, action in pairs(config.actions) do
            vim.cmd(action)
          end

        end,

      })

    end

  end

end


return M
