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

    dap.adapters.python = function(callback, config)

      if config.request == 'launch' then

        callback({
          type = 'executable',
          command = 'python',
          args = { '-m', 'debugpy.adapter' },
        })

      elseif config.request == 'attach' then

        local port = config.connect.port
        local host = config.connect.host

        callback({
          type = 'server',
          port = port,
          host = host,
          options = {
            source_filetype = 'python'
          }
        })

      end

    end

    dap.configurations.python = {

      {
        type = 'python',
        request = 'launch',
        name = 'Launch a debugging session',
        program = "${file}",
        pythonPath = function()
          return 'python'
        end,
      },

      {
        type = 'python',
        request = 'attach',
        name = 'Attach a debugging session',
        connect = function()
          local host = vim.fn.input('Host: ')
          local port = tonumber(vim.fn.input('Port: '))
          return {host = host, port = port}
        end,
      },

    }

    vim.fn.sign_define(
      'DapBreakpoint', {
        text = ' ',
        texthl = 'TodoBgFIX',
        numhl = ''
      }
    )

    vim.fn.sign_define(
      'DapStopped', {
        text = '>',
        texthl = 'TodoBgNOTE',
        numhl = ''
      }
    )

    local widgets = require('dap.ui.widgets')
    local sidebar = widgets.sidebar(widgets.scopes, {}, 'vsplit')
    local bottbar = widgets.sidebar(widgets.frames, {height = 10}, 'belowright split')
    local repl = require('dap.repl')

    vim.keymap.set('n', '<C-S-g>', '<cmd>lua require("dap").continue()<return>')
    vim.keymap.set('n', '<C-S-m>', '<cmd>lua require("dap").step_over()<return>')
    vim.keymap.set('n', '<C-S-i>', '<cmd>lua require("dap").step_into()<return>')
    vim.keymap.set('n', '<C-S-d>', '<cmd>lua require("dap").toggle_breakpoint()<return>')
    vim.keymap.set('n', '<C-S-n>', '<cmd>lua require("dap").clear_breakpoints()<return>')
    vim.keymap.set('n', '<C-S-t>', '<cmd>lua require("dap").terminate()<return>')

    vim.keymap.set(
      'n', '<C-S-a>',
      function()
        return repl.toggle({}, 'belowright split')
      end
    )

    vim.keymap.set(
      'n', '<C-S-p>',
      function()
        return sidebar.toggle()
      end
    )

    vim.keymap.set(
      'n', '<C-S-u>',
      function()
        return bottbar.toggle()
      end
    )

    vim.keymap.set(
      'n', '<C-S-y>',
      function()
        return widgets.hover()
      end
    )

  end

}
