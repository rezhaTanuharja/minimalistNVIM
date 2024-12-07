return {

  'statusline', dev = true,

  event = 'UIEnter',

  config = function()

    local statusline = require('statusline')

    statusline.setup {

      single_cursorline = true,

      display = function()

        return table.concat({

          statusline.file_name(),
          statusline.diagnostics(),
          statusline.contexts(),

          statusline.separator(),

          statusline.git_branch(),
          statusline.current_mode(),

        })

      end

    }

  end,

}
