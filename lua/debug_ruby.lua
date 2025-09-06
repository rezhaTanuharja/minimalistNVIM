local M = {}

local function strip_ansi(chunk)
  chunk = chunk:gsub("\27%[[0-9;]*m", "")
  chunk = chunk:gsub("\r", "")
  return chunk
end

M.run = function(cmd, args)
	local handle
	local pid_or_err
	local stdout = vim.uv.new_pipe(false)
	args = args or {}

	local opts = { args = args, stdio = { nil, stdout } }

	handle, pid_or_err = vim.uv.spawn(cmd, opts, function(code)
		if handle then
			handle:close()
		end
	end)

	assert(handle, "Error running command: " .. cmd .. tostring(pid_or_err))

	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
      chunk = strip_ansi(chunk)
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
end

M.setup = function()
	local success, dap = pcall(require, "dap")
	if not success then
		vim.notify("failed to load a plugin: dap")
		return true
	end

	dap.adapters.ruby = function(callback, config)
		local server = "127.0.0.1"
		local port = math.random(49152, 65535)

		if config.command then
			vim.env.RUBY_DEBUG_OPEN = true
			vim.env.RUBY_DEBUG_HOST = server
			vim.env.RUBY_DEBUG_PORT = port
			M.run(config.command, config.args)
		end

		vim.defer_fn(function()
			callback({ type = "server", host = server, port = port })
		end, 500)
	end

	dap.configurations.ruby = {
		{
			name = "[Ruby] Run the current file",
			type = "ruby",
			request = "attach",
			command = "rdbg",
			args = { "${file}" },
			options = { source_filetype = "ruby" },
			localfs = true,
		},
		{
			name = "[Ruby] Run the current spec file",
			type = "ruby",
			request = "attach",
			command = "bundle",
			args = { "exec", "rspec", "${file}" },
			options = { source_filetype = "ruby" },
			localfs = true,
		},
		{
			name = "[Ruby] Run the Rails server",
			type = "ruby",
			request = "attach",
			command = "bundle",
			args = { "exec", "rails", "s" },
			options = { source_filetype = "ruby" },
			localfs = true,
		},
		{
			name = "[Ruby] Run a custom command",
			type = "ruby",
			request = "attach",
			command = "bundle",
			args = function()
				local input = vim.fn.input("Args (space separated): ", "exec rails runner")
				return vim.split(input, "%s+")
			end,
			options = { source_filetype = "ruby" },
			localfs = true,
		},
	}
end

return M
