---
-- @file after/ftplugin/go.lua
--
-- @brief
-- Go - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-07-25
--

--
-- Sets up development environment for Go.
--
-- + uses a global flag _G.go_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
--
_G.go_env_set = _G.go_env_set
	or (function()
		if vim.fn.executable("gopls") == 1 then
			vim.lsp.enable("gopls")
		end

		local success, dap = pcall(require, "dap")
		if not success then
			vim.notify("failed to load a plugin: dap")
			return true
		end

		dap.adapters.delve = function(callback, config)
			if config.mode == "remote" and config.request == "attach" then
				callback({
					type = "server",
					host = config.host or "127.0.0.1",
					port = config.port or "38697",
				})
			else
				callback({
					type = "server",
					port = "${port}",
					executable = {
						command = "dlv",
						args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
						detached = vim.fn.has("win32") == 0,
					},
				})
			end
		end

		dap.configurations.go = {
			{
				name = "[Go] Attach Delve to A Web Server",
				type = "delve",
				request = "attach",
				mode = "local",

				processId = function()
					return require("dap.utils").pick_process({ filter = "webserver" })
				end,
			},
			{
				name = "[Go] Attach to Delve",
				type = "delve",
				request = "attach",
				mode = "remote",
			},
		}

		return true
	end)()
