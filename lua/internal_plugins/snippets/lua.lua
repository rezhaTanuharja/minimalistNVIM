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

  -- a table definition
  { 
    trigger = 'table',
    body = '{ ${1:items} }$0',
    preview = '{ items }',
  },

  -- a big table definition
  { 
    trigger = 'big_table',
    body = '{\n\t${1:items}\n}\n$0',
    preview = '{\n\titems\n}',
  },

  -- a named table definition
  { 
    trigger = 'named_table',
    body = '${1:name} = {\n\t${2:items}\n}\n$0',
    preview = 'name = {\n\titems\n}',
  },

  -- a table item
  { 
    trigger = 'item',
    body = "['${1:key}'] = ${2:values},$0",
    preview = "['key'] = values,",
  },

  -- a for loop
  { 
    trigger = 'loop',
    body = 'for ${1:key}, ${2:value} in pairs(${3:table}) do\n\t${4:actions}\nend\n$0',
    preview = '**for** key, value in **pairs**(table) **do**\n\tactions\n**end**',
  },

  -- a protected call
  { 
    trigger = 'pcall',
    body = 'success, ${1:variable} = pcall(require, ${2:file})\nif not success then\n\t${3:fallback}\nend\n$0',
    preview = 'success, variable = **pcall**(require, file)\n**if** **not** success **then**\n\tfallback\n**end**',
  },

}
