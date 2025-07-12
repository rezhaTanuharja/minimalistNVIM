---
-- @file init.lua
--
-- @brief
-- The starting point of the Neovim config
--
-- @author Tanuharja, R.A.
-- @date 2024-10-12
--


vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("", "<space>", "<nop>", { desc = "space is only a leader key now" })

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0


local options = {

  -- user interface

  termguicolors = true,       -- enable 24-bit RGB color
  mouse = "",                 -- disable mouse in neovim
  clipboard = "unnamedplus",  -- makes neovim use the system clipboard
  winborder = "single",       -- all floating window has a single border
  cursorline = true,          -- highlight the row where the cursor is
  showtabline = 0,            -- hide tabline
  inccommand = "split",       -- when performing substitution, show preview at the bottom
  timeoutlen = 300,           -- time for user to finish a key combination
  updatetime = 200,           -- faster completion
  virtualedit = "block",      -- enable highlighting empty spaces
  splitbelow = true,          -- when splitting horizontally, new window goes below
  splitright = true,          -- when splitting vertically, new window goes to the right
  showmode = false,           -- mode will be shown by statusline instead
  cmdheight = 0,              -- hide the command line when not typing command
  path = ".,,**",             -- find-like operations works recursively

  -- tabs and indentations

  expandtab = true,           -- convert tabs into spaces
  shiftwidth = 2,             -- the number of spaces for each indentation
  tabstop = 2,                -- the number of spaces for each tab

  -- number columns

  relativenumber = false,     -- don't display relative line numbers
  relativenumber = true,      -- don't display relative line numbers
  number = true,              -- display the current line number
  numberwidth = 3,            -- the column width to display line numbers

  -- text display

  foldlevelstart = 99,        -- open files with all folds open
  foldtext = "",              -- keep the first line of folded section visible
  foldmethod = "expr",        -- assign fold based on expressions

  foldexpr = 'v:lua.vim.treesitter.foldexpr()',

  wrap = false,               -- do not wrap lines because it looks ugly and inconsistent
  smartindent = true,         -- automatic indentations
  scrolloff = 99,             -- keep cursorline in the middle
  sidescrolloff = 6,          -- minimul number of columns to the left and right of cursor

  fillchars = {
    eob = " ",                -- removes annoying tilde at the bottom of short files
    fold = "-",               -- replace dots with horizontal line to indicate folded sections
    stl = "-",                -- fill empty spaces in the statusline with this
  },

  pumheight = 8,              -- specify the max height of pop-up menu
  pumwidth = 20,              -- specify the min width of pop-up menu
  pumblend = 15,              -- semi transparent pop-up menu

  -- text search

  ignorecase = true,          -- make search case-insensitive
  smartcase = true,           -- but if our search contains uppercase(s), it becomes case-sensitive
  hlsearch = false,           -- don't highlight search

  -- miscellaneous

  backup = false,             -- do not create a backup file
  swapfile = false,           -- do not create a swap file
  undofile = false,           -- undo is limited to the current session
  fileencoding = "utf-8",     -- the encoding written to a file

}

for parameter, value in pairs(options) do
  vim.opt[parameter] = value
end


-- config below is for Lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then

  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

end

vim.opt.rtp:prepend(lazypath)

local success, lazy = pcall(require, "lazy")
if not success then
  vim.notify("Failed to load plugin: lazy")
  return
end

lazy.setup {

  dev = {
    path = "~/.config/nvim/projects",
    fallback = false,
  },

  lockfile = nil,

  rocks = {
    enabled = false,
    hererocks = false,
  },

  ui = {
    border = "single",
    icons = {
      cmd = "",
      config = "",
      event = "",
      favorite = "",
      ft = "",
      init = "",
      import = "",
      keys = "",
      lazy = "",
      loaded = "●",
      not_loaded = "○",
      plugin = "",
      runtime = "",
      require = "",
      source = "",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },

  change_detection = {
    enabled = false,
    notify = false,
  },

  performance = {

    cache = {
      enabled = true,
    },

    reset_packpath = true,

    rtp = {
      reset = true,
      disabled_plugins = {
        "editorconfig",
        "gzip",
        "man",
        "netrwPlugin",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },

  },

  spec = {{import = "plugins"}},

  install = { colorscheme = { "default" } },

}
