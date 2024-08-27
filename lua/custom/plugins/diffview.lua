return {
  {
    'sindrets/diffview.nvim',
    opts = {},
    config = function()
      local is_visible = false
      local function toggle_view()
        if is_visible then
          vim.cmd 'DiffviewClose'
          is_visible = false
        else
          vim.cmd 'DiffviewOpen'
          is_visible = true
        end
      end
      vim.keymap.set('n', '<leader>td', toggle_view, { desc = '[T]oggle [D]iffview' })
    end,
  },
}
