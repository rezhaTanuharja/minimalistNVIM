---
-- @file lua/internal_plugins/snippets/python.lua
--
-- @brief
-- The collection of snippets for python files
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-05
--


return {

  -- a function definition
  {
    trigger = 'def',
    body = 'def ${1:function_name}(${2:args})\n\n\t${3:pass}\n$0',
    preview = '**def** `function_name`(args)\n\n\tpass',
  },

  -- a parent class definition
  {
    trigger = 'class',
    body = 'class ${1:class_name}:\n\n\tdef __init__(self, ${2:*args, **kwargs}):\n\t\t${3:pass}\n$0',
    preview = '**class** `class_name`:\n\n\tdef `__init__`(self, *args, **kwargs):\n\t\tpass',
  },

  -- a child class definition
  {
    trigger = 'class',
    body = 'class ${1:class_name}(${2:ABC}):\n\n\tdef __init__(self, ${3:*args, **kwargs}):\n\t\t${4:pass}\n$0',
    preview = '**class** `class_name`(ABC):\n\n\tdef `__init__`(self, *args, **kwargs):\n\t\tpass',
  },

  -- an abstract method definition
  {
    trigger = 'abstract',
    body = '@abstractmethod\ndef ${1:function_name}(self, ${2:*args, **kwargs})\n\t${3:pass}\n$0',
    preview = '`@abstractmethod`\n**def** `function_name`(self, *args, **kwargs)\n\tpass',
  },

}
