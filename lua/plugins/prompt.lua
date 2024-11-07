return {

  dir = '~/.config/nvim/lua/projects/prompt.lua',

  config = function()

    local success, prompt = pcall(require, 'projects.prompt')
    if not success then
      vim.notify('Failed to load plugin: prompt')
      return
    end

    vim.keymap.set('n', '<leader>pp', prompt.start_shell)

  end

}
