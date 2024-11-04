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
          command = 'python3',
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
          return 'python3'
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
        text = '--',
        texthl = 'DiagnosticError',
        numhl = ''
      }
    )

    vim.fn.sign_define(
      'DapStopped', {
        text = '->',
        texthl = 'DiagnosticHint',
        numhl = ''
      }
    )

    local widgets = require('dap.ui.widgets')
    local sidebar = widgets.sidebar(widgets.scopes, {}, 'vsplit')
    local bottbar = widgets.sidebar(widgets.frames, {height = 10}, 'belowright split')
    local repl = require('dap.repl')

    vim.keymap.set('n', '<leader>dj', '<cmd>lua require("dap").continue()<return>')
    vim.keymap.set('n', '<leader>dm', '<cmd>lua require("dap").step_over()<return>')
    vim.keymap.set('n', '<leader>di', '<cmd>lua require("dap").step_into()<return>')
    vim.keymap.set('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<return>')
    vim.keymap.set('n', '<leader>dn', '<cmd>lua require("dap").clear_breakpoints()<return>')
    vim.keymap.set('n', '<leader>dt', '<cmd>lua require("dap").terminate()<return>')

    vim.keymap.set(
      'n', '<leader>da',
      function()
        return repl.toggle({}, 'belowright split')
      end
    )

    vim.keymap.set(
      'n', '<leader>ds',
      function()
        return sidebar.toggle()
      end
    )

    vim.keymap.set(
      'n', '<leader>du',
      function()
        return bottbar.toggle()
      end
    )

    vim.keymap.set(
      'n', '<leader>dh',
      function()
        return widgets.hover()
      end
    )

  end

}
