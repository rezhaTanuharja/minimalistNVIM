---
-- @file lua/rezha/pluginConfig/lsp/mason.lua
--
-- @brief
-- The configuration file for the plugin mason
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local location = "rezha.pluginConfig.lsp"

local servers = {
  "pyright",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "i",
      package_pending = "p",
      package_uninstalled = "u",
    },
  },
  log_level = vim.log.levels.ERROR,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local success, lspconfig = pcall(require, "lspconfig")
if not success then
  vim.notify("Error loading plugin: lspconfig")
  return
end

local opts = {}

for _, server in pairs(servers) do

  opts = {
    on_attach = require(location .. ".handlers").on_attach,
    capabilities = require(location .. ".handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, location .. ".settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
