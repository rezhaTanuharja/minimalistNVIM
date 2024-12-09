
local function get_output(_, message, _)
  vim.fn.append(vim.fn.line("$") - 1, message)
end

local function job_exit(job, status, _)
  print('Prompt buffer ' .. job .. ' exited with status ' .. status)
  vim.cmd('stopinsert')
  vim.cmd('Bdelete!')
end


local function goto_file()
  local file_name = vim.fn.expand('<cword>')
  local found_file = vim.fn.findfile(file_name, vim.o.path)
  if found_file ~= '' then
    vim.cmd('Bdelete!')
    vim.cmd('edit ' .. vim.fn.fnameescape(found_file))
  end
end

local shopt = {
  'globstar',
}

local function start_shell()

  local shell_job = vim.fn.jobstart({ "/bin/sh" }, {
    on_stdout = get_output,
    on_stderr = get_output,
    on_exit = job_exit,

  })

  for _, shell_option in pairs(shopt) do
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

  vim.keymap.set('n', 'gf', goto_file, { buffer = buffer })

  vim.fn.prompt_setcallback(buffer, text_entered)
  vim.fn.prompt_setprompt(buffer, 'Shell command: ')

  vim.cmd('startinsert')

end

vim.keymap.set('n', '<leader>pp', start_shell)
