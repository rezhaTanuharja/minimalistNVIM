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

local find_command = table.concat({
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
}, " ")

local preview_cmd = [[
  sh -c 'if [ -z "{2}" ]; then
    cat "{1}";
  else
    start=$(( {2} > 10 ? {2} - 10 : 1 ));
    end=$(( {2} + 10 ));
    sed -n "${start},${end}p" "{1}";
  fi'
]]

local fzf_command = table.concat({
	"fzf",

	"--delimiter=:",
	"--multi",
	"--layout=reverse",
	"--header-first",
	"--bind 'ctrl-a:toggle-all'",
	"--bind=ctrl-t:toggle-preview",
	"--preview-window=hidden",
	"--preview=" .. vim.fn.shellescape(preview_cmd),
}, " ")

local rg_command = table.concat({
	"rg",

	"--vimgrep",
	"--ignore-case",
}, " ")

local gitdiff_command = function()

  local against = vim.fn.input("Compare against: ")

  return table.concat({
    "git",

    "diff",
    "--name-only",
    against .. "...HEAD",
  }, " ")
end

local state = {
	buffer = -1,
	win = -1,
}

local create_floating_window = function(buf)
	buf = buf or -1

	local width = function()
		return math.floor(vim.o.columns * 0.8)
	end
	local height = function()
		return math.floor(vim.o.lines * 0.8)
	end

	local col = math.floor((vim.o.columns - width()) / 2)
	local row = math.floor((vim.o.lines - height()) / 2)

	local buffer = nil
	if vim.api.nvim_buf_is_valid(buf) then
		buffer = buf
	else
		buffer = vim.api.nvim_create_buf(false, true)
	end

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

local handle_results = function(file_names, prefix)
  if prefix then
    for i, file_name in ipairs(file_names) do
      file_names[i] = prefix .. file_name
    end
  end

  if #file_names == 1 then
    vim.cmd("edit " .. file_names[1])
  else
    if vim.fn.argc() > 0 then
      vim.cmd("argdelete *")
    end

    vim.cmd("argadd " .. table.concat(file_names, " "))
  end
end

local handle_grep_results = function(output)
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

  vim.fn.setqflist({}, " ", { title = "Live Grep Results", items = qf_list })

  if #qf_list == 1 then
    local item = qf_list[1]
    vim.cmd(string.format("edit %s", item.filename))
    vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
  else
    vim.cmd("copen")
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
      vim.api.nvim_win_close(picker.win, true)

      if exit_code ~= 0 then
        vim.fn.delete(tmpfile)
        return
      end

      local file_names = vim.fn.readfile(tmpfile)
      handle_results(file_names)

			vim.fn.delete(tmpfile)
		end,
	})

	vim.cmd("startinsert")
end

local find_buffer = function()
	local buffer_list = vim.fn.tempname()
	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	vim.cmd("redir! > " .. buffer_list .. " | silent ls | redir END")

	vim.fn.jobstart(
		[[sed -n 's/.*"\(.*\)".*/\1/p' ]]
			.. buffer_list
			.. [[ | grep -v -E "term:|No Name" | ]]
			.. fzf_command
			.. " --header='Find a buffer' "
			.. " > "
			.. tmpfile,
		{
			term = true,
			on_exit = function(_, exit_code)
				vim.fn.delete(buffer_list)
        vim.api.nvim_win_close(picker.win, true)

        if exit_code ~= 0 then
          vim.fn.delete(tmpfile)
          return
        end

        local file_names = vim.fn.readfile(tmpfile)
        handle_results(file_names)

        vim.fn.delete(tmpfile)
      end,
    }
	)

	vim.cmd("startinsert")
end

local live_grep = function()
	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	local reload_command = string.format([[%s {q} -- || true]], rg_command)

	local fzf_bind = string.format([[ --bind 'change:reload(%s)' --ansi ]], reload_command)

	vim.fn.jobstart(fzf_command .. " --header='Live grep' " .. fzf_bind .. " > " .. tmpfile, {
		term = true,
		on_exit = function(_, exit_code)
      vim.api.nvim_win_close(picker.win, true)

      if exit_code ~= 0 then
        vim.fn.delete(tmpfile)
        return
      end

      local output = vim.fn.readfile(tmpfile)
      if #output > 0 then
        handle_grep_results(output)
      end
		end,
	})

	vim.cmd("startinsert")
end

local live_args_grep = function()
  -- Get current arglist
  local args = vim.fn.argv()
  
  if #args == 0 then
    return
  end
  
  local tmpfile = vim.fn.tempname()
  local picker = create_floating_window()
  
  -- Create the file list for rg
  local file_list = table.concat(args, " ")
  
  local reload_command = string.format([[%s {q} %s -- || true]], rg_command, file_list)
  
  local fzf_bind = string.format([[ --bind 'change:reload(%s)' --ansi ]], reload_command)

  vim.fn.jobstart(fzf_command .. " --header='Live args grep' " .. fzf_bind .. " > " .. tmpfile, {
    term = true,
    on_exit = function(_, exit_code)
      vim.api.nvim_win_close(picker.win, true)

      if exit_code ~= 0 then
        vim.fn.delete(tmpfile)
        return
      end

      local output = vim.fn.readfile(tmpfile)
      if #output > 0 then
        handle_grep_results(output)
      end

      vim.fn.delete(tmpfile)
    end,
  })

  vim.cmd("startinsert")
end

local find_gitdiff = function()
	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	vim.fn.jobstart(gitdiff_command() .. " | " .. fzf_command .. " --header='Updated Files'" .. " > " .. tmpfile, {
		term = true,
		on_exit = function(_, exit_code)
      vim.api.nvim_win_close(picker.win, true)

      if exit_code ~= 0 then
        vim.fn.delete(tmpfile)
        return
      end

      local file_names = vim.fn.readfile(tmpfile)
      local path_prefix = vim.fs.dirname(vim.fs.find(".git", { upward = true })[1]) .. "/"

      handle_results(file_names, path_prefix)

			vim.fn.delete(tmpfile)
		end,
	})

	vim.cmd("startinsert")
end

local refine_arglist = function()
  -- Get current arglist
  local args = vim.fn.argv()
  
  if #args == 0 then
    return
  end

  local tmpfile = vim.fn.tempname()
  local picker = create_floating_window()

  -- Create input for fzf from the arglist
  local args_input = table.concat(args, "\n")

	vim.fn.jobstart(
		"echo " .. vim.fn.shellescape(args_input) .. " | " .. fzf_command .. " --header='Argument List' " .. " > " .. tmpfile,
		{
			term = true,
			on_exit = function(_, exit_code)
        vim.api.nvim_win_close(picker.win, true)

        if exit_code ~= 0 then
          vim.fn.delete(tmpfile)
          return
        end

        local file_names = vim.fn.readfile(tmpfile)
        handle_results(file_names)

        vim.fn.delete(tmpfile)
			end,
		}
	)

	vim.cmd("startinsert")
end

local refine_quickfix = function()
  -- Get current quickfix list
  local qf_list = vim.fn.getqflist()
  
  if #qf_list == 0 then
    return
  end

  -- Format quickfix entries for display in fzf
  local qf_lines = {}
  local entry_map = {}
  
  for i, entry in ipairs(qf_list) do
    local filename = vim.fn.bufname(entry.bufnr)
    local line_text = string.format("%s:%d:%d:%s", filename, entry.lnum, entry.col, entry.text)
    table.insert(qf_lines, line_text)
    entry_map[line_text] = i -- Map display line back to original entry index
  end

  local tmpfile = vim.fn.tempname()
  local picker = create_floating_window()

  -- Create input for fzf from the quickfix entries
  local qf_input = table.concat(qf_lines, "\n")

  vim.fn.jobstart(
    "echo " .. vim.fn.shellescape(qf_input) .. " | " .. fzf_command .. " --header='Quickfix Entries' " .. " > " .. tmpfile,
    {
      term = true,
      on_exit = function(_, exit_code)
        vim.api.nvim_win_close(picker.win, true)

        if exit_code ~= 0 then
          vim.fn.delete(tmpfile)
          return
        end

        local selected_lines = vim.fn.readfile(tmpfile)
        if #selected_lines > 0 then
          -- Build filtered quickfix list from selected entries
          local filtered_qf = {}
          for _, line in ipairs(selected_lines) do
            local entry_idx = entry_map[line]
            if entry_idx then
              table.insert(filtered_qf, qf_list[entry_idx])
            end
          end

          -- Update quickfix list with filtered entries
          vim.fn.setqflist({}, " ", { title = "Refined Quickfix", items = filtered_qf })
          vim.cmd("copen")
        end

        vim.fn.delete(tmpfile)
      end,
    }
  )

  vim.cmd("startinsert")
end


vim.keymap.set("n", "<leader>t", toggle_terminal, { desc = "toggle a floating terminal" })
vim.keymap.set("n", "<leader>ff", _G.find_file, { desc = "fuzzy find file(s)" })
vim.keymap.set("n", "<leader>fd", find_gitdiff, { desc = "fuzzy find updated file(s)" })
vim.keymap.set("n", "<leader>fa", refine_arglist, { desc = "refine existing arglist" })
vim.keymap.set("n", "<leader>ga", live_args_grep, { desc = "live grep files in arglist" })
vim.keymap.set("n", "<leader>gq", refine_quickfix, { desc = "refine quickfix list" })
vim.keymap.set("n", "<leader>y", find_buffer, { desc = "fuzzy find open buffers" })
vim.keymap.set("t", "<C-u>", "<c-\\><c-n>", { desc = "faster exit insert mode in the terminal" })
vim.keymap.set( "n", "<leader>gg", live_grep, { desc = "project-wide live grep" })
