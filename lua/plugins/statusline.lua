return {

  dir = vim.fn.stdpath('config') .. '/projects/statusline.lua',

  event = 'UIEnter',

  config = function()

    local success, statusline = pcall(require, 'statusline')
    if not success then
      vim.notify('Failed to load plugin: statusline')
      return
    end

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

      end,

    }
  end

}
