require('fzf-lua').register_ui_select()

vim.keymap.set('n', '<leader>sf', '<cmd>FzfLua files<CR>', { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>s/', '<cmd>FzfLua live_grep<CR>', { desc = 'Fuzzy [S]earch Words in Files [/]' })
vim.keymap.set('n', '<leader>sn', '<cmd>FzfLua files cwd = \'~/.config/nvim\'<CR>',
	{ desc = 'Fuzzy [S]earch Words in Files [/]' })
