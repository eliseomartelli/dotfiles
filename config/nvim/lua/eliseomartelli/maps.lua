-- Key maps.

local keymap = vim.keymap.set

-- move and indent selected lines
keymap('v', 'K', [[:move '<-2<CR>gv=gv]])
keymap('v', 'J', [[:move '>+1<CR>gv=gv]])

-- change working directory
keymap('n', '<leader>cd', '<cmd>:cd %:p:h<CR>:pwd<CR>')

-- resizing
keymap('n', '<Up>', '<cmd>resize +2<CR>')
keymap('n', '<Down>', '<cmd>resize -2<CR>')
keymap('n', '<Left>', '<cmd>vertical resize +2<CR>')
keymap('n', '<Right>', '<cmd>vertical resize -2<CR>')


-- ESC to clear highlight.
keymap("n", "<Esc>", ":noh<CR>")

