-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Sync theme with system colorscheme (ligh/dark)
  {
    'cormacrelf/dark-notify',
    config = function()
      require('dark_notify').run {
        onchange = function(mode)
          vim.cmd.colorscheme 'tokyonight'
        end,
      }
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      -- Когда/если появится поддержка кастомных путей
      -- local mason_registry = require 'mason-registry'
      -- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

      require('typescript-tools').setup {
        filetypes = {
          'typescript',
          'javascript',
          'typescriptreact',
          'javascriptreact',
          'vue',
        },
        settings = {
          tsserver_plugins = {
            -- Устaновил глобально
            '@vue/typescript-plugin',
            -- Нет поддержки кастомных путей :(
            -- {
            --   name = '@vue/typescript-plugin',
            --   location = vue_language_server_path,
            --   languages = { 'vue' },
            -- },
          },
        },
      }
    end,
  },
}
