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

    dap.adapters.python = function(cb, config)

      if config.request == 'launch' then

        cb({
          type = 'executable',
          command = 'python',
          args = { '-m', 'debugpy.adapter' },
        })

      elseif config.request == 'attach' then

        if config.name == 'Launch a distributed torchrun session' then

          local debug_command = 'DEBUG_FLAG=1 torchrun'

          debug_command = debug_command .. ' ' .. '--nproc_per_node=' .. config.session.num_process
          debug_command = debug_command .. ' ' .. config.program
          debug_command = debug_command .. ' ' .. '> /dev/null 2>&1 &'

          os.execute(debug_command)

          cb({
            type = 'server',
            port = 5678,
            host = '127.0.0.1',
            options = {
              source_filetype = 'python'
            }
          })

        else

          local port = config.connect.port
          local host = config.connect.host

          cb({
            type = 'server',
            port = port,
            host = host,
            options = {
              source_filetype = 'python'
            }
          })

        end

      end

    end

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Start a Python debugging session',
        program = "${file}",
        pythonPath = function()
          return 'python'
        end,
      },
      {
        type = 'python',
        request = 'attach',
        name = 'Launch a distributed torchrun session',
        program = "${file}",
        session = function()
          local num_process = vim.fn.input('Number of process per node [1]: ')
          return {num_process = num_process}
        end,
        pythonPath = function()
          return 'python'
        end,
      },
      {
        type = 'python',
        request = 'attach',
        name = 'Attach a distributed torchrun session',
        connect = function()
          local host = vim.fn.input('Host [127.0.0.1]: ')
          local port = tonumber(vim.fn.input('Port [5678]: '))
          return {host = host, port = port}
        end,
      },
    }

    vim.fn.sign_define(
      'DapBreakpoint', {
        text = '-',
        texthl = 'DiagnosticError',
        numhl = 'DiagnosticError'
      }
    )

    vim.fn.sign_define(
      'DapStopped', {
        text = '>',
        texthl = 'DiagnosticHint',
        numhl = 'DiagnosticHint'
      }
    )

    local widgets = require('dap.ui.widgets')
    local sidebar = widgets.sidebar(widgets.scopes, {}, 'vsplit')
    local bottbar = widgets.sidebar(widgets.frames, {height = 10}, 'belowright split')
    local repl = require('dap.repl')

    vim.keymap.set('n', '<C-S-m>', '<cmd>lua require("dap").continue()<return>')
    vim.keymap.set('n', '<C-S-o>', '<cmd>lua require("dap").step_over()<return>')
    vim.keymap.set('n', '<C-S-i>', '<cmd>lua require("dap").step_into()<return>')
    vim.keymap.set('n', '<C-S-l>', '<cmd>lua require("dap").toggle_breakpoint()<return>')
    vim.keymap.set('n', '<C-S-n>', '<cmd>lua require("dap").clear_breakpoints()<return>')
    vim.keymap.set('n', '<C-S-t>', '<cmd>lua require("dap").terminate()<return>')

    vim.keymap.set(
      'n', '<C-S-a>',
      function()
        return repl.toggle({}, 'belowright split')
      end
    )

    vim.keymap.set(
      'n', '<C-S-k>',
      function()
        return sidebar.toggle()
      end
    )

    vim.keymap.set(
      'n', '<C-S-j>',
      function()
        return bottbar.toggle()
      end
    )

    vim.keymap.set(
      'n', '<C-S-h>',
      function()
        return widgets.hover()
      end
    )

  end

}
