---
-- @file lsp/rust-analyzer.lua
--
-- @brief
-- The configuration file for the rust-analyzer LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-08-10
--

local function reload_workspace(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
	for _, client in ipairs(clients) do
		vim.notify("Reloading Cargo Workspace")
		client.request("rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				error(tostring(err))
			end
			vim.notify("Cargo workspace reloaded")
		end, 0)
	end
end

local function is_library(fname)
	local user_home = vim.fs.normalize(vim.env.HOME)
	local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
	local registry = cargo_home .. "/registry/src"
	local git_registry = cargo_home .. "/git/checkouts"

	local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
	local toolchains = rustup_home .. "/toolchains"

	for _, item in ipairs({ toolchains, registry, git_registry }) do
		if vim.fs.relpath(item, fname) then
			local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
			return #clients > 0 and clients[#clients].config.root_dir or nil
		end
	end
end

return {

	cmd = { "rust-analyzer" },

	filetypes = { "rust" },

	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local reused_dir = is_library(fname)
		if reused_dir then
			on_dir(reused_dir)
			return
		end

		local cargo_crate_dir = vim.fs.root(fname, { "Cargo.toml" })
		local cargo_workspace_root

		if cargo_crate_dir == nil then
			on_dir(
				vim.fs.root(fname, { "rust-project.json" })
					or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
			)
			return
		end

		local cmd = {
			"cargo",
			"metadata",
			"--no-deps",
			"--format-version",
			"1",
			"--manifest-path",
			cargo_crate_dir .. "/Cargo.toml",
		}

		vim.system(cmd, { text = true }, function(output)
			if output.code == 0 then
				if output.stdout then
					local result = vim.json.decode(output.stdout)
					if result["workspace_root"] then
						cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
					end
				end
				on_dir(cargo_workspace_root or cargo_crate_dir)
			else
				vim.schedule(function()
					vim.notify(
						("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr)
					)
				end)
			end
		end)
	end,

	capabilities = {
		experimental = {
			serverStatusNotification = true,
		},
	},

	before_init = function(init_params, config)
		if config.settings and config.settings["rust-analyzer"] then
			init_params.initializationOptions = config.settings["rust-analyzer"]
		end
	end,

	on_attach = function(_, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspCargoReload", function()
			reload_workspace(bufnr)
		end, { desc = "Reload current cargo workspace" })

		vim.api.nvim_create_autocmd("CompleteDone", {
			buffer = bufnr,
			callback = function()
				local completed_item = vim.v.completed_item
				if
					not completed_item
					or not completed_item.user_data
					or not completed_item.user_data.nvim
					or not completed_item.user_data.nvim.lsp
					or not completed_item.user_data.nvim.lsp.completion_item
				then
					return
				end

				local ci = completed_item.user_data.nvim.lsp.completion_item
				local snippet = ci.textEdit and ci.textEdit.newText or nil

				if snippet and snippet:find("%$") then
					local line, col = unpack(vim.api.nvim_win_get_cursor(0))
					col = col - #completed_item.word

					local current_line = vim.api.nvim_get_current_line()
					local before = current_line:sub(1, col)
					local after = current_line:sub(col + #completed_item.word + 1)
					vim.api.nvim_set_current_line(before .. after)
					vim.api.nvim_win_set_cursor(0, { line, col })

					vim.snippet.expand(snippet)
				end
			end,
		})
	end,

	settings = {},
}
