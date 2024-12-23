---
-- @file lua/plugins/terminal.lua
--
-- @brief
-- The configuration file for the terminal plugin
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-23
--


local opts = {}

opts.keymaps = {

  terminal = '<leader>t',
  find_file = '<leader>f',
  live_grep = '<leader>g',

  normal_mode = '<esc><esc>',

  goto_file = 'gf',

}

opts.window = {

  width = math.floor(vim.o.columns * 0.8),
  height = math.floor(vim.o.lines * 0.8),

  style = 'minimal',
  border = 'single',

}

opts.fzf_command = 'fzf'
opts.live_grep_command = 'fzf --bind "change:reload(grep -nr --color=never --ignore-case --exclude-dir=.git {q} . || true)" --ansi'

if vim.fn.executable('rg') == 1 then
  opts.live_grep_command = 'fzf --bind "change:reload(rg --line-number --color=never --ignore-case --follow {q} || true)" --ansi'
end

local fd_command = 'fd --type f --exclude "*.png" --exclude "*.pdf" --exclude "*.jp*g"'

if vim.fn.executable('fd') == 1 then
  opts.fzf_command = fd_command .. ' | ' .. opts.fzf_command
  opts.live_grep_command = fd_command .. ' | ' .. opts.live_grep_command
end

return {

  'terminal', dev = true,

  event = 'UIEnter',
  opts = opts,

}
