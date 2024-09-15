---
-- @file lua/profiles/rezha/plugins/lsp.lua
--
-- @brief
-- The configuration file for the plugin lsp
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


-- a function to return a table of on_attach and capabilities
local function get_handlers()

  local handlers = {}

  local cmp_nvim_lsp
  success, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if not success then
    vim.notify('Failed to load plugin: cmp_nvim_lsp')
    return
  end

  handlers.capabilities = vim.lsp.protocol.make_client_capabilities()
  handlers.capabilities.textDocument.completion.completionItem.snippetSupport = true
  handlers.capabilities = cmp_nvim_lsp.default_capabilities(handlers.capabilities)

  local function lsp_keymaps(bufnr)
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  end

  handlers.on_attach = function(client, bufnr)

    if client.name == 'tsserver' then
      client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == 'lua_ls' then
      client.server_capabilities.documentFormattingProvider = false
    end

    lsp_keymaps(bufnr)
    local success, illuminate = pcall(require, 'illuminate')
    if not success then
      vim.notify('Failed to load plugin: illuminate')
      return
    end

    illuminate.on_attach(client)

  end

  return handlers

end


return {

  -- github repository for lsp
  'neovim/nvim-lspconfig',

  -- load when entering the buffer
  event = 'UIEnter',

  dependencies = {

    require('pluginsetup.mason'),

    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',

    'RRethy/vim-illuminate',
  },
    
  config = function()

    local signs = {
      {name = 'DiagnosticSignError', text = '!'},
      {name = 'DiagnosticSignWarn', text = '!'},
      {name = 'DiagnosticSignHint', text = '?'},
      {name = 'DiagnosticSignInfo', text = '*'},
    }

    for _, sign in pairs(signs) do
      vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ''})
    end

    local config = {
      virtual_text = false,
      signs = {
        active = signs,
      },
      update_in_insert = false,
      underline = true,
      severity_sort = false,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'})
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'rounded'})

    local servers = {
      'pyright',
      'texlab',
    }

    require('mason-lspconfig').setup({
      ensure_installed = servers,
      automatic_installation = true,
    })

    local success, lspconfig = pcall(require, 'lspconfig')
    if not success then
      vim.notify('Failed to load plugin: lspconfig')
      return
    end

    local opts = {}
    local handlers = get_handlers()

    for _, server in pairs(servers) do

      opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
      }

      server = vim.split(server, '@')[1]

      lspconfig[server].setup(opts)
    end

  end

}
