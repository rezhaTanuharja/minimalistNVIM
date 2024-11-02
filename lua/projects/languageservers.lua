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
function M.refresh()
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


-- similar to goto references but search any words in the root directory
function M.deep_search()

  local search_term = vim.fn.expand('<cword>')
  local root_dir = vim.lsp.get_clients()[1].workspace_folders[1].name

  vim.cmd('vimgrep /' .. search_term .. '/ ' .. root_dir .. '/**' )
  vim.cmd('copen')

end


-- -- show a list of all configured servers in a quickfix list
function M.list_servers()

  local autocmd_list = vim.api.nvim_exec('autocmd LSP FileType', true)

  local pattern = "%s*([A-Za-z]+)%s*<([^:]+):%s*(.+):(%d+)>"

  local quickfix_list = {}

  for line in autocmd_list:gmatch("[^\r\n]+") do

    local file_type, event, file_path, line_number = line:match(pattern)

    if file_type and event and file_path and line_number then

      -- expand ~ to home directory
      file_path = file_path:gsub("^~", vim.fn.expand("$HOME"))

      table.insert(
        quickfix_list, {
          filename = file_path,
          lnum = tonumber(line_number),
          text = "Language server for " .. file_type,
        }
      )

    end

  end

  vim.fn.setqflist(quickfix_list, "r")
  vim.cmd("copen")

end


function M.setup(opts)

  vim.api.nvim_create_augroup("LSP", { clear = true })

  -- add functionalities based on language server's capabilities

  vim.api.nvim_create_autocmd(
    'LspAttach', {
      group = 'LSP',
      callback = function(args)

        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- assume that all LSs support definition
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<return>', {buffer = 0})

        if client.supports_method('textDocument/references') then
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<return>', {buffer = 0})
        end

        if client.supports_method('textDocument/rename') then
          vim.keymap.set('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<return>', {buffer = 0})
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
        group = 'LSP',
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
        group = 'LSP',
        callback = function(args)

          -- handle single file mode
          if vim.lsp.buf_is_attached(args.buf) then
            return
          end

          vim.lsp.start({
            name = 'pyright',
            cmd = {'pyright-langserver', '--stdio'},
            root_dir = vim.fs.root(args.buf, {'pyproject.toml', 'pyrightconfig.json'}),
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
