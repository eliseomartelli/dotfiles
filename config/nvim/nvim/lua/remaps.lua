-- move and indent selected lines
vim.api.nvim_set_keymap('v', 'K', [[:move '<-2<CR>gv=gv]], {noremap = true})
vim.api.nvim_set_keymap('v', 'J', [[:move '>+1<CR>gv=gv]], {noremap = true})

-- change working directory
vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>:cd %:p:h<CR>:pwd<CR>', {noremap = true})

-- resizing
vim.api.nvim_set_keymap('n', '<Up>', '<cmd>resize +2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Down>', '<cmd>resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Left>', '<cmd>vertical resize +2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Right>', '<cmd>vertical resize -2<CR>', {noremap = true})

-- Explorer
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>:NvimTreeToggle<CR>', {noremap = true})
