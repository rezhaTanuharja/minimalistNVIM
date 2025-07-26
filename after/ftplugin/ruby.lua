---
-- @file after/ftplugin/ruby.lua
--
-- @brief
-- Ruby - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-07-08
--

--
-- Sets up development environment for Ruby.
--
-- + uses a global flag _G.ruby_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
--
_G.ruby_env_set = _G.ruby_env_set or (function()

  if vim.fn.executable("ruby-lsp") == 1 then
    vim.lsp.enable("ruby-lsp")
  end

  return true

end)()


vim.bo.makeprg = "bundle exec rspec %"
vim.bo.errorformat = "rspec %f:%l # %m"


local swap_app_and_spec = function()

  local file_name = vim.fn.expand("%")

  if file_name:find("app") then
    file_name = file_name:gsub("app", "spec")
    file_name = file_name:gsub(".rb", "_spec.rb")
  elseif file_name:find("spec") then
    file_name = file_name:gsub("_spec.rb", ".rb")
    file_name = file_name:gsub("spec", "app")
  end

  local _ = pcall(
    function()
      vim.cmd("edit " .. file_name)
    end
  )

end

vim.keymap.set(
  "n", "<leader>sf",
  swap_app_and_spec,
  {
    desc = "swap between app and spec file",
  }
)


local textobj_success, textobj = pcall(require, "textobjects")
if not textobj_success then
  vim.notify("failed to load a plugin: textobjects")
  return
end


vim.keymap.set(
  "n", "dim",
  function()
    local method_definition = textobj.get_node("singleton_method") or textobj.get_node("method")
    local body = textobj.get_field(method_definition, "body")[1]

    textobj.yank_node(body)
    textobj.delete_node(body)

    textobj.goto_node(method_definition)
  end,
  {
    desc = "delete the body of a method definition",
    buffer = true
  }
)

vim.keymap.set(
  "n", "dam",
  function()
    local method_definition = textobj.get_node("singleton_method") or textobj.get_node("method")

    textobj.yank_node(method_definition)
    textobj.delete_node(method_definition)
  end,
  {
    desc = "delete a method definition",
    buffer = true
  }
)

vim.keymap.set(
  "n", "yim",
  function()
    local method_definition = textobj.get_node("singleton_method") or textobj.get_node("method")
    local body = textobj.get_field(method_definition, "body")[1]

    textobj.yank_node(body)
  end,
  {
    desc = "yank the body of a method definition",
    buffer = true
  }
)

vim.keymap.set(
  "n", "yam",
  function()
    local method_definition = textobj.get_node("singleton_method") or textobj.get_node("method")

    textobj.yank_node(method_definition)
  end,
  {
    desc = "yank a method definition",
    buffer = true
  }
)

vim.keymap.set(
  "n", "gmn",
  function()
    local method_definition = textobj.get_node("singleton_method") or textobj.get_node("method")
    local name_fields = textobj.get_field(method_definition, "name")

    if not name_fields or #name_fields < 1 then
      return
    end

    textobj.goto_node(name_fields[1])
  end,
  {
    desc = "jump to method name",
    buffer = true
  }
)


local terminal_success, terminal = pcall(require, "terminal")
if not terminal_success then
  vim.notify("failed to load a plugin: terminal")
  return
end


vim.keymap.set(
  "n", "<leader>fm",
  function()
    local pattern = vim.fn.expand("%:t:r")

    pattern = pattern:gsub("_controller", "")
    pattern = pattern:gsub("_spec", "")

    terminal.toggle_find_file(pattern)
  end,
  {
    desc = "Find a file matching the current file name",
    buffer = true
  }
)
