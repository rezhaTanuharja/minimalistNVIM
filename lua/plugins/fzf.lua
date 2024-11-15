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


  -- if serverstart is not possible, use telescope instead

  cond = function()
    local success, server = pcall(vim.fn.serverstart, "fzf-lua." .. os.time())
    if success then
      vim.g.fzf_lua_server = server
    end
    return success
  end,


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

      files = {
        previewer = false,
      },

      grep = {
        previewer = 'builtin'
      },

      winopts = {
        border = 'single',
        backdrop = 100,

        preview = {
          title = false,
          scrollbar = false,
          delay = 50,
        },
      },

      previewers = {
        builtin = {
          syntax = true,
          syntaxt_limit_l = 1000,
          treesitter = { enable = true, disable = {} }
        },
      },

    }

    vim.keymap.set('n', '<leader>f', fzf.files, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>g', fzf.live_grep, { noremap = true, silent = true })

    vim.api.nvim_set_hl(0, 'FzfLuaHeaderBind', { fg = '#dddddd', bold = true } )
    vim.api.nvim_set_hl(0, 'FzfLuaHeaderText', { fg = '#cccccc', bold = false } )
    vim.api.nvim_set_hl(0, 'FzfLuaPathColNr', { fg = '#aaaaaa', bold = true } )
    vim.api.nvim_set_hl(0, 'FzfLuaPathLineNr', { fg = '#aaaaaa', bold = true } )

  end
}
