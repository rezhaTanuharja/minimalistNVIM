---
-- @file lua/languageservers.lua
--
-- @brief
-- The file to set Neovim's builtin LSP capabilities
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-12
--


local M = {}

-- refresh all buffer while preserving the current layout
M.refresh = function()
  local window_buffer_map = {}
  for _, window_id in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buffer_id = vim.api.nvim_win_get_buf(window_id)
    table.insert(window_buffer_map, { window_id = window_id, buffer_id = buffer_id})
  end

  vim.cmd('bufdo write | edit')

  for _, entry in pairs(window_buffer_map) do
    vim.api.nvim_win_set_buf(entry.window_id, entry.buffer_id)
  end
end

-- show function signature after opening parentheses or comma
M.show_signature = function()
  local char = vim.v.char
  if char == '(' or char == ',' then
    vim.defer_fn(
      function()
        vim.lsp.buf.signature_help()
      end,
      3
    )
  end
end


M.setup = function(opts)


  -- add functionalities based on language server's capabilities

  vim.api.nvim_create_autocmd(
    'LspAttach', {
      callback = function(args)

        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- assume that all LSs support definition
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<return>', {buffer = 0})

        if client.supports_method('textDocument/references') then
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<return>', {buffer = 0})
        end

        if client.supports_method('textDocument/rename') then
          vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<return>', {buffer = 0})
        end

        if client.supports_method('textDocument/signatureHelp') then
          vim.api.nvim_create_autocmd(
            'InsertCharPre', {
              buffer = 0,
              callback = M.show_signature,
            }
          )
        end

      end,
    }
  )


  -- format floating window

  vim.opt['linebreak'] = true
  vim.opt['whichwrap'] = 'bs<>[]hl'

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      title = 'Language Server',
      border = 'single',
      wrap = true,
      wrap_at = 80,
      focus = false,
    }
  )

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      title = 'Language Server',
      border = 'single',
      focusable = false,
      wrap = true,
      wrap_at = 80,
    }
  )


  -- attach language servers to the right buffer

  if opts.lua then

    vim.api.nvim_create_autocmd(
      'FileType', {
        pattern = 'lua',
        callback = function(args)
          vim.lsp.start({
            name = 'lua-language-server',
            cmd = {'lua-language-server'},
            root_dir = vim.fs.root(args.buf, {'.git'}),
            settings = {
              Lua = {
                diagnostics = { globals = {'vim'} }
              },
            },
          })
        end,
      }
    )

  end

  if opts.Python then

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

  end

end

return M
