---
-- @file lua/options.lua
--
-- @brief
-- The configuration file to set the general nvim behaviour
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


local options = {

  -- options to configure user interface

  mouse = '',                   -- disable the mouse in neovim
  clipboard = 'unnamedplus',    -- neovim uses the system clipboard by default
  guifont = 'monospace:h16',    -- the font used in graphical neovim application
  termguicolors = true,         -- use the proper color
  cmdheight = 1,                -- only need to display one line for commands
  pumheight = 10,               -- pop up menu height
  showtabline = 0,              -- hide tabline
  inccommand = 'split',         -- when substituting multiple texts, display a preview at the bottom
  timeoutlen = 300,             -- time for user to finish a key combination
  updatetime = 200,             -- faster completion
  showmode = false,             -- mode will be shown by statusline instead
  virtualedit = 'block',        -- enable highlighting empty spaces

  -- options to configure the left column

  relativenumber = true,        -- display relative line numbers
  number = true,                -- display the current line number
  numberwidth = 4,              -- set the width of number column
  signcolumn = 'yes',           -- add a column next to line number for signs

  -- options to configure how tab behaves

  expandtab = true,             -- convert tabs into spaces
  shiftwidth = 2,               -- the number of spaces for each indentation
  tabstop = 2,                  -- the number of spaces for each tab

  -- options to configure how texts are shown in a window

  wrap = false,                 -- no text wrapping (ugly)
  smartindent = true,           -- automatic indentation
  scrolloff = 99,               -- keeps cursor in the middle
  sidescrolloff = 6,            -- minimal number of screen columns to the left and right of the cursor

  -- options to configure how search works

  hlsearch = true,              -- highlight all words that match the search pattern
  ignorecase = true,            -- search is case-insensitive
  smartcase = true,             -- but if our search contains uppercase(s), it become case-sensitive

  -- options to configure how multiple panes behave

  splitbelow = true,            -- for a vertical split, the new window goes to the bottom
  splitright = true,            -- for a horizontal split, the new window goes to the right

  -- options to configure how text folding works

  fillchars = {
    eob = ' ',                  -- removes tilde from number column in a short file
    fold = '-',                 -- replace dots from trailing fold characters
  },

  foldlevelstart = 99,          -- new files open with everything unfolded
  foldtext = '',                -- keep colors of folded lines

  -- miscellaneous

  backup = false,               -- do not creates a backup file
  writebackup = false,          -- if a file is being edited in another program
  swapfile = false,             -- do not creates a swapfile
  undofile = true,              -- enable persistent undo
  fileencoding = 'utf-8',       -- the encoding written to a file

}


-- set all option parameters to their respective values

for parameter, value in pairs(options) do
  vim.opt[parameter] = value
end
