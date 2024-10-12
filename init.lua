local config_files = {
  'options',
  'keymaps',
}

for _, file in pairs(config_files) do

  local success, _ = pcall(require, file)
  if not success then
    vim.notify('Failed to load a config file ' .. file)
    break
  end

end
