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
  local path = vim.fn.getline('.')
  if vim.fn.filereadable(path) == 1 then
    vim.cmd('Bdelete!')
    vim.cmd('edit ' .. vim.fn.fnameescape(path))
  end
end


function M.start_shell()

  local shell_job = vim.fn.jobstart({ "/bin/sh" }, {
    on_stdout = M.get_output,
    on_stderr = M.get_output,
    on_exit = M.job_exit,

  })

  vim.fn.chansend(shell_job, { 'shopt -s globstar 2>/dev/null', '' })

  local function text_entered(text)
    vim.fn.chansend(shell_job, { text, '' })
  end

  local buffer = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_win_set_buf(0, buffer)
  vim.bo[buffer].buftype = 'prompt'

  vim.keymap.set('n', 'gf', M.goto_file, { buffer = buffer })

  vim.fn.prompt_setcallback(buffer, text_entered)
  vim.fn.prompt_setprompt(buffer, 'Shell command: ')

  vim.cmd('startinsert')

end


return M
