---
-- @file lua/plugins/fzf.lua
--
-- @brief
-- The configuration file for the plugin fzf-lua
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-11-10
--

return {

  "ibhagwan/fzf-lua",

  event = 'UIEnter',
  dependencies = { "junegunn/fzf", build = "./install --bin" },

  config = function()

    local success, fzf = pcall(require, 'fzf-lua')
    if not success then
      vim.notify('Failed to load plugin: fzf-lua')
      return
    end

    fzf.setup {

      'max-perf',
      fzf_colors = true,

      winopts ={
        fullscreen = false,
      },

      files = {
        previewer = false,
      },

    }

    vim.keymap.set('n', '<leader>f', fzf.files, { noremap = true, silent = true })

  end
}
