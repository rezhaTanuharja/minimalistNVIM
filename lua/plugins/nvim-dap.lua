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

  cond = vim.fn.executable('debugpy') == 1,

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

      {
        type = 'python',
        request = 'launch',
        name = 'Launch a debugging session with arguments',
        program = "${file}",
        args = function()
          local args_string = vim.fn.input('Arguments: ')
          local utils = require("dap.utils")
          if utils.splitstr and vim.fn.has("nvim-0.10") == 1 then
            return utils.splitstr(args_string)
          end
          return vim.split(args_string, " +")
        end,
        pythonPath = function()
          return 'python3'
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

    -- configure widgets

    local widgets = require('dap.ui.widgets')

    -- set scopes as right pane
    local scopes = widgets.sidebar(widgets.scopes, {}, 'vsplit')

    -- set frames as bottom pane
    local frames = widgets.sidebar(widgets.frames, {height = 10}, 'belowright split')

    vim.keymap.set('n', '<leader>dj', dap.continue)
    vim.keymap.set('n', '<leader>dm', dap.step_over)
    vim.keymap.set('n', '<leader>di', dap.step_into)
    vim.keymap.set('n', '<leader>dk', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dn', dap.clear_breakpoints)
    vim.keymap.set('n', '<leader>dt', dap.terminate)

    local repl = require('dap.repl')

    vim.keymap.set(
      'n', '<leader>da',
      function()
        return repl.toggle({}, 'belowright split')
      end
    )

    vim.keymap.set('n', '<leader>ds', scopes.toggle)
    vim.keymap.set('n', '<leader>du', frames.toggle)
    vim.keymap.set('n', '<leader>dh', widgets.hover)

  end

}
