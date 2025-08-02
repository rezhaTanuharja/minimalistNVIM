---
-- @file lua/plugins/treesitter.lua
--
-- @brief
-- The configuration file for the plugin treesitter
--
-- @author Tanuharja, R.A.
-- @date 2024-08-31
--

local languages = {
	"cpp",
	"go",
	"html",
	"javascript",
	"json",
	"latex",
	"lua",
	"markdown_inline",
	"markdown",
	"python",
	"ruby",
	"tsx",
}

return {

	"nvim-treesitter/nvim-treesitter",

	event = "UIEnter",

	build = ":TSUpdate",
	main = "nvim-treesitter.configs",

	config = function()
		local parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")

		if parsers_ok then
			local parser_config = parsers.get_parser_configs()

			parser_config.embedded_template = {
				install_info = {
					url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
					files = { "src/parser.c" },
					requires_generate_from_grammar = true,
				},
			}

			if not parsers.filetype_to_parsername then
				parsers.filetype_to_parsername = {}
			end

			parsers.filetype_to_parsername.erb = "embedded_template"
			parsers.filetype_to_parsername.ejs = "embedded_template"

			table.insert(languages, "embedded_template")
		end

		local success, treesitter = pcall(require, "nvim-treesitter.configs")
		if not success then
			vim.notify("Failed to load plugin: treesitter")
			return
		end

		treesitter.setup({

			ensure_installed = languages,

			sync_install = true,
			ignore_install = {},

			highlight = {
				enable = true,
				disable = function(_, bufnr)
					return vim.api.nvim_buf_line_count(bufnr) > 2000
				end,
			},

			indent = {
				enable = true,
				disable = function(_, bufnr)
					return vim.api.nvim_buf_line_count(bufnr) > 2000
				end,
			},

			fold = {
				enable = {
					"html",
					"html",
					"javascript",
					"javascriptreact",
					"json",
					"python",
					"ruby",
					"typescript",
					"typescriptreact",
				},
				disable = function(_, bufnr)
					return vim.api.nvim_buf_line_count(bufnr) > 2000
				end,
			},
		})
	end,
}
