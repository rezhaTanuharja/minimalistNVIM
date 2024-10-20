---
-- @file lua/snippets/python.lua
--
-- @brief
-- The collection of snippets for python files
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-05
--


local debug_command = ''
local debug_command_preview = ''

debug_command = debug_command ..
  'import debugpy\n' ..
  '\n' ..
  'debug = os.getenv("DEBUG_FLAG", "0")\n' ..
  '\n' ..
  'if debug == "1":\n' ..
  '\trank = int(os.getenv("RANK", "-1"))\n' ..
  '\tif rank == 0:\n' ..
  '\t\tdebugpy.listen(("${1:127.0.0.1}", ${2:5678}))\n' ..
  '\t\tdebugpy.wait_for_client()\n' ..
  '\t\tdebugpy.breakpoint()\n' ..
  '\n$0'

debug_command_preview = debug_command_preview ..
  '**import** debugpy\n' ..
  '\n' ..
  'debug = **os**.`getenv`("`DEBUG_FLAG`", "0")\n' ..
  '\n' ..
  '**if** debug == "1":\n' ..
  '\trank = **int**(**os**.`getenv`("RANK", "-1"))\n' ..
  '\t**if** rank == 0:\n' ..
  '\t\t**debugpy**.`listen`(("127.0.0.1", 5678))\n' ..
  '\t\t**debugpy**.`wait_for_client`()\n' ..
  '\t\t**debugpy**.`breakpoint`()\n\n'


return {

  -- a main function body
  {
    trigger = 'main',

    body = '' ..
      'def main():\n' ..
      '\t${1:pass}\n' ..
      '\t$0\n' ..
      '\n' ..
      'if __name__ == "__main__":\n'..
      '\tmain()',

    preview = '' ..
      '**def** `main`():\n' ..
      '\tpass\n' ..
      '\n' ..
      '**if** `__name__` == `"__main__"`:\n' ..
      '\t`main`()',
  },

  {
    trigger = 'main_torch',
    body = 'def main(rank: int, world_size:int):\n\n\t${1:pass}\n$0\n\nif __name__ == "__main__":\n\n\tlocal_rank = int(os.getenv("RANK", "0"))\n\tworld_size = int(os.getenv("WORLD_SIZE", "1"))\n\n\tmain(rank = local_rank, world_size = world_size)',
    preview = '**def** `main`():\n\tpass\n\n**if** `__name__` == `"__main__"`:\n\t`main`()',
  },

  -- import an object from a module
  {
    trigger = 'from',
    body = 'from ${1:module} import ${2:object}\n$0',
    preview = '**from** module **import** object',
  },

  -- a function definition
  {
    trigger = 'def',
    body = 'def ${1:function_name}(${2:args}):\n\n\t${3:pass}\n$0',
    preview = '**def** `function_name`(args):\n\n\tpass',
  },

  -- a parent class definition
  {
    trigger = 'class',
    body = 'class ${1:class_name}:\n\n\tdef __init__(${2:self}):\n\t\t${3:pass}\n$0',
    preview = '**class** `class_name`:\n\n\tdef `__init__`(self):\n\t\tpass',
  },

  -- a child class definition
  {
    trigger = 'class',
    body = 'class ${1:class_name}(${2:ABC}):\n\n\t@abstractmethod\n\tdef __init__(self, ${3:*args, **kwargs}):\n\t\t${4:pass}\n$0',
    preview = '**class** `class_name`(ABC):\n\n\tdef `__init__`(self, *args, **kwargs):\n\t\tpass',
  },

  -- an abstract method definition
  {
    trigger = 'method_abstract',
    body = '@abstractmethod\ndef ${1:function_name}(self, ${2:*args, **kwargs}):\n\t${3:pass}\n$0',
    preview = '`@abstractmethod`\n**def** `function_name`(self, *args, **kwargs)\n\tpass',
  },

  -- a boiler plate to enable the torch distributed debugging session
  {
    trigger = 'debugger_boiler_plate',
    body = debug_command,
    preview = debug_command_preview,
  },

  {
    trigger = 'group',
    body = 'torch.distributed.init_process_group(\n\tbackend = "${1:gloo}",\n\trank = ${2:rank},\n\tworld_size = ${3:world_size}\n)\n\n$0\n\ntorch.distributed.destroy_process_group()',
    preview = '',
  },

}
