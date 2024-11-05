local M = {}

function M.get_output(_, message, _)
  vim.fn.append(vim.fn.line("$") - 1, message)
end

function M.job_exit(job, status, _)
  print('Prompt buffer ' .. job .. ' exited with status ' .. status)
  vim.cmd('quit!')
end

function M.start_shell()

  local shell_job = vim.fn.jobstart({ "/bin/sh" }, {
    on_stdout = M.get_output,
    on_stderr = M.get_output,
    on_exit = M.job_exit,
  })

  local function text_entered(text)
    vim.fn.chansend(shell_job, { text, '' })
  end

  vim.cmd('new')
  vim.bo.buftype = 'prompt'
  local buf = vim.fn.bufnr('')
  vim.fn.prompt_setcallback(buf, text_entered)
  vim.fn.prompt_setprompt(buf, 'Shell command: ')

  vim.cmd('startinsert')

end

return M
