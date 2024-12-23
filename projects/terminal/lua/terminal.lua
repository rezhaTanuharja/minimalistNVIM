local M = {}

M.state = {
  buffer = -1,
  win = -1,
}

M.setup = function(opts)

  M.create_floating_window = function(buf)

    local width = opts.window.width
    local height = opts.window.height

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buffer = nil
    if vim.api.nvim_buf_is_valid(buf) then
      buffer = buf
    else
      buffer = vim.api.nvim_create_buf(false, true) end

    local win_config = {
      relative = 'editor',
      width = width,
      height = height,
      col = col,
      row = row,
      style = opts.window.style,
      border =opts.window.border, 
    }

    local win = vim.api.nvim_open_win(buffer, true, win_config)

    return { buffer = buffer, win = win }

  end

  M.toggle_find_file = function()

    local picker = M.create_floating_window(-1)
    local file_name = ''

    vim.fn.termopen(opts.fzf_command, {
      on_exit = function(_, exit_code)

        if exit_code == 0 then

          local lines = vim.api.nvim_buf_get_lines(picker.buffer, 0, -1, false)

          if #lines > 0 then
            file_name = lines[1]
          end

          vim.api.nvim_win_close(picker.win, true)

          local found_file = vim.fn.findfile(file_name, vim.o.path)

          if found_file ~= '' then
            vim.cmd('edit ' .. vim.fn.fnameescape(found_file))
          end


        else
          vim.api.nvim_win_close(picker.win, true)
        end

      end
    })

    vim.cmd('startinsert')

  end

  M.toggle_live_grep = function()

    local picker = M.create_floating_window(-1)
    local file_name = ''

    vim.fn.termopen(opts.live_grep_command, {
      on_exit = function(_, exit_code)

        if exit_code == 0 then

          local lines = vim.api.nvim_buf_get_lines(picker.buffer, 0, -1, false)

          if #lines > 0 then
            file_name, line_num = lines[1]:match("([^:]+):(%d+)")
          end

          vim.api.nvim_win_close(picker.win, true)

          local found_file = vim.fn.findfile(file_name, vim.o.path)

          if found_file ~= '' then
            vim.cmd('edit ' .. vim.fn.fnameescape(found_file))
            vim.api.nvim_win_set_cursor(0, {tonumber(line_num), 0})
          end


        else
          vim.api.nvim_win_close(picker.win, true)
        end

      end
    })

    vim.cmd('startinsert')

  end

  M.toggle_terminal = function()

    if not vim.api.nvim_win_is_valid(M.state.win) then
      M.state = M.create_floating_window(M.state.buffer)

      if vim.bo[M.state.buffer].buftype ~= 'terminal' then

        vim.cmd.terminal()

        local is_keyword = vim.bo[M.state.buffer].iskeyword
        vim.bo[M.state.buffer].iskeyword = is_keyword .. ',.,/,-'

      end
    else
      vim.api.nvim_win_hide(M.state.win)
    end

  end

  M.goto_file = function()
    local file_name = vim.fn.expand('<cword>')
    local found_file = vim.fn.findfile(file_name, vim.o.path)
    if found_file ~= '' then
      vim.api.nvim_win_hide(M.state.win)
      vim.cmd('edit ' .. vim.fn.fnameescape(found_file))
    end
  end

  vim.keymap.set('n', opts.keymaps.terminal, M.toggle_terminal)
  vim.keymap.set('n', opts.keymaps.find_file, M.toggle_find_file)
  vim.keymap.set('n', opts.keymaps.live_grep, M.toggle_live_grep)
  vim.keymap.set('t', opts.keymaps.normal_mode, '<c-\\><c-n>')
  vim.keymap.set('n', opts.keymaps.goto_file, M.goto_file, { buffer = M.state.buffer })
end

return M
