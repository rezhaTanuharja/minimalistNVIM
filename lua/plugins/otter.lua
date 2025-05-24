local convert_to_normal_script = function()

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

local move_imports_to_top = function()
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


return {

  'jmbuhr/otter.nvim',

  ft = { "markdown", "quarto" },

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },

  config = function()

    local success, otter = pcall(require, "otter")
    if not success then
      vim.notify("Error loading plugin: otter")
      return
    end


    otter.setup{

      lsp = {
        diagnostic_update_events = { "InsertLeave", "TextChanged" },
        root_dir = function(_, bufnr)
          return vim.fs.root(bufnr or 0, {
            ".git",
            "_quarto.yml",
            "package.json",
          }) or vim.fn.getcwd(0)
        end,
      },

      buffers = {
        set_filetype = true,
        write_to_disk = false,
        preambles = {},
        postambles = {},
        ignore_pattern = {
          python = "^(%s*[%%!].*)",
        },
      },

      strip_wrapping_quote_characters = { "'", '"', "`" },
      handle_leading_whitespace = true,
      extensions = {},
      debug = false,

      verbose = {
        no_code_found = false
      },
    }

    vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", {})
    vim.api.nvim_set_hl(0, "@label.markdown", { fg = "#555555" })

    vim.keymap.set("n", "<leader>op", 
      function()
        otter.activate(
          { "python" },
          true,
          true,
          nil
        )
      end,
      { desc = "start otter for Python with language server and completion" }
    )

    vim.treesitter.language.register("markdown", "quarto")


    vim.keymap.set("n", "<leader>aj", convert_to_normal_script)
    vim.keymap.set("n", "<leader>ak", move_imports_to_top)

    vim.api.nvim_create_autocmd(
      { "BufEnter", "BufWinEnter", "TextChanged", "InsertLeave" },
      {
        pattern = { "*.md", "*.qmd" },
        callback = function()
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
        end,
      }
    )

    vim.api.nvim_set_hl(0, "@spell", { fg = "#999999" })

  end

}
