---
--
-- @file after/plugin/terminal.lua
--
-- @brief
-- Terminal and fuzzy finder utilities
--
-- @author Tanuharja, R.A.
-- @date 2025-07-27
--

-- ============================================================================
-- CONFIGURATION
-- ============================================================================

local find_command = table.concat({
	"fd",
	"--type f",
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

local rg_command = table.concat({
	"rg",
	"--vimgrep",
	"--ignore-case",
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

-- Terminal state
local terminal_state = {
	buffer = -1,
	win = -1,
}

-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================

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

local create_fzf_picker = function(input, header, callback)
	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	local command = "echo " .. vim.fn.shellescape(input) .. " | " .. fzf_command .. " --header='" .. header .. "' > " .. tmpfile

	vim.fn.jobstart(command, {
		term = true,
		on_exit = function(_, exit_code)
			vim.api.nvim_win_close(picker.win, true)

			if exit_code ~= 0 then
				vim.fn.delete(tmpfile)
				return
			end

			local results = vim.fn.readfile(tmpfile)
			vim.fn.delete(tmpfile)

			if #results > 0 then
				callback(results)
			end
		end,
	})

	vim.cmd("startinsert")
end

local create_live_picker = function(header, reload_cmd, callback)
	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	local fzf_bind = string.format([[ --bind 'change:reload(%s)' --ansi ]], reload_cmd)

	vim.fn.jobstart(fzf_command .. " --header='" .. header .. "' " .. fzf_bind .. " > " .. tmpfile, {
		term = true,
		on_exit = function(_, exit_code)
			vim.api.nvim_win_close(picker.win, true)

			if exit_code ~= 0 then
				vim.fn.delete(tmpfile)
				return
			end

			local results = vim.fn.readfile(tmpfile)
			vim.fn.delete(tmpfile)

			if #results > 0 then
				callback(results)
			end
		end,
	})

	vim.cmd("startinsert")
end



local gitdiff_command = function()
	local against = vim.fn.input("Compare against: ")

	return table.concat({
		"git",
		"diff",
		"--name-only",
		against .. "...HEAD",
	}, " ")
end

-- ============================================================================
-- RESULT HANDLERS
-- ============================================================================

local handle_file_results = function(file_names, prefix)
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

-- ============================================================================
-- TERMINAL FUNCTIONS
-- ============================================================================

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(terminal_state.win) then
		terminal_state = create_floating_window(terminal_state.buffer)

		if vim.bo[terminal_state.buffer].buftype ~= "terminal" then
			vim.cmd.terminal()

			local is_keyword = vim.bo[terminal_state.buffer].iskeyword
			vim.bo[terminal_state.buffer].iskeyword = is_keyword .. ",.,/,-"
		end
	else
		vim.api.nvim_win_hide(terminal_state.win)
	end
end

-- ============================================================================
-- FINDER FUNCTIONS
-- ============================================================================

_G.find_file = function(pattern)
	local find_file_with_pattern = find_command

	if pattern then
		find_file_with_pattern = find_file_with_pattern .. " '" .. pattern .. "'"
	end

	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	vim.fn.jobstart(find_file_with_pattern .. " | " .. fzf_command .. " --header='Find a file' > " .. tmpfile, {
		term = true,
		on_exit = function(_, exit_code)
			vim.api.nvim_win_close(picker.win, true)

			if exit_code ~= 0 then
				vim.fn.delete(tmpfile)
				return
			end

			local file_names = vim.fn.readfile(tmpfile)
			handle_file_results(file_names)

			vim.fn.delete(tmpfile)
		end,
	})

	vim.cmd("startinsert")
end

local find_buffer = function()
	local buffers = {}

	for _, bufinfo in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		local name = bufinfo.name
		if name ~= "" and not name:match("term:") then
			table.insert(buffers, name)
		end
	end

	if #buffers == 0 then
		return
	end

	local buffer_input = table.concat(buffers, "\n")
	create_fzf_picker(buffer_input, "Find a buffer", handle_file_results)
end

local find_gitdiff = function()
	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	vim.fn.jobstart(gitdiff_command() .. " | " .. fzf_command .. " --header='Updated Files' > " .. tmpfile, {
		term = true,
		on_exit = function(_, exit_code)
			vim.api.nvim_win_close(picker.win, true)

			if exit_code ~= 0 then
				vim.fn.delete(tmpfile)
				return
			end

			local file_names = vim.fn.readfile(tmpfile)
			local path_prefix = vim.fs.dirname(vim.fs.find(".git", { upward = true })[1]) .. "/"

			handle_file_results(file_names, path_prefix)

			vim.fn.delete(tmpfile)
		end,
	})

	vim.cmd("startinsert")
end

local find_git_working = function()
	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	local command = "git diff --name-only HEAD | " .. fzf_command .. " --header='Staged & Unstaged Files' > " .. tmpfile

	vim.fn.jobstart(command, {
		term = true,
		on_exit = function(_, exit_code)
			vim.api.nvim_win_close(picker.win, true)

			if exit_code ~= 0 then
				vim.fn.delete(tmpfile)
				return
			end

			local file_names = vim.fn.readfile(tmpfile)
			local path_prefix = vim.fs.dirname(vim.fs.find(".git", { upward = true })[1]) .. "/"

			handle_file_results(file_names, path_prefix)

			vim.fn.delete(tmpfile)
		end,
	})

	vim.cmd("startinsert")
end

-- ============================================================================
-- GREP FUNCTIONS
-- ============================================================================

local live_grep = function()
	local reload_command = string.format([[%s {q} -- || true]], rg_command)
	create_live_picker("Live grep", reload_command, handle_grep_results)
end

local live_args_grep = function()
	local args = vim.fn.argv()

	if #args == 0 then
		return
	end

	local file_list = table.concat(args, " ")
	local reload_command = string.format([[%s {q} %s -- || true]], rg_command, file_list)
	create_live_picker("Live args grep", reload_command, handle_grep_results)
end

local handle_buffer_results = function(results)
	local current_file = vim.fn.expand("%:p")
	
	if #results == 1 then
		-- Single result: jump to line
		local first_result = results[1]
		local line_num = first_result:match("^%s*(%d+)")
		if line_num then
			vim.api.nvim_win_set_cursor(0, { tonumber(line_num), 0 })
		end
	else
		-- Multiple results: create quickfix list
		local qf_list = {}
		for _, line in ipairs(results) do
			local line_num, text = line:match("^%s*(%d+)%s*(.*)$")
			if line_num then
				table.insert(qf_list, {
					filename = current_file,
					lnum = tonumber(line_num),
					col = 1,
					text = text,
				})
			end
		end
		
		vim.fn.setqflist({}, " ", { title = "Buffer Lines", items = qf_list })
		vim.cmd("copen")
	end
end

local live_buffer_grep = function()
	local current_file = vim.fn.expand("%:p")

	if current_file == "" then
		return
	end

	local tmpfile = vim.fn.tempname()
	local picker = create_floating_window()

	-- Simple: cat with line numbers, feed to fzf (no sorting to preserve line order)
	local command = "cat -n " .. vim.fn.shellescape(current_file) .. " | " .. fzf_command .. " --no-sort --header='Current Buffer Lines' > " .. tmpfile

	vim.fn.jobstart(command, {
		term = true,
		on_exit = function(_, exit_code)
			vim.api.nvim_win_close(picker.win, true)

			if exit_code ~= 0 then
				vim.fn.delete(tmpfile)
				return
			end

			local results = vim.fn.readfile(tmpfile)
			vim.fn.delete(tmpfile)

			if #results > 0 then
				handle_buffer_results(results)
			end
		end,
	})

	vim.cmd("startinsert")
end

-- ============================================================================
-- REFINE FUNCTIONS
-- ============================================================================

local refine_arglist = function()
	local args = vim.fn.argv()

	if #args == 0 then
		return
	end

	local args_input = table.concat(args, "\n")
	create_fzf_picker(args_input, "Argument List", handle_file_results)
end

local refine_quickfix = function()
	local qf_list = vim.fn.getqflist()

	if #qf_list == 0 then
		return
	end

	local qf_lines = {}
	local entry_map = {}

	for i, entry in ipairs(qf_list) do
		local filename = vim.fn.bufname(entry.bufnr)
		local line_text = string.format("%s:%d:%d:%s", filename, entry.lnum, entry.col, entry.text)
		table.insert(qf_lines, line_text)
		entry_map[line_text] = i
	end

	local qf_input = table.concat(qf_lines, "\n")

	create_fzf_picker(qf_input, "Quickfix Entries", function(selected_lines)
		local filtered_qf = {}
		for _, line in ipairs(selected_lines) do
			local entry_idx = entry_map[line]
			if entry_idx then
				table.insert(filtered_qf, qf_list[entry_idx])
			end
		end

		vim.fn.setqflist({}, " ", { title = "Refined Quickfix", items = filtered_qf })
		vim.cmd("copen")
	end)
end

-- ============================================================================
-- KEYMAPS
-- ============================================================================

vim.keymap.set("n", "<leader>t", toggle_terminal, { desc = "toggle a floating terminal" })

-- Find functions
vim.keymap.set("n", "<leader>ff", _G.find_file, { desc = "fuzzy find file(s)" })
vim.keymap.set("n", "<leader>fd", find_gitdiff, { desc = "fuzzy find updated file(s)" })
vim.keymap.set("n", "<leader>fw", find_git_working, { desc = "fuzzy find staged/unstaged file(s)" })
vim.keymap.set("n", "<leader>y", find_buffer, { desc = "fuzzy find open buffers" })

-- Grep functions
vim.keymap.set("n", "<leader>gg", live_grep, { desc = "project-wide live grep" })
vim.keymap.set("n", "<leader>ga", live_args_grep, { desc = "live grep files in arglist" })
vim.keymap.set("n", "<leader>gb", live_buffer_grep, { desc = "live grep current buffer" })

-- Refine functions
vim.keymap.set("n", "<leader>fa", refine_arglist, { desc = "refine existing arglist" })
vim.keymap.set("n", "<leader>gq", refine_quickfix, { desc = "refine quickfix list" })

-- Terminal keymaps
vim.keymap.set("t", "<C-u>", "<c-\\><c-n>", { desc = "faster exit insert mode in the terminal" })