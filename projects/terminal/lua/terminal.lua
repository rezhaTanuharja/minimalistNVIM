---
-- @file projects/terminal/lua/terminal.lua
--
-- @brief
-- The plugin file for terminal
--
-- @author Tanuharja, R.A.
-- @date 2024-12-23
--


local M = {}

M.state = {
  buffer = -1,
  win = -1,
}

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
      relative = "editor",
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
    fzf_command = fzf_command .. " " .. arg
  end

  local fd_command = opts.fd.executable

  for _, arg in pairs(opts.fd.args) do
    fd_command = fd_command .. " " .. arg
  end

  local rg_command = opts.rg.executable .. " --line-number --color=never"

  for _, arg in pairs(opts.rg.args) do
    rg_command = rg_command .. " " .. arg
  end

  M.toggle_find_file = function()

    local tmpfile = vim.fn.tempname()
    local picker = M.create_floating_window()

    vim.fn.jobstart(fd_command .. " | " .. fzf_command .. " > " .. tmpfile, {
      term = true,
      on_exit = function(_, exit_code)

        if exit_code == 0 then

          local file_name = vim.fn.readfile(tmpfile)[1]
          local found_file = vim.fn.findfile(file_name, vim.o.path)

          vim.api.nvim_win_close(picker.win, true)

          if found_file ~= "" then
            vim.cmd("edit " .. vim.fn.fnameescape(found_file))
          end


        else
          vim.api.nvim_win_close(picker.win, true)
        end

        vim.fn.delete(tmpfile)

      end
    })

    vim.cmd("startinsert")

  end

  M.toggle_find_buffer = function()

    local buffer_list = vim.fn.tempname()
    local tmpfile = vim.fn.tempname()
    local picker = M.create_floating_window()

    vim.cmd("redir! > " .. buffer_list .. " | silent ls | redir END")

    vim.fn.jobstart([[sed -n 's/.*"\(.*\)".*/\1/p' ]] .. buffer_list .. [[ | grep -v -E "term:|No Name" | ]] .. fzf_command .. " > " .. tmpfile, {
      term = true,
      on_exit = function(_, exit_code)

        vim.fn.delete(buffer_list)

        if exit_code == 0 then

          local file_name = vim.fn.readfile(tmpfile)[1]
          local found_file = vim.fn.findfile(file_name, vim.o.path)

          vim.api.nvim_win_close(picker.win, true)

          if found_file ~= "" then
            vim.cmd("edit " .. vim.fn.fnameescape(found_file))
          end

        else
          vim.api.nvim_win_close(picker.win, true)
        end

        vim.fn.delete(tmpfile)

      end
    })

    vim.cmd("startinsert")

  end

  M.toggle_live_grep = function()

    local tmpfile = vim.fn.tempname()
    local picker = M.create_floating_window()

    local reload_command = string.format(
      [[%s | xargs %s {q} -- || true]],
      fd_command,
      rg_command
    )
    
    local fzf_bind = string.format(
      [[ --bind 'change:reload(%s)' --ansi ]],
      reload_command
    )

    vim.fn.jobstart(fzf_command .. fzf_bind .. " > " .. tmpfile, {
      term = true,
      on_exit = function(_, exit_code)

        if exit_code == 0 then

          local output = vim.fn.readfile(tmpfile)

          if #output > 0 then

            local qf_list = {}

            for _, line in ipairs(output) do
              local file, row, col, text = line:match("^(.-):(%d+):(%d+):(.*)$")

              table.insert(qf_list, {
                filename = file,
                lnum = tonumber(row),
                col = tonumber(col),
                text = text,
              })
            end

            if #qf_list > 0 then
              vim.fn.setqflist({}, ' ', { title = 'Live Grep Results', items = qf_list })
              vim.cmd("copen")
            end
          end
        end

        vim.api.nvim_win_close(picker.win, true)
        vim.fn.delete(tmpfile)

      end
    })

    vim.cmd("startinsert")

  end

  M.toggle_live_current_grep = function()

    local extension = vim.fn.expand("%:e")

    local reload_command = string.format(
      [[%s --extension %s | xargs %s {q} -- || true]],
      fd_command,
      extension,
      rg_command
    )
    
    local fzf_bind = string.format(
      [[ --bind 'change:reload(%s)' --ansi ]],
      reload_command
    )

    local tmpfile = vim.fn.tempname()
    local picker = M.create_floating_window()

    vim.fn.jobstart(fzf_command .. fzf_bind .. " > " .. tmpfile, {
      term = true,
      on_exit = function(_, exit_code)

        if exit_code == 0 then

          local output = vim.fn.readfile(tmpfile)

          if #output > 0 then

            local qf_list = {}

            for _, line in ipairs(output) do
              local file, row, col, text = line:match("^(.-):(%d+):(%d+):(.*)$")

              table.insert(qf_list, {
                filename = file,
                lnum = tonumber(row),
                col = tonumber(col),
                text = text,
              })
            end

            if #qf_list > 0 then
              vim.fn.setqflist({}, ' ', { title = 'Live Grep Results', items = qf_list })
              vim.cmd("copen")
            end
          end
        end

        vim.api.nvim_win_close(picker.win, true)
        vim.fn.delete(tmpfile)

      end
    })

    vim.cmd("startinsert")

  end

  M.lazygit = function()

    local picker = M.create_floating_window()

    vim.fn.jobstart("lazygit", {
      term = true,
      on_exit = function(_, _)
        vim.api.nvim_win_close(picker.win, true)
      end
    })

    vim.opt_local.sidescrolloff = 0
    vim.cmd("startinsert")

  end

  M.toggle_terminal = function()

    if not vim.api.nvim_win_is_valid(M.state.win) then
      M.state = M.create_floating_window(M.state.buffer)

      if vim.bo[M.state.buffer].buftype ~= "terminal" then

        vim.cmd.terminal()

        local is_keyword = vim.bo[M.state.buffer].iskeyword
        vim.bo[M.state.buffer].iskeyword = is_keyword .. ",.,/,-"

      end
    else
      vim.api.nvim_win_hide(M.state.win)
    end

  end

  M.goto_file = function()
    local file_name = vim.fn.expand("<cword>")
    local found_file = vim.fn.findfile(file_name, ".")
    if found_file ~= "" then
      vim.api.nvim_win_hide(M.state.win)
      vim.cmd("edit " .. vim.fn.fnameescape(found_file))
    end
  end

  vim.keymap.set("n", opts.keymaps.terminal, M.toggle_terminal)
  vim.keymap.set("n", opts.keymaps.find_file, M.toggle_find_file)
  vim.keymap.set("n", opts.keymaps.live_grep, M.toggle_live_grep)
  vim.keymap.set("n", opts.keymaps.find_buffer, M.toggle_find_buffer)
  vim.keymap.set("t", opts.keymaps.normal_mode, "<c-\\><c-n>")
  vim.keymap.set("n", opts.keymaps.goto_file, M.goto_file, { buffer = M.state.buffer })
  vim.keymap.set("n", opts.keymaps.live_current_grep, M.toggle_live_current_grep)

  if vim.fn.executable("lazygit") == 1 then
    vim.keymap.set("n", opts.keymaps.lazygit, M.lazygit)
  end
end

return M
