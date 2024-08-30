---
-- @file lua/rezha/plugins.lua
--
-- @brief
-- The configuration file to manage and install plugins
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

-- Alias function to call vim function
local fn = vim.fn

-- Set packer installation path relative to nvim's data directory
local installPath = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

-- Clone packer repository and install if installation is missing
if fn.empty(fn.glob(installPath)) > 0 then

  PACKER_BOOTSTRAP = fn.system {
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", installPath
  }

  vim.notify("Close and reopen nvim for changes to take effect")
  vim.cmd [[packadd packer.nvim]]

end

local success, packer = pcall(require, "packer")
if not success then
  vim.notify("Error loading plugin: packer")
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float{border = "rounded"}
    end,
  },
}

return packer.startup(function(use)

  -- Packer manages itself
  use "wbthomason/packer.nvim"

  -- Dependencies of many other plugins
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- Modify interface
  use "kyazdani42/nvim-tree.lua"              -- file explorer
  use "akinsho/bufferline.nvim"               -- buffers appear as tabs
  use "nvim-telescope/telescope.nvim"         -- file finder and grep
  use "lewis6991/gitsigns.nvim"               -- git integration
  use "nvim-lualine/lualine.nvim"             -- add metadata at the bottom

  -- Modify nvim behaviours
  use "moll/vim-bbye"                         -- close a buffer without closing the window
  use "windwp/nvim-autopairs"                 -- automatically pair brackets and more

  -- Visual aids
  use "nvim-treesitter/nvim-treesitter"       -- syntax highlighting
  use "RRethy/vim-illuminate"                 -- highlight words that are the same as the one under the cursor
  use "lukas-reineke/indent-blankline.nvim"   -- add lines to indentations
  use "folke/tokyonight.nvim"                 -- a really cool colorscheme

  -- Language servers and autocompletion
  use "hrsh7th/nvim-cmp"                      -- cmp for completion
  use "hrsh7th/cmp-buffer"                    -- completion from buffer
  use "hrsh7th/cmp-path"                      -- completion from path
  use "hrsh7th/cmp-cmdline"                   -- completion for commandline
  use "hrsh7th/cmp-nvim-lsp"                  -- completion with LSP

  use "L3MON4D3/LuaSnip"
  -- use "rafamadriz/friendly-snippets"

  use "saadparwaiz1/cmp_luasnip"

  use "neovim/nvim-lspconfig"                 -- language servers configuration
  use "williamboman/mason.nvim"               -- install and manage language servers
  use "williamboman/mason-lspconfig.nvim"     -- integration with LSP


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
