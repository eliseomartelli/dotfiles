-- neoformat.rc
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

autocmd("BufWritePre", { pattern = "*", command = "Neoformat" })
