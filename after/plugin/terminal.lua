---
-- 
-- @file after/plugin/terminal.lua
--
-- @brief
-- The plugin file for terminal
--
-- @author Tanuharja, R.A.
-- @date 2025-07-27
--


local find_command = table.concat(
  {
    "fd",

    "--type f",
    "--full-path",
    "--no-require-git",
    '--exclude "*.png"',
    '--exclude "*.pdf"',
    '--exclude "*.jp*g"',
    '--exclude "*.aux"',
    '--exclude "*.vtu"',
    '--exclude "*.docx"',
    '--exclude "*.xlsx"',
    '--exclude "*.pptx"',
    '--exclude "*.o"',
    '--exclude "*.so"',
    '--exclude "*.bin"',
    '--exclude "*.ipynb"',

    '--exclude "**/*cache*/**"',
    '--exclude "**/build/**"',
  },
  " "
)

local preview_cmd = [[
  sh -c 'if [ -z "{2}" ]; then
    cat "{1}";
  else
    start=$(( {2} > 10 ? {2} - 10 : 1 ));
    end=$(( {2} + 10 ));
    sed -n "${start},${end}p" "{1}";
  fi'
]]

local fzf_command = table.concat(
  {
    "fzf",

    "--delimiter=:",
    "--multi",
    "--layout=reverse",
    "--header-first",
    "--bind 'ctrl-a:toggle-all'",
    "--bind=ctrl-/:toggle-preview",
    "--preview-window=hidden",
    "--preview=" .. vim.fn.shellescape(preview_cmd),
  },
  " "
)

local rg_command = table.concat(
  {
    "rg",

    "--vimgrep",
    "--ignore-case",
  },
  " "
)

local gitdiff_command = table.concat(
  {
    "git",

    "diff",
    "--name-only",
    "main...HEAD",
  },
  " "
)

local state = {
  buffer = -1,
  win = -1,
}


local create_floating_window = function(buf)
  buf = buf or -1

  local width = function() return math.floor(vim.o.columns * 0.8) end
  local height = function() return math.floor(vim.o.lines * 0.8) end

  local col = math.floor((vim.o.columns - width()) / 2)
  local row = math.floor((vim.o.lines - height()) / 2)

  local buffer = nil
  if vim.api.nvim_buf_is_valid(buf) then
    buffer = buf
  else
    buffer = vim.api.nvim_create_buf(false, true) end

  local win_config = {
    relative = "editor",
    width = width(),
    height = height(),
    col = col,
    row = row,
    style = "minimal",
    border = "single", 
  }

  local win = vim.api.nvim_open_win(buffer, true, win_config)

  return { buffer = buffer, win = win }
end

local toggle_terminal = function()

  if not vim.api.nvim_win_is_valid(state.win) then
    state = create_floating_window(state.buffer)

    if vim.bo[state.buffer].buftype ~= "terminal" then

      vim.cmd.terminal()

      local is_keyword = vim.bo[state.buffer].iskeyword
      vim.bo[state.buffer].iskeyword = is_keyword .. ",.,/,-"

    end
  else
    vim.api.nvim_win_hide(state.win)
  end

end


_G.find_file = function(pattern)

  local find_file_with_pattern = find_command

  if pattern then
    find_file_with_pattern = find_file_with_pattern .. " '" .. pattern .. "'"
  end

  local tmpfile = vim.fn.tempname()
  local picker = create_floating_window()

  vim.fn.jobstart(find_file_with_pattern .. " | " .. fzf_command .. " --header='Find a file'" .. " > " .. tmpfile, {
    term = true,
    on_exit = function(_, exit_code)

      if exit_code == 0 then

        local file_names = vim.fn.readfile(tmpfile)

        vim.api.nvim_win_close(picker.win, true)

        if #file_names == 1 then
          vim.cmd("edit " .. file_names[1])
        else
          if vim.fn.argc() > 0 then
            vim.cmd("argdelete *")
          end

          vim.cmd("argedit " .. table.concat(file_names, " "))
        end

      else
        vim.api.nvim_win_close(picker.win, true)
      end

      vim.fn.delete(tmpfile)

    end
  })

  vim.cmd("startinsert")

end

local find_buffer = function()

  local buffer_list = vim.fn.tempname()
  local tmpfile = vim.fn.tempname()
  local picker = create_floating_window()

  vim.cmd("redir! > " .. buffer_list .. " | silent ls | redir END")

  vim.fn.jobstart([[sed -n 's/.*"\(.*\)".*/\1/p' ]] .. buffer_list .. [[ | grep -v -E "term:|No Name" | ]] .. fzf_command .. " --header='Find a buffer' " .. " > " .. tmpfile, {
    term = true,
    on_exit = function(_, exit_code)

      vim.fn.delete(buffer_list)

      if exit_code == 0 then

        local file_name = vim.fn.readfile(tmpfile)[1]
        local found_file = vim.fn.findfile(file_name, vim.o.path)

        vim.api.nvim_win_close(picker.win, true)

        if found_file ~= "" then
          vim.cmd("drop " .. vim.fn.fnameescape(found_file))
        end

      else
        vim.api.nvim_win_close(picker.win, true)
      end

      vim.fn.delete(tmpfile)

    end
  })

  vim.cmd("startinsert")

end

local live_grep = function()

  local tmpfile = vim.fn.tempname()
  local picker = create_floating_window()

  local reload_command = string.format(
    [[%s {q} -- || true]],
    rg_command
  )
  
  local fzf_bind = string.format(
    [[ --bind 'change:reload(%s)' --ansi ]],
    reload_command
  )

  vim.fn.jobstart(fzf_command .. " --header='Live grep' " .. fzf_bind .. " > " .. tmpfile, {
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

          vim.fn.setqflist({}, ' ', { title = 'Live Grep Results', items = qf_list })

          vim.api.nvim_win_close(picker.win, true)

          if #qf_list == 1 then
            local item = qf_list[1]
            vim.cmd(string.format("edit %s", item.filename))
            vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
          else
            vim.cmd("copen")
          end

        end

      else
        vim.api.nvim_win_close(picker.win, true)
      end

      vim.fn.delete(tmpfile)

    end
  })

  vim.cmd("startinsert")

end

local live_current_grep = function()

  local extension = vim.fn.expand("%:e")

  local reload_command = string.format(
    [[%s --extension %s | xargs %s {q} -- || true]],
    find_command,
    extension,
    rg_command
  )
  
  local fzf_bind = string.format(
    [[ --bind 'change:reload(%s)' --ansi ]],
    reload_command
  )

  local tmpfile = vim.fn.tempname()
  local picker = create_floating_window()

  vim.fn.jobstart(fzf_command .. " --header='Live current grep' " .. fzf_bind .. " > " .. tmpfile, {
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

          vim.fn.setqflist({}, ' ', { title = 'Live Grep Results', items = qf_list })

          vim.api.nvim_win_close(picker.win, true)

          if #qf_list == 1 then
            local item = qf_list[1]
            vim.cmd(string.format("edit %s", item.filename))
            vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
          else
            vim.cmd("copen")
          end

        end

      else
        vim.api.nvim_win_close(picker.win, true)
      end

      vim.fn.delete(tmpfile)

    end
  })

  vim.cmd("startinsert")

end

local find_gitdiff = function()

  local tmpfile = vim.fn.tempname()
  local picker = create_floating_window()

  vim.fn.jobstart(gitdiff_command .. " | " .. fzf_command .. " --header='Updated Files'" .. " > " .. tmpfile, {
    term = true,
    on_exit = function(_, exit_code)

      if exit_code == 0 then

        local file_names = vim.fn.readfile(tmpfile)

        vim.api.nvim_win_close(picker.win, true)

        local git_root = vim.fs.root(0, '.git')
        for idx, file_name in ipairs(file_names) do
          file_names[idx] = git_root .. "/" .. file_names[idx]
        end

        if #file_names == 1 then
          vim.cmd("edit " .. file_names[1])
        else
          if vim.fn.argc() > 0 then
            vim.cmd("argdelete *")
          end

          vim.cmd("argedit " .. table.concat(file_names, " "))
        end

      else
        vim.api.nvim_win_close(picker.win, true)
      end

      vim.fn.delete(tmpfile)

    end
  })

  vim.cmd("startinsert")

end

vim.keymap.set("n", "<leader>t", toggle_terminal, { desc = "toggle a floating terminal" })
vim.keymap.set("n", "<leader>ff", _G.find_file, { desc = "fuzzy find file(s)" })
vim.keymap.set("n", "<leader>fd", find_gitdiff, { desc = "fuzzy find updated file(s)" })
vim.keymap.set("n", "<leader>ga", live_grep, { desc = "live grep with rg and fzf" })
vim.keymap.set("n", "<leader>y", find_buffer, { desc = "fuzzy find open buffers and use drop instead of edit" })
vim.keymap.set("t", "<C-u>", "<c-\\><c-n>", { desc = "faster exit insert mode in the terminal" })
vim.keymap.set("n", "<leader>gg", live_current_grep, { desc = "live grep but only search files with the same extension as the current one" })
