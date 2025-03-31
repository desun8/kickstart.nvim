-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local os_utils = require 'custom.utils.os_utils'

local plugins = {}

if os_utils.is_mac() then
  table.insert(plugins, {
    'cormacrelf/dark-notify',
    config = function()
      require('dark_notify').run {
        onchange = function(mode)
          vim.cmd.colorscheme 'tokyonight'
        end,
      }
    end,
  })
end

if os_utils.is_linux() then
  table.insert(plugins, {
    'f-person/auto-dark-mode.nvim',
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', {})
        vim.cmd 'colorscheme tokyonight'
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value('background', 'light', {})
        vim.cmd 'colorscheme tokyonight-day'
      end,
    },
  })
end

return plugins
