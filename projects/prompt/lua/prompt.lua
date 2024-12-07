local M = {}


function M.get_output(_, message, _)
  vim.fn.append(vim.fn.line("$") - 1, message)
end


function M.job_exit(job, status, _)
  print('Prompt buffer ' .. job .. ' exited with status ' .. status)
  vim.cmd('stopinsert')
  vim.cmd('Bdelete!')
end


function M.goto_file()
  local file_name = vim.fn.expand('<cword>')
  local found_file = vim.fn.findfile(file_name, vim.o.path)
  if found_file ~= '' then
    vim.cmd('Bdelete!')
    vim.cmd('edit ' .. vim.fn.fnameescape(found_file))
  end
end


function M.setup(opts)

  M.start_shell = function()

    local shell_job = vim.fn.jobstart({ "/bin/sh" }, {
      on_stdout = M.get_output,
      on_stderr = M.get_output,
      on_exit = M.job_exit,

    })

    for _, shell_option in pairs(opts.shopt) do
      vim.fn.chansend(shell_job, { 'shopt -s ' .. shell_option .. ' 2>/dev/null', '' })
    end

    local function text_entered(text)
      vim.fn.chansend(shell_job, { text, '' })
    end

    local buffer = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(0, buffer)
    vim.bo[buffer].buftype = 'prompt'

    local is_keyword = vim.bo[buffer].iskeyword
    vim.bo[buffer].iskeyword = is_keyword .. ',.,/,-'

    vim.keymap.set('n', opts.keymaps.goto_file, M.goto_file, { buffer = buffer })

    vim.fn.prompt_setcallback(buffer, text_entered)
    vim.fn.prompt_setprompt(buffer, 'Shell command: ')

    vim.cmd('startinsert')

  end

  vim.keymap.set('n', opts.keymaps.start_shell, M.start_shell)

end


return M
