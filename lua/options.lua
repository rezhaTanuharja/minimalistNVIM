---
-- @file lua/options.lua
--
-- @brief
-- The file to set general Neovim behaviours
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-12
--


local options = {

  -- user interface

  termguicolors = true,       -- enable 24-bit RGB color
  mouse = '',                 -- disable mouse in neovim
  clipboard = 'unnamedplus',  -- makes neovim use the system clipboard
  cursorline = true,          -- highlight the row where the cursor is
  showtabline = 0,            -- hide tabline
  inccommand = 'split',       -- when performing substitution, show preview at the bottom
  timeoutlen = 300,           -- time for user to finish a key combination
  updatetime = 200,           -- faster completion
  virtualedit = 'block',      -- enable highlighting empty spaces
  splitbelow = true,          -- when splitting horizontally, new window goes below
  splitright = true,          -- when splitting vertically, new window goes to the right
  showmode = false,           -- mode will be shown by statusline instead
  cmdheight = 0,              -- hide the command line when not typing command
  path = '.,,**',             -- find-like operations works recursively

  -- tabs and indentations

  expandtab = true,           -- convert tabs into spaces
  shiftwidth = 2,             -- the number of spaces for each indentation
  tabstop = 2,                -- the number of spaces for each tab

  -- number columns

  relativenumber = false,     -- don't display relative line numbers
  number = true,              -- display the current line number
  numberwidth = 3,            -- the column width to display line numbers

  -- text display

  foldlevelstart = 0,         -- open files with all folds closed
  foldtext = '',              -- keep the first line of folded section visible
  foldmethod = 'expr',        -- assign fold based on expressions

  foldexpr = 'nvim_treesitter#foldexpr()',

  wrap = false,               -- do not wrap lines because it looks ugly and inconsistent
  smartindent = true,         -- automatic indentations
  scrolloff = 99,             -- keep cursorline in the middle
  sidescrolloff = 6,          -- minimul number of columns to the left and right of cursor

  fillchars = {
    eob = ' ',                -- removes annoying tilde at the bottom of short files
    fold = '-',               -- replace dots with horizontal line to indicate folded sections
    stl = '-',                -- fill empty spaces in the statusline with this
  },

  pumheight = 8,              -- specify the max height of pop-up menu
  pumwidth = 20,              -- specify the min width of pop-up menu
  pumblend = 15,              -- semi transparent pop-up menu

  -- text search

  ignorecase = true,          -- make search case-insensitive
  smartcase = true,           -- but if our search contains uppercase(s), it becomes case-sensitive

  -- miscellaneous

  backup = false,             -- do not create a backup file
  swapfile = false,           -- do not create a swap file
  undofile = false,           -- undo is limited to the current session
  fileencoding = 'utf-8',     -- the encoding written to a file

}

for parameter, value in pairs(options) do
  vim.opt[parameter] = value
end
