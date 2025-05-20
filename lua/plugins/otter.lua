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
      end
    )

    vim.treesitter.language.register("markdown", "quarto")

  end

}
