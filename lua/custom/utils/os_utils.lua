local M = {}

-- Проверка, является ли текущая ОС macOS
function M.is_mac()
  return vim.loop.os_uname().sysname == 'Darwin'
end

-- Проверка, является ли текущая ОС Linux
function M.is_linux()
  return vim.loop.os_uname().sysname == 'Linux'
end

return M
