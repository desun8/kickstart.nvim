return {
 {
    'famiu/bufdelete.nvim',
  },
  {
    vim.keymap.set('n', '<C-q>', ':Bdelete<CR>', { desc = 'Buffer Delete' }),
    vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Buffer Forward' }),
    vim.keymap.set('n', '<S-h>', ':bprev<CR>', { desc = 'Buffer Backward' }),
  },
}
