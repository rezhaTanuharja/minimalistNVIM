---
-- @file projects/notebook/lua/notebook.lua
--
-- @brief
-- The plugin file for notebook
--
-- @author Tanuharja, R.A.
-- @date 2025-06-05
--


local M = {}


M.convert_to_normal_script = function()

  local filename = "temp.py"

  local query = vim.treesitter.query.parse('markdown', [[
    ((code_fence_content) @code)
  ]])

  local parser = vim.treesitter.get_parser(0, "markdown")
  local tree = parser:parse()[1]
  local root = tree:root()

  local lines = {}

  for _, node in query:iter_captures(root, 0) do

    local text = vim.treesitter.get_node_text(node, 0)

    for _, line in ipairs(vim.fn.split(text, '\n')) do
      table.insert(lines, line)
    end

  end

  local file = io.open(filename, "w")

  for _, line in ipairs(lines) do
    file:write(line .. "\n")
  end

  file:close()

  vim.cmd("edit " .. filename)

end


M.move_imports_to_top = function()

  local bufnr = 0
  local root = vim.treesitter.get_parser(bufnr, "python"):parse()[1]:root()

  local query = vim.treesitter.query.parse("python", [[
    (import_statement) @imp
    (import_from_statement) @imp
  ]])

  local import_nodes = {}
  for _, node in query:iter_captures(root, bufnr) do
    table.insert(import_nodes, node)
  end

  table.sort(import_nodes, function(a,b) return a:start() < b:start() end)

  local lines_to_remove = {}
  local import_texts = {}

  for _, node in ipairs(import_nodes) do
    local s, _, e, _ = node:range()
    for i = s, e do lines_to_remove[i] = true end
    table.insert(import_texts, vim.treesitter.get_node_text(node, bufnr))
  end

  local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i = #buf_lines - 1, 0, -1 do
    if lines_to_remove[i] then table.remove(buf_lines, i + 1) end
  end

  local imports_lines = {}
  for _, text in ipairs(import_texts) do
    for line in text:gmatch("[^\r\n]+") do
      table.insert(imports_lines, line)
    end
  end
  table.insert(imports_lines, "")

  for i = #imports_lines, 1, -1 do
    table.insert(buf_lines, 1, imports_lines[i])
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, buf_lines)

end


M.execute_block = function()
  local node = vim.treesitter.get_node()
  local start_row, _, end_row, _ = vim.treesitter.get_node_range(node)
  vim.fn.MoltenEvaluateRange(start_row + 1, end_row)
end

M.render_block = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local ns_id = vim.api.nvim_create_namespace("codeblock_hr")
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  for i = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
    local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
    if line:match("^```.*$") then
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, i, 0, {
        virt_text = { { string.rep("─", 79), "Comment" } },
        virt_text_pos = "overlay",
      })
    end
  end
end


M.setup = function(opts)

  vim.treesitter.language.register("markdown", "quarto")

  vim.keymap.set(
    "n",
    opts.keymaps.convert_to_normal_script,
    M.convert_to_normal_script
  )
  vim.keymap.set(
    "n",
    opts.keymaps.move_import_to_top,
    M.move_imports_to_top
  )

  for group, style in pairs(opts.custom_highlights) do
    vim.api.nvim_set_hl(0, group, style)
  end

  vim.keymap.set(
    "n",
    opts.keymaps.activate_otter,
    function()
      require("otter").activate(
        {"python"},
        true,
        true,
        nil
      )
    end
  )

  vim.keymap.set("n", opts.keymaps.initialize_molten, "<cmd>MoltenInit<return>")

  vim.api.nvim_create_autocmd("User", {
    pattern = "MoltenInitPost",
    callback = function(arg)

      vim.opt_local.colorcolumn="80"

      vim.keymap.set("n", opts.keymaps.stop_molten, "<cmd>MoltenDeinit<return>", { buffer = arg.buf })

      vim.keymap.set("n", opts.keymaps.execute_block, M.execute_block, { buffer = arg.buf })

      vim.keymap.set("n", opts.keymaps.enter_output, ":noautocmd MoltenEnterOutput<return>", { buffer = arg.buf })
      vim.keymap.set("n", opts.keymaps.hide_output, "<cmd>MoltenHideOutput<return>", { buffer = arg.buf })
      vim.keymap.set("n", opts.keymaps.image_popup, "<cmd>MoltenImagePopup<return>", { buffer = arg.buf })

      vim.keymap.set("n", opts.keymaps.reevaluate_all, "<cmd>MoltenReevaluateAll<return>", { buffer = arg.buf })
      vim.keymap.set("v", opts.keymaps.evaluate_visual, ":<C-u>MoltenEvaluateVisual<return>", { buffer = arg.buf })
      vim.keymap.set("n", opts.keymaps.evaluate_line, "<cmd>MoltenEvaluateLine<return>", { buffer = arg.buf })

      vim.keymap.set("n", opts.keymaps.next_block, "<cmd>MoltenNext<return>", { buffer = arg.buf })
      vim.keymap.set("n", opts.keymaps.prev_block, "<cmd>MoltenPrev<return>", { buffer = arg.buf })

      vim.keymap.set(
        "n",
        "<leader>ad",
        function()
          vim.cmd("MoltenEvaluateArgument import debugpy")
          vim.cmd("MoltenEvaluateArgument _ = debugpy.listen(('localhost', 5678))")
          vim.notify("debugpy has been initialized")
        end,
        { buffer = arg.buf, desc = "initialize debugger"}
      )

      vim.keymap.set("n", "<leader>dd", "<cmd>MoltenEvaluateArgument debugpy.breakpoint()<return>", { buffer = arg.buf, desc = "enter virtual breakpoint"})

    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "MoltenDeinitPost",
    callback = function(arg)

      kernels = require("molten.status").kernels()

      if #kernels > 0 then
        return
      end

      vim.opt_local.colorcolumn=""

      vim.keymap.del("n", opts.keymaps.stop_molten, { buffer = arg.buf })

      vim.keymap.del("n", opts.keymaps.execute_block, { buffer = arg.buf })

      vim.keymap.del("n", opts.keymaps.enter_output, { buffer = arg.buf })
      vim.keymap.del("n", opts.keymaps.hide_output, { buffer = arg.buf })
      vim.keymap.del("n", opts.keymaps.image_popup, { buffer = arg.buf })

      vim.keymap.del("n", opts.keymaps.reevaluate_all, { buffer = arg.buf })
      vim.keymap.del("v", opts.keymaps.evaluate_visual, { buffer = arg.buf })
      vim.keymap.del("n", opts.keymaps.evaluate_line, { buffer = arg.buf })

      vim.keymap.del("n", opts.keymaps.next_block, { buffer = arg.buf })
      vim.keymap.del("n", opts.keymaps.prev_block, { buffer = arg.buf })

      vim.keymap.del("n", "<leader>ad", { buffer = arg.buf })
      vim.keymap.del("n", "<leader>dd", { buffer = arg.buf })

    end,
  })

  vim.api.nvim_create_autocmd(
    { "BufEnter", "BufWinEnter", "TextChanged", "InsertLeave" },
    {
      pattern = { "*.md", "*.qmd" },
      callback = M.render_block,
    }
  )

end


return M
