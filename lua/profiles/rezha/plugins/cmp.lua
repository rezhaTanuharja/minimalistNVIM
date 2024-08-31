---
-- @file lua/profiles/rezha/plugins/cmp.lua
--
-- @brief
-- The configuration file for the plugin cmp
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  -- github repository for nvim-cmp
  'hrsh7th/nvim-cmp',

  -- load when first entering insert mode
  event = 'InsertEnter',

  dependencies = {

    -- completion from LSP, buffer, and path
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',

    -- completion from luasnip
    require('profiles.rezha.plugins.luasnip'),

    'saadparwaiz1/cmp_luasnip',

  },

  config = function()

    local success, cmp = pcall(require, 'cmp')
    if not success then
      vim.notify('Failed to load plugin: cmp')
      return
    end

    local luasnip
    success, luasnip = pcall(require, 'luasnip')
    if not success then
      vim.notify('Failed to load plugin: luasnip')
      return
    end

    -- just don't use icons
    local kind_icons = {
      Text = '',
      Method = '',
      Function = '',
      Constructor = '',
      Field = '',
      Variable = '',
      Class = '',
      Interface = '',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '',
      Keyword = '',
      Snippet = '',
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

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = {

        -- press return to confirm completion
        ['<CR>'] = cmp.mapping.confirm{ select = true },

        -- press tab to select the next item
        ['<Tab>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }
        ),

        -- press shift-tab to select prev item
        ['<S-Tab>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
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

          vim_item.menu = (
            {
              luasnip = '[Snippet]',
              nvim_lsp = '[LSP]',
              buffer = '[Buffer]',
              path = '[Path]',
            }
          )[entry.source.name]

          return vim_item

        end,

      },

      sources = {
        { name = 'luasnip' },
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
