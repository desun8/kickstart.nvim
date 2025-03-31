return {
  {
    'olimorris/codecompanion.nvim',
    config = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = require('custom.utils.getApiKeyFromFile').getApiKeyFromFile 'openai',
            },
            schema = {
              model = {
                default = 'o3-mini',
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = 'openai',
        },
        inline = {
          adapter = 'openai',
        },
      },
    },
  },
  {
    vim.keymap.set('n', '<leader>tcc', ':CodeCompanionChat<CR>', { desc = '[T]oggle [C]companion [C]hat' }),
    vim.keymap.set('n', '<leader>tca', ':CodeCompanionActions<CR>', { desc = '[T]oggle [C]companion [A]ctions' }),
  },
}
