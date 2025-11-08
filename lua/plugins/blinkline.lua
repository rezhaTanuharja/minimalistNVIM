---
-- @file lua/plugins/blankline.lua
--
-- @brief
-- The configuration file for the plugin blankline
--
-- @author Tanuharja, R.A.
-- @date 2024-08-31
--

local opts = {
  static = {
    enabled = true,
    char = "│",
    priority = 1,
    highlights = { "BlinkIndent" },
  },
  scope = {
    enabled = true,
    highlights = { "BlinkIndentScope" },
  },
}

return {

	"saghen/blink.indent",

	config = function()
		local success, blinkline = pcall(require, "blink.indent")
		if not success then
			vim.notify("Failed to load a plugin: blinkline")
			return
		end

		blinkline.setup(opts)
	end,
}
