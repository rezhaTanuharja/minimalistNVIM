vim.lsp.enable({
  "clangd",
  "pyright",
  "ruff",
  "texlab",
})

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

vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd(
  "LspAttach", {
    group = "LSP",
    callback = function(args)

      vim.bo[args.buf].formatexpr = "v:lua.vim.lsp.formatexpr"

      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client:supports_method("textDocument/formatting") then
        vim.keymap.set("n",
          "grf",
          vim.lsp.buf.format,
          {
            buffer = args.buf
          }
        )
      end

    end,
  }
)

vim.lsp.set_log_level(vim.log.levels.OFF)
