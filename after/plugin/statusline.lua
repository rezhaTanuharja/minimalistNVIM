---
-- @file after/plugin/statusline.lua
--
-- @brief
-- Configure the statusline
--
-- @author Tanuharja, R.A.
-- @date 2024-12-20
--


-- a function to obtain and format the current git branch

local function git_branch()

  local branch = vim.b.gitsigns_head

  if branch == nil then
    return " -- "
  end

  local added = vim.b.gitsigns_status_dict.added or 0
  local changed = vim.b.gitsigns_status_dict.changed or 0
  local removed = vim.b.gitsigns_status_dict.removed or 0

  return "%#statusline_branch# " .. branch .. " +" .. added .. " -" .. removed .. " ~" .. changed .. " "

end

-- a function to obtain and format the file name

local function file_name()

  local filename = vim.fn.expand("%:t")
  if filename == "" then
    filename = "[no name]"
  end

  if string.match(filename, "NvimTree") then
    filename = "NvimTree"
  end

  if vim.bo.buftype == "terminal" then
    filename = "terminal"
  end

  -- change highlight group based on if the file has been modified
  local highlight_group = vim.bo.modified and filename ~= "[no name]" and "statusline_modifiedfile" or "statusline_file"

  return "%#" .. highlight_group .. "# " .. filename .. " "

end

-- a function to obtain and format the current mode

local function current_mode()

  local mode = vim.fn.mode()

  local mode_aliases = {
    n = "n",
    i = "i",
    v = "v",
    V = "v",
    t = "t",
    c = "c",
    s = "s",
    [""] = "v",
  }

  mode = mode and mode_aliases[mode] and mode_aliases[mode]:upper() or "?"

  return "%#statusline_mode# " .. mode .. " "

end

-- a function to obtain and format the diagnostics

local function diagnostics()

  local num_warning = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN  })
  local num_error   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local num_hint    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT  })
  local num_info    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO  })

  return "%#statusline_diagnostics# " .. "E" .. num_error .. " W" .. num_warning .. " H" .. num_hint .. " I" .. num_info .. " "

end

-- a function to display the current debugger session

local function debugger_session()

  local success, dap = pcall(require, "dap")
  if not success then
    return ""
  end

  local active_session = dap.session()

  if active_session == nil then
    return ""
  end

  return "%#statusline_debugger_session# " .. active_session.config.name .. " "

end

-- a function to display the current search position

local function search_position()

  local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
  if not ok or result.total == 0 then
    return "" 
  end

  return "%#statusline_misc# " .. vim.fn.getreg("/") .. " [" .. result.current .. "/" .. result.total .. "] "

end

-- a function to assign highlight group to the separator

local function separator()

  local highlight_group = "statusline_separator"
  return "%#" .. highlight_group .. "#%="

end

local function miscellaneous()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return search_position()
  else
    return "%#statusline_misc# recording @" .. reg
  end
end


-- a function to call and place the statusline components

function Status_line()

  return table.concat({

    file_name(),
    diagnostics(),
    debugger_session(),

    separator(),

    miscellaneous(),
    git_branch(),
    current_mode(),

  })

end

-- default with statusline but can be toggled with <leader>s

vim.opt["laststatus"] = 3

vim.keymap.set( "n", "<leader>s",

  function()

    if vim.o.laststatus == 0 then
      vim.cmd("set laststatus=3")
    else
      vim.cmd("set laststatus=0")
    end

  end

)

vim.cmd("set statusline=%!v:lua.Status_line()")

vim.cmd([[
  augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal cursorline
    au WinLeave,BufLeave * setlocal nocursorline
]])


-- set colors for each statusline components

local group_styles = {

  ["statusline_file"]             = { fg = "#EEEEEE", bg = "#333333", bold = true },
  ["statusline_modifiedfile"]     = { fg = "#000000", bg = "#CCCCCC", bold = true },
  ["statusline_diagnostics"]      = { fg = "#EEEEEE", bg = "#222222" },
  ["statusline_debugger_session"] = { fg = "#CCCCCC", bg = "None" },

  ["statusline_separator"]    = { fg = "#333333", bg = "None" },

  ["statusline_misc"]   = { fg = "#CCCCCC", bg = "None" },
  ["statusline_branch"] = { fg = "#EEEEEE", bg = "#222222" },
  ["statusline_mode"]   = { fg = "#EEEEEE", bg = "#333333", bold = true },

}

for group, style in pairs(group_styles) do
  vim.api.nvim_set_hl(0, group, style)
end
