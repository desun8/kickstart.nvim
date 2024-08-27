-- Проверяет наличие файла в проекте (как я понимаю в корне)
local function has_config(files)
  for _, file in ipairs(files) do
    if vim.fn.filereadable(file) == 1 then
      return true
    end
  end
  return false
end

local eslint_configs = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
}

local stylelint_configs = {
  '.stylelintrc',
  '.stylelintrc.js',
  '.stylelintrc.json',
  '.stylelintrc.yaml',
  '.stylelintrc.yml',
  'stylelint.config.js',
}

return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      local function toggle_linters()
        if next(lint.linters_by_ft) then
          lint.linters_by_ft = {}
          require('fidget').notify 'All linters disabled'
        else
          lint.linters_by_ft = {
            markdown = { 'markdownlint' },
          }

          -- Если есть конфиг, то мы добавляем линтер.
          -- Нужно для того, чтобы не было отображения ошибки,
          -- если проект без, например, eslint
          if has_config(eslint_configs) then
            for _, lang in ipairs { 'javascript', 'typescript', 'vue' } do
              lint.linters_by_ft[lang] = { 'eslint_d' }
            end
          end

          if has_config(stylelint_configs) then
            for _, lang in ipairs { 'css', 'vue' } do
              if lint.linters_by_ft[lang] then
                table.insert(lint.linters_by_ft[lang], 'stylelint')
              else
                lint.linters_by_ft[lang] = { 'stylelint' }
              end
            end
          end
          require('fidget').notify 'All linters enabled'
        end

        -- Refresh linting status for all buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
            lint.try_lint()
          end
        end
      end

      toggle_linters()

      vim.keymap.set('n', '<leader>tl', toggle_linters, { desc = '[T]oggle [L]inters' })

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
