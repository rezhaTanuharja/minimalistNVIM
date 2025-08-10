---
-- @file lua/plugin_manager.lua
--
-- @brief
-- The simple plugin manager.
--
-- @author Tanuharja, R.A.
-- @date 2024-08-03
--

local on_stdout = function(_, data)
	if not data then
		return
	end

	for _, line in ipairs(data) do
		if line ~= "" then
			vim.schedule(function()
				vim.api.nvim_echo({ { line, "None" } }, false, {})
			end)
		end
	end
end

local data_site = vim.fn.stdpath("data") .. "/site"
local plugins_directory = data_site .. "/pack/plugins/opt/"

local M = {}

local load = function(name)
	local spec = dofile(vim.fn.stdpath("config") .. "/lua/plugins/" .. name .. ".lua")

	if spec.init and type(spec.init) == "function" then
		spec.init()
	end

	vim.cmd("packadd " .. name)

	if spec.config and type(spec.config) == "function" then
		vim.defer_fn(function()
			spec.config()
		end, 50)
	end
end

local build = function(cmd, cwd, name)
	vim.fn.jobstart(cmd, {
		cwd = cwd,
		on_exit = function(_, code)
			if code ~= 0 then
				vim.api.nvim_err_writeln("Failed to build " .. name .. ".\n")
				return
			end

			vim.api.nvim_out_write("Built " .. name .. " successfully.\n")

			load(name)
		end,
	})
end

local install = function(name)
	local install_dir = plugins_directory .. name

	if vim.uv.fs_stat(install_dir) then
		load(name)
		return
	end

	local spec = dofile(vim.fn.stdpath("config") .. "/lua/plugins/" .. name .. ".lua")

	vim.fn.jobstart({ "git", "clone", "--depth=1", "https://github.com/" .. spec[1], install_dir }, {
		on_stdout = on_stdout,
		on_stderr = on_stdout,
		on_exit = function(_, code)
			if code ~= 0 then
				vim.api.nvim_err_writeln("Failed to install " .. name .. ".\n")
				return
			end

			vim.api.nvim_out_write("Installed " .. name .. " successfully.\n")

			if not spec.build then
				load(name)
				return
			end

			build(spec.build, install_dir, name)
		end,
	})
end

local update = function(name)
	local install_dir = plugins_directory .. name

	local spec = dofile(vim.fn.stdpath("config") .. "/lua/plugins/" .. name .. ".lua")

	vim.fn.jobstart({ "git", "pull" }, {
		cwd = install_dir,
		on_stdout = on_stdout,
		on_stderr = on_stdout,
		on_exit = function(_, code)
			if code ~= 0 then
				vim.api.nvim_err_writeln("Failed to update " .. name .. ".\n")
				return
			end

			vim.api.nvim_out_write("Updated " .. name .. " successfully.\n")

			if not spec.build then
				load(name)
				return
			end

			build(spec.build, install_dir, name)
		end,
	})
end

M.setup = function(opts)
	if not string.find(vim.o.packpath, data_site, 1, true) then
		vim.o.packpath = vim.o.packpath .. "," .. data_site
	end

	if opts and opts.plugins and type(opts.plugins) == "table" then
		for _, plugin in ipairs(opts.plugins) do
			install(plugin)
		end

		M.update = function()
			for _, plugin in ipairs(opts.plugins) do
				update(plugin)
			end
		end
	end
end

return M
