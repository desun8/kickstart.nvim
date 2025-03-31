local M = {}

function M.getApiKeyFromFile(key_type)
  -- Define a table with mappings from key_type to file paths
  local file_paths = {
    openai = vim.fn.stdpath('config') .. '/.openai_api_key',
    -- Add other key types and their corresponding paths here
  }

  -- Check if the key_type exists in the table
  local config_path = file_paths[key_type]
  if not config_path then
    error("Unknown key type: " .. key_type)
  end

  -- Read the API key from the file
  local handle = io.popen('cat ' .. config_path)
  local api_key = handle:read('*a')
  handle:close()

  -- Clean up the API key by removing trailing spaces and newlines
  api_key = api_key:gsub('%s+$', '') -- Remove trailing spaces
  api_key = api_key:gsub('\n', '') -- Remove newline characters

  return api_key
end

return M
