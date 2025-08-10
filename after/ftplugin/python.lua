---
-- @file after/ftplugin/python.lua
--
-- @brief
-- Python - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-06-08
--

--
-- Sets up development environment for Python.
--
-- + uses a global flag _G.python_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
-- + set adapters and configurations for DAP.
--
_G.python_env_set = _G.python_env_set
	or (function()
		if vim.fn.executable("pyright-langserver") == 1 then
			vim.lsp.enable("pyright")
		end

		if vim.fn.executable("ruff") == 1 then
			vim.lsp.enable("ruff")
		end

		local success, dap = pcall(require, "dap")
		if not success then
			vim.notify("failed to load a plugin: dap")
			return true
		end

		dap.adapters.python = function(callback, config)
			if config.request == "launch" then
				callback({
					type = "executable",
					command = "python",
					args = { "-m", "debugpy.adapter" },
				})
			elseif config.request == "attach" then
				local port = config.connect.port
				local host = config.connect.host

				callback({
					type = "server",
					port = port,
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		dap.configurations.python = {

			{
				type = "python",
				request = "launch",
				name = "[Python] Launch a debugging session",
				program = "${file}",
				pythonPath = function()
					return "python3"
				end,
				console = "integratedTerminal",
			},

			{
				type = "python",
				request = "attach",
				name = "[Python] Attach a debugging session",
				connect = function()
					local host = vim.fn.input("Host: ")
					local port = tonumber(vim.fn.input("Port: "))
					return { host = host, port = port }
				end,
				console = "integratedTerminal",
			},

			{
				type = "python",
				request = "launch",
				name = "[Python] Launch a debugging session with arguments",
				program = "${file}",
				args = function()
					local args_string = vim.fn.input("Arguments: ")
					local utils = require("dap.utils")
					if utils.splitstr and vim.fn.has("nvim-0.10") == 1 then
						return utils.splitstr(args_string)
					end
					return vim.split(args_string, " +")
				end,
				pythonPath = function()
					return "python3"
				end,
				console = "integratedTerminal",
			},
		}

		return true
	end)()

require("snippets").enable_snippets()

local success, textobj = pcall(require, "text_objects")
if not success then
	vim.notify("failed to load a plugin: text_objects")
	return
end

local generate_function_docstring = function()
	local function_definition = textobj.get_node("function_definition")
	if not function_definition then
		return
	end

	local parameters = textobj.get_field(function_definition, "parameters")
	if not parameters or #parameters < 1 then
		return
	end

	local body = textobj.get_field(function_definition, "body")[1]
	if not body or #body < 1 then
		return
	end

	local row, col, _, _ = body:range()
	local indent = string.rep(" ", col)

	local first_content = body:named_child(0)

	if first_content and first_content:type() == "expression_statement" then
		local expression = first_content:named_child(0)
		if expression and expression:type() == "string" then
			local start_row, _, end_row, _ = expression:range()
			vim.api.nvim_buf_set_lines(0, start_row, end_row + 1, false, {})
		end
	end

	local docstring = {}
	table.insert(docstring, indent .. '"""${1:Description}')
	table.insert(docstring, "")

	local param_nodes = parameters[1]
	local num_parameters = param_nodes:named_child_count()

	if num_parameters > 1 then
		table.insert(docstring, indent .. "Parameters")
		table.insert(docstring, indent .. "----------")
		for i = 0, num_parameters - 1 do
			local param_node = param_nodes:named_child(i)
			local param_name = vim.treesitter.get_node_text(param_node, 0)
			if param_name ~= "self" then
				table.insert(docstring, indent .. "`" .. param_name .. "`")
				table.insert(docstring, indent .. "${" .. i + 2 .. ":description}")
				table.insert(docstring, "")
			end
		end
	elseif num_parameters == 1 then
		local param_node = param_nodes:named_child(0)
		local param_name = vim.treesitter.get_node_text(param_node, 0)
		if param_name ~= "self" then
			table.insert(docstring, indent .. "Parameters")
			table.insert(docstring, indent .. "----------")
			table.insert(docstring, indent .. "`" .. param_name .. "`")
			table.insert(docstring, indent .. "${2:description}")
			table.insert(docstring, "")
		end
	end

	local return_type = textobj.get_field(function_definition, "return_type")[1]
	if return_type then
		local type = vim.treesitter.get_node_text(return_type, 0)
		if type ~= "None" then
			table.insert(docstring, indent .. "Returns")
			table.insert(docstring, indent .. "-------")
			table.insert(docstring, indent .. "`" .. type .. "`")
			table.insert(docstring, indent .. "${" .. num_parameters + 2 .. ":description}")
		else
			table.remove(docstring)
		end
	end

	table.insert(docstring, indent .. '"""')

	vim.api.nvim_buf_set_lines(0, row, row, false, { "" })
	vim.api.nvim_win_set_cursor(0, { row + 1, 0 })

	vim.snippet.expand(table.concat(docstring, "\n"))
end

vim.keymap.set("n", "dif", function()
	local function_definition = textobj.get_node("function_definition")
	local body = textobj.get_field(function_definition, "body")[1]

	textobj.yank_node(body)
	textobj.delete_node(body)

	textobj.goto_node(function_definition)
end, {
	desc = "delete the body of a function definition",
	buffer = true,
})

vim.keymap.set("n", "daf", function()
	local function_definition = textobj.get_node("function_definition")
	textobj.yank_node(function_definition)
	textobj.delete_node(function_definition)
end, {
	desc = "delete a function definition",
	buffer = true,
})

vim.keymap.set("n", "dic", function()
	local class_definition = textobj.get_node("class_definition")
	local body = textobj.get_field(class_definition, "body")[1]

	textobj.yank_node(body)
	textobj.delete_node(body)

	textobj.goto_node(class_definition)
end, {
	desc = "delete the body of a class definition",
	buffer = true,
})

vim.keymap.set("n", "dac", function()
	local class_definition = textobj.get_node("class_definition")
	textobj.yank_node(class_definition)
	textobj.delete_node(class_definition)
end, {
	desc = "delete a class definition",
	buffer = true,
})

vim.keymap.set("n", "yif", function()
	local function_definition = textobj.get_node("function_definition")
	local body = textobj.get_field(function_definition, "body")[1]

	textobj.yank_node(body)
end, {
	desc = "yank the body of function definition",
	buffer = true,
})

vim.keymap.set("n", "yaf", function()
	local function_definition = textobj.get_node("function_definition")
	textobj.yank_node(function_definition)
end, {
	desc = "yank a function definition",
	buffer = true,
})

vim.keymap.set("n", "yic", function()
	local class_definition = textobj.get_node("class_definition")
	local body = textobj.get_field(class_definition, "body")[1]

	textobj.yank_node(body)
end, {
	desc = "yank the body of a class definition",
	buffer = true,
})

vim.keymap.set("n", "yac", function()
	local class_definition = textobj.get_node("class_definition")
	textobj.yank_node(class_definition)
end, {
	desc = "yank a class definition",
	buffer = true,
})

vim.keymap.set("n", "gfn", function()
	local function_definition = textobj.get_node("function_definition")
	local name_fields = textobj.get_field(function_definition, "name")

	if not name_fields or #name_fields < 1 then
		return
	end

	textobj.goto_node(name_fields[1])
end, {
	desc = "jump to function name",
	buffer = true,
})

vim.keymap.set("n", "gcn", function()
	local class_definition = textobj.get_node("class_definition")
	local name_fields = textobj.get_field(class_definition, "name")

	if not name_fields or #name_fields < 1 then
		return
	end

	textobj.goto_node(name_fields[1])
end, {
	desc = "jump to class name",
	buffer = true,
})

vim.keymap.set("n", "gfp", function()
	local function_definition = textobj.get_node("function_definition")
	local parameters = textobj.get_field(function_definition, "parameters")

	if not parameters or #parameters < 1 then
		return
	end

	local parameter = textobj.get_next_child(parameters[1])

	textobj.goto_node(parameter)
end, {
	desc = "jump to function parameters (cyclic)",
	buffer = true,
})

vim.keymap.set("n", "mfd", generate_function_docstring, {
	desc = "Insert function parameter docstring",
	buffer = true,
})
