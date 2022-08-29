-- move and indent selected lines
vim.keymap.set('v', 'K', [[:move '<-2<CR>gv=gv]])
vim.keymap.set('v', 'J', [[:move '>+1<CR>gv=gv]])

-- change working directory
vim.keymap.set('n', '<leader>cd', '<cmd>:cd %:p:h<CR>:pwd<CR>')

-- resizing
vim.keymap.set('n', '<Up>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<Down>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<Left>', '<cmd>vertical resize +2<CR>')
vim.keymap.set('n', '<Right>', '<cmd>vertical resize -2<CR>')
