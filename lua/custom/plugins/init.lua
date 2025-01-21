-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local os_utils = require 'custom.utils.os_utils'

return {
  -- Sync theme with system colorscheme (ligh/dark)
  os_utils.is_mac()
    and {
      'cormacrelf/dark-notify',
      config = function()
        require('dark_notify').run {
          onchange = function(mode)
            vim.cmd.colorscheme 'tokyonight'
          end,
        }
      end,
    },
  os_utils.is_linux() and {
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
  },
  -- Работает с nvim-lspconfig < v1.0.0
  -- {
  --   'pmizio/typescript-tools.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  --   config = function()
  --     -- Когда/если появится поддержка кастомных путей
  --     -- local mason_registry = require 'mason-registry'
  --     -- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
  --
  --     require('typescript-tools').setup {
  --       filetypes = {
  --         'typescript',
  --         'javascript',
  --         'typescriptreact',
  --         'javascriptreact',
  --         'vue',
  --       },
  --       settings = {
  --         tsserver_plugins = {
  --           -- Устaновил глобально
  --           '@vue/typescript-plugin',
  --           -- Нет поддержки кастомных путей :(
  --           -- {
  --           --   name = '@vue/typescript-plugin',
  --           --   location = vue_language_server_path,
  --           --   languages = { 'vue' },
  --           -- },
  --         },
  --       },
  --     }
  --   end,
  -- },
}
