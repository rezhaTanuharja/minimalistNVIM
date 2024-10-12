
-- set keymaps for LSP actions if they are available

vim.api.nvim_create_autocmd(
  'LspAttach', {
    callback = function(args)

      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client.supports_method('textDocument/definition') then
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<return>')
      end

      if client.supports_method('textDocument/references') then
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<return>')
      end

      if client.supports_method('textDocument/rename') then
        vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<return>')
      end

    end,
  }
)


-- format floating window for documentation preview

vim.opt['linebreak'] = true
vim.opt['whichwrap'] = 'bs<>[]hl'

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    title = 'Language Server',
    border = 'single',
    wrap = true,
    width = 80,
  }
)

-- attach language servers to the right buffer

vim.api.nvim_create_autocmd(
  'FileType', {
    pattern = 'lua',
    callback = function(args)
      vim.lsp.start({
        name = 'lua-language-server',
        cmd = {'lua-language-server'},
        root_dir = vim.fs.root(args.buf, {'init.lua'}),
        settings = {
          Lua = {
            diagnostics = { globals = {'vim'} }
          },
        },
      })
    end,
  }
)

vim.api.nvim_create_autocmd(
  'FileType', {
    pattern = 'python',
    callback = function(args)
      vim.lsp.start({
        name = 'pyright',
        cmd = {'pyright-langserver', '--stdio'},
        root_dir = vim.fs.root(args.buf, {'pyproject.toml'}),
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic',
              autoSeachPaths = true,
           }
          },
        },
      })
    end,
  }
)
