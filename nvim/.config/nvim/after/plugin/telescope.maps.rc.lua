local keymap = vim.keymap.set

-- telescope.
local builtin = require("telescope.builtin")
keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files." })
keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep." })
keymap("n", "<leader>fb", builtin.buffers, { desc = "Find buffers." })
keymap("n", "<leader>fh", builtin.help_tags, { desc = "Find help." })
