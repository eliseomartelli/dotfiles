local ts = require("nvim-treesitter.configs")

ts.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
}

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- 
-- parser_config.tsx.filetype = {
--   "javascript",
--   "typescript.tsx",
--   "typescriptreact",
-- }
