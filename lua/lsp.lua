vim.lsp.enable({
  "clangd",
  "pyright",
  "ruff",
  "texlab",
})

vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd(
  "LspAttach", {
    group = "LSP",
    callback = function(args)

      vim.bo[args.buf].formatexpr = "v:lua.vim.lsp.formatexpr"

      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client.supports_method("textDocument/codeAction") then
        vim.keymap.set("n",
          "ga",
          vim.lsp.buf.code_action,
          {
            buffer = args.buf
          }
        )
      end

    end,
  }
)
