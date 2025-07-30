---
-- @file lsp/ruby-lsp.lua
--
-- @brief
-- The configuration file for the Ruby LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-07-08
--


local function pretty_print(items)

  local max_name_len = 0
  local max_version_len = 0

  for _, item in ipairs(items) do
    max_name_len = math.max(max_name_len, #item.name)
    max_version_len = math.max(max_version_len, #item.version)
  end

  local lines = {}

  for _, item in ipairs(items) do
    local name = item.name .. string.rep(" ", max_name_len - #item.name)
    local version = item.version .. string.rep(" ", max_version_len - #item.version)
    local dep = item.dependency or ""
    table.insert(lines, string.format("%s %s - %s", name, version, dep))
  end

  return lines

end

local function open_preview_window(contents)

  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, contents)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  vim.cmd("pbuffer " .. buf)

end

local function add_ruby_deps_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
    local params = vim.lsp.util.make_text_document_params()
    local showAll = opts.args == "all"

    client.request("rubyLsp/workspace/dependencies", params, function(error, result)
      if error then
        print("Error showing deps: " .. error)
        return
      end

      local items = {}

      for _, item in ipairs(result) do
        if showAll or item.dependency then
          table.insert( items, item )
        end
      end

      local lines = pretty_print(items)

      open_preview_window(lines)
    end, bufnr)
  end,
  {nargs = "?", complete = function() return {"all"} end})
end


return {

  filetypes = { "ruby" },

  cmd = { "bundle", "exec", "ruby-lsp" },

  root_markers = { "Gemfile", ".git" },
  
  init_options = {
    enabledFeatures = {
      formatting = false,
    },
  },

  on_init = function(client)
    client.offset_encoding = "utf-8"
  end,

  on_attach = function(client, buffer)
    add_ruby_deps_command(client, buffer)
  end,

}
