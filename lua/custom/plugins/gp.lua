local config_path = vim.fn.stdpath 'config' .. '/.openai_api_key'
local handle = io.popen('cat ' .. config_path)
local api_key = handle:read '*a'
handle:close()

api_key = api_key:gsub("%s+$", "") -- Удаление пробелов в конце
api_key = api_key:gsub("\n", "")   -- Удаление символов новой строки

return {
  {
    'robitx/gp.nvim',
    opts = {
      openai_api_key = api_key,
    },
  },
}
