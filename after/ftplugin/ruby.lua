---
-- @file after/ftplugin/ruby.lua
--
-- @brief
-- Ruby - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-07-08
--

if vim.fn.executable("ruby-lsp") == 1 then
  vim.lsp.enable("ruby-lsp")
end

vim.bo.makeprg = "bundle exec rspec %"
vim.bo.errorformat = "rspec %f:%l # %m"


local swap_service_and_spec = function()

  file_name = vim.fn.expand("%")

  if file_name:find("app") then
    file_name = file_name:gsub("app", "spec")
    file_name = file_name:gsub(".rb", "_spec.rb")
  elseif file_name:find("spec") then
    file_name = file_name:gsub("_spec.rb", ".rb")
    file_name = file_name:gsub("spec", "app")
  end

  local _ = pcall(vim.cmd, "edit " .. file_name)

end

vim.keymap.set(
  "n", "<leader>sf",
  swap_service_and_spec,
  {
    desc = "swap between service and spec file",
  }
)
