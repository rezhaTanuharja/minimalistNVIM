local M = {}


function M.parse_pytest_output(_, error_locations, _)

  local quickfix_list = {}

  for _, location in pairs(error_locations) do

    local file, line_number, message = location:match(
      '([^:]+):(%d+):(.+)'
    )

    if file and line_number and message then

      table.insert(
        quickfix_list, {
          filename = file,
          lnum = line_number,
          text = message,
        }
      )

    end

    if #quickfix_list == 0 then
      print('Passed all tests')
      return
    end

    vim.fn.setqflist(quickfix_list, 'r')
    vim.cmd('copen')

  end

end


function M.run_pytest()

  local buf_number = vim.api.nvim_get_current_buf()

  local success, active_clients = pcall(vim.lsp.get_clients, { bufnr = buf_number })
  if not success then
    print('There is no active client')
    return
  end

  local root_dir = active_clients[1].workspace_folders[1].name
  local command = 'pytest ' .. root_dir .. ' | grep "Error$"'

  local _ = vim.fn.jobstart(

    command, {

      on_stdout = M.parse_pytest_output,
      stdout_buffered = true,

    }
  )

end


function M.setup(opts)

  vim.api.nvim_create_augroup('tests', { clear = true })

  if opts.python then

    vim.api.nvim_create_autocmd(
      'FileType', {
        pattern = 'python',
        group = 'tests',
        callback = function(args)
          vim.keymap.set(
            'n', opts.trigger, M.run_pytest, { buffer = args.buf }
          )
        end
      }
    )

  end

end


return M
