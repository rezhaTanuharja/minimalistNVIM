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
