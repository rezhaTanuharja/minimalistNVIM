servers = {
  "clangd",
  "pyright",
  "ruff",
  "texlab",
  "typescript-language-server",
  "vscode-eslint-language-server",
}

for _, server in pairs(servers) do
  if vim.fn.executable(server) == 1 then
    vim.lsp.enable(server)
  end
end

local function refresh()

  vim.lsp.stop_client(vim.lsp.get_clients(), true)

  vim.defer_fn(
    function()
      local window_buffer_map = {}
      for _, window_id in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buffer_id = vim.api.nvim_win_get_buf(window_id)
        table.insert(window_buffer_map, { window_id = window_id, buffer_id = buffer_id})
      end

      if #window_buffer_map > 0 then
        vim.cmd("bufdo if &modifiable | write | edit | endif")
      end

      for _, entry in pairs(window_buffer_map) do
        vim.api.nvim_win_set_buf(entry.window_id, entry.buffer_id)
      end
    end,
    100
  )

end

vim.keymap.set("n", "gn", refresh)

vim.lsp.config( "*", {

  on_init = function(client)
    client.offset_encoding = "utf-8"
  end,

  on_attach = function(client, buffer)

    vim.bo[buffer].formatexpr = "v:lua.vim.lsp.formatexpr"

    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end

    if client:supports_method("textDocument/formatting") then

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buffer,
        callback = function()
          vim.lsp.buf.format({ buffer = buffer, id = client.id })
        end,
      })

    end

  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()

    local query = [[
      (backslash_escape) @escape
    ]]

    vim.treesitter.query.set("markdown_inline", "conceal_backslash", query)

    local function conceal_backslash()
      local bufnr = vim.api.nvim_get_current_buf()
      local parser = vim.treesitter.get_parser(bufnr, "markdown_inline")
      local tree = parser:parse()[1]
      local query_obj = vim.treesitter.query.get("markdown_inline", "conceal_backslash")

      for _, node in query_obj:iter_captures(tree:root(), bufnr, 0, -1) do
        local start_row, start_col, end_row, end_col = node:range()
        vim.api.nvim_buf_set_extmark(
          bufnr, vim.api.nvim_create_namespace("conceal"), start_row, start_col, {
            end_col = start_col + 1,
            conceal = '',
          }
        )
      end
    end

    vim.api.nvim_buf_attach(0, false, {
      on_lines = function()
        vim.schedule(conceal_backslash)
      end,
    })
    conceal_backslash()
  end,
})

vim.api.nvim_set_hl(0, "@string.escape.markdown_inline", { link = "@spell"})
