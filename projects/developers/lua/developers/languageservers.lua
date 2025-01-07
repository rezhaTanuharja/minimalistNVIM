---
-- @file projects/developers/lua/developers/languageservers.lua
--
-- @brief
-- The plugin file for developers - languageservers
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-23
--


local M = {}

-- used if buffer root directory cannot be found
function M.dir_fallback(buffer)
  return vim.fn.fnamemodify(buffer, ':p:h')
end

-- refresh all buffer while preserving the current layout
function M.refresh()

  local window_buffer_map = {}
  for _, window_id in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buffer_id = vim.api.nvim_win_get_buf(window_id)
    table.insert(window_buffer_map, { window_id = window_id, buffer_id = buffer_id})
  end

  if #window_buffer_map > 0 then
    vim.cmd('bufdo if &modifiable | write | edit | endif')
  end

  for _, entry in pairs(window_buffer_map) do
    vim.api.nvim_win_set_buf(entry.window_id, entry.buffer_id)
  end

end

-- similar to goto definitions but search any words in the root directory
function M.deep_search(formatter, extension)

  local buf_number = vim.api.nvim_get_current_buf()

  local success, active_clients = pcall(vim.lsp.get_clients, { bufnr = buf_number })
  if not success then
    print('There is no active client')
    return
  end

  local root_dir = active_clients[1].workspace_folders[1].name
  local search_term = formatter(vim.fn.expand('<cword>'))

  vim.cmd('vimgrep /' .. search_term .. '/ ' .. root_dir .. '/**/*.' .. extension )
  vim.cmd('copen')

end

function M.setup(opts)

  vim.api.nvim_create_autocmd(
    'LspAttach', {
      group = 'LSP',
      callback = function(args)

        vim.bo[args.buf].formatexpr = 'v:lua.vim.lsp.formatexpr'

        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- assume that all LSs support definition
        vim.keymap.set('n',
          opts.keymaps.definition,
          vim.lsp.buf.definition,
          {
            buffer = args.buf
          }
        )

        if client.supports_method('textDocument/references') then
          vim.keymap.set('n',
            opts.keymaps.references,
            vim.lsp.buf.references,
            {
              buffer = args.buf
            }
          )
        end

        if client.supports_method('textDocument/rename') then
          vim.keymap.set('n',
            opts.keymaps.rename,
            vim.lsp.buf.rename,
            {
              buffer = args.buf
            }
          )
        end

        if client.supports_method('textDocument/codeAction') then
          vim.keymap.set('n',
            opts.keymaps.code_action,
            vim.lsp.buf.code_action,
            {
              buffer = args.buf
            }
          )
        end

      end,
    }
  )


  -- format floating window

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, opts.hover
  )

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, opts.signatureHelp
  )

end

function M.set_client(opts)

  if vim.fn.executable(opts.executable) == 1 then

    vim.api.nvim_create_autocmd('FileType', {

      pattern = opts.pattern,
      group = 'LSP',

      callback = function(args)

        vim.lsp.start({
          name = opts.name,
          cmd = opts.cmd,
          root_dir = opts.root_dir(args.buf) or M.dir_fallback(args.buf),
          settings = opts.settings,
        })

        if not opts.deep_search then
          return
        end

        vim.keymap.set('n',
          opts.deep_search.keymap,
          function()
            M.deep_search(
              opts.deep_search.formatter,
              opts.deep_search.extension
            )
          end,
          {
            buffer = args.buf
          }
        )

      end,

    })

  end

end

return M
