---
-- @file lua/internal_plugins/snippets/lua.lua
--
-- @brief
-- The collection of snippets for lua files
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-05
--


return {

  -- a function definition
  { 
    trigger = 'function',
    body = 'function ${1:name}(${2:args})\n\t${3:actions}\nend\n$0',
    preview = '**function** name(args)\n\tactions\n**end**',
  },

}
