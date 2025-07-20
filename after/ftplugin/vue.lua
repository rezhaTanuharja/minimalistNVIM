if vim.fn.executable("vtsls") == 1 then
  vim.lsp.enable("vtsls")
end

if vim.fn.executable("vue-language-server") == 1 then
  vim.lsp.enable("vue-language-server")
end
