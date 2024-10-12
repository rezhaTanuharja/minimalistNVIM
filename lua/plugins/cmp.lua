---
-- @file lua/external_plugins/cmp.lua
--
-- @brief
-- The configuration file for the plugin cmp
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'hrsh7th/nvim-cmp',

  ft = { 'lua', 'python' },

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },

  config = function()

    local success, cmp = pcall(require, 'cmp')
    if not success then
      vim.notify('Failed to load plugin: cmp')
      return
    end

    local kind_icons = {
      Text = '',
      Method = '<method>',
      Function = '<function>',
      Constructor = '',
      Field = '',
      Variable = '<variable>',
      Class = '<class>',
      Interface = '',
      Module = '<module>',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '',
      Keyword = '',
      Snippet = '<snippet>',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = '',
      Event = '',
      Operator = '',
      TypeParameter = '',
      Misc = '',
    }

    cmp.setup {

      view = {
        docs = { auto_open = true },
      },

      window = {

        completion = cmp.config.window.bordered({
          border = 'single',
          max_width = 80,
          max_height = 12,
          scrollbar = false,
        }),

        documentation = cmp.config.window.bordered({
          border = 'single',
          max_width = 80,
          max_height = 12,
        }),

      },

      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = {

        -- press return to confirm completion
        ['<CR>'] = cmp.mapping.confirm{ select = true },

        -- vim-motion-esque navigation in cmp items
        ['<C-S-j>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }
        ),

        -- vim-motion-esque navigation in cmp items
        ['<C-S-k>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }
        ),

        -- toggle documentation
        ['<C-d>'] = cmp.mapping(
          function(fallback)
            if cmp.visible_docs() then
              cmp.close_docs()
            elseif cmp.visible() then
              cmp.open_docs()
            else
              fallback()
            end
          end, { 'i', 's' }
        ),

      },

      formatting = {

        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)

          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])

          vim_item.menu = ({
            nvim_lsp = 'lsp',
            buffer = 'buff',
            path = 'path',
          })[entry.source.name]

          return vim_item

        end,

      },

      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },

      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },

      experimental = {
        ghost_text = false,
        native_menu = false,
      },

    }

  end,

}
