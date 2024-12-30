---
-- @file projects/terminal/lua/terminal.lua
--
-- @brief
-- The plugin file for terminal
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-23
--


local M = {}

M.state = {
  buffer = -1,
  win = -1,
}

local get_fzf_output = function(buffer)

  local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  local output = ''

  for row = 1, #lines do

    if lines[row] == '' then
      return output
    end

    output = output .. lines[row]

  end

end

M.setup = function(opts)

  M.create_floating_window = function(buf)

    buf = buf or -1

    local width = opts.window.width()
    local height = opts.window.height()

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

  local fzf_command = opts.fzf.executable

  for _, arg in pairs(opts.fzf.args) do
    fzf_command = fzf_command .. ' ' .. arg
  end

  local fd_command = opts.fd.executable

  for _, arg in pairs(opts.fd.args) do
    fd_command = fd_command .. ' ' .. arg
  end

  local rg_command = opts.rg.executable .. ' --line-number --color=never'

  for _, arg in pairs(opts.rg.args) do
    rg_command = rg_command .. ' ' .. arg
  end

  M.toggle_find_file = function()

    local picker = M.create_floating_window()

    vim.fn.termopen(fd_command .. ' | ' .. fzf_command, {
      on_exit = function(_, exit_code)

        if exit_code == 0 then

          local file_name = get_fzf_output(picker.buffer)
          local found_file = vim.fn.findfile(file_name, vim.o.path)

          vim.api.nvim_win_close(picker.win, true)

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

  M.toggle_find_buffer = function()

    local picker = M.create_floating_window()
    local file_name = ''

    vim.cmd('redir! > .out | silent ls | redir END')

    vim.fn.termopen([[sed -n 's/.*"\(.*\)".*/\1/p' .out | grep -v -E "term:|No Name" | ]] .. fzf_command, {
      on_exit = function(_, exit_code)

        if exit_code == 0 then

          local file_name = get_fzf_output(picker.buffer)
          local found_file = vim.fn.findfile(file_name, vim.o.path)

          vim.api.nvim_win_close(picker.win, true)

          if found_file ~= '' then
            vim.cmd('edit ' .. vim.fn.fnameescape(found_file))
          end

        else
          vim.api.nvim_win_close(picker.win, true)
        end

        vim.cmd('silent! !rm .out')

      end
    })

    vim.cmd('startinsert')

  end

  M.toggle_live_grep = function()

    local picker = M.create_floating_window()

    vim.fn.termopen(fzf_command .. ' --bind "change:reload(' .. rg_command .. ' {q} || true)" --ansi', {
      on_exit = function(_, exit_code)

        if exit_code == 0 then

          local output = get_fzf_output(picker.buffer)
          local file_name, line_num = output:match("([^:]+):(%d+)")
          local found_file = vim.fn.findfile(file_name, '.')

          vim.api.nvim_win_close(picker.win, true)

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
    local found_file = vim.fn.findfile(file_name, '.')
    if found_file ~= '' then
      vim.api.nvim_win_hide(M.state.win)
      vim.cmd('edit ' .. vim.fn.fnameescape(found_file))
    end
  end

  vim.keymap.set('n', opts.keymaps.terminal, M.toggle_terminal)
  vim.keymap.set('n', opts.keymaps.find_file, M.toggle_find_file)
  vim.keymap.set('n', opts.keymaps.live_grep, M.toggle_live_grep)
  vim.keymap.set('n', opts.keymaps.find_buffer, M.toggle_find_buffer)
  vim.keymap.set('t', opts.keymaps.normal_mode, '<c-\\><c-n>')
  vim.keymap.set('n', opts.keymaps.goto_file, M.goto_file, { buffer = M.state.buffer })
end

return M
