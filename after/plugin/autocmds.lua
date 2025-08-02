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
				vim.api.nvim_buf_set_extmark(bufnr, vim.api.nvim_create_namespace("conceal"), start_row, start_col, {
					end_col = start_col + 1,
					conceal = "",
				})
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

vim.api.nvim_set_hl(0, "@string.escape.markdown_inline", { link = "@spell" })
