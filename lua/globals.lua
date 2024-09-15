---
-- @file lua/globals.lua
--
-- @brief
-- The configuration file to define global variables
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


local variables = {
  loaded_perl_provider = 0,         -- this configuration does not use perl
  mapleader = ' ',                  -- space is a global leader key
  maplocalleader = ' ',             -- space is a local leader key as well
}

for variable, value in pairs(variables) do
  vim.g[variable] = value
end
