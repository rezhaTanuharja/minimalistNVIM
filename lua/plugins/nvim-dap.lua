---
-- @file lua/plugins/nvim-dap.lua
--
-- @brief
-- The configuration file for the plugin nvim-dap
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-13
--


return {

  'mfussenegger/nvim-dap',

  ft = 'python',

  config = function()

    local dap = require('dap')

    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },

    }

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = "${file}",
        pythonPath = function()
          return 'python'
        end,
      },
    }

    vim.fn.sign_define(
      'DapBreakpoint', {
        text = '•',
        texthl = 'DiagnosticError',
        linehl = 'DiagnosticError',
        numhl = 'DiagnosticError'
      }
    )

    vim.fn.sign_define(
      'DapStopped', {
        text = '→',
        texthl = 'DiagnosticHint',
        linehl = 'DiagnosticHint',
        numhl = 'DiagnosticHint'
      }
    )

    local widgets = require('dap.ui.widgets')
    local sidebar = widgets.sidebar(widgets.scopes, {width = 60})

    vim.keymap.set('n', '<C-S-m>', '<cmd>lua require("dap").continue()<return>')
    vim.keymap.set('n', '<C-S-b>', '<cmd>lua require("dap").toggle_breakpoint()<return>')
    vim.keymap.set('n', '<C-S-h>', '<cmd>lua require("dap.ui.widgets").preview()<return>')
    vim.keymap.set('n', '<C-S-t>', '<cmd>lua require("dap").terminate()<return>')

    vim.keymap.set(
      'n', '<C-S-k>',
      function()
        return sidebar.toggle()
      end
    )

  end

}
