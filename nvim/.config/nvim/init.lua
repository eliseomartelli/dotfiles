local keymap = vim.keymap.set

-- Cache modules.
vim.loader.enable()

-- Display tabs and spaces.
vim.opt.list = true

-- Highlight on search.
vim.opt.hlsearch = true

-- Show relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse.
vim.opt.mouse = 'a'

-- Case insensitive search.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show signcolumn.
vim.opt.signcolumn = 'yes'

-- Decrease mapped sequence wait time.
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience.
vim.opt.completeopt = 'menuone,noselect'

-- Show ruler.
vim.opt.ruler = true

-- Show column at 80 characters.
vim.opt.colorcolumn = "80"

-- Ask for confirmations.
vim.opt.confirm = true

-- Default tabstop.
vim.opt.tabstop = 4

-- Increment alpha and octals.
vim.opt.nrformats:append({ 'alpha', 'octal', 'hex', 'bin' })

-- Disable showmode (Statusline has already it).
vim.opt.showmode = false

-- Save undo file.
vim.opt.undofile = true

-- Set colorscheme.
vim.cmd [[colorscheme wildcharm]]

-- Highlight when yanking text.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank',
    { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Disable space in normal and visual mode.
keymap({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- Resize panes using arrows.
keymap('n', '<left>', '<cmd>vertical resize +2<CR>')
keymap('n', '<right>', '<cmd>vertical resize -2<CR>')
keymap('n', '<down>', '<cmd>horizontal resize +2<CR>')
keymap('n', '<up>', '<cmd>horizontal resize -2<CR>')

-- Diagnostics.
keymap('n', '<leader>of', vim.diagnostic.open_float,
  { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist,
  { desc = 'Open diagnostics list' })

-- Search highlight.
keymap('n', '<esc>', ":noh<CR>")

-- Packages.
require "paq" {
  -- Package manager.
  { "savq/paq-nvim" },

  -- Tabstop and shiftwidth.
  { "tpope/vim-sleuth" },

  -- LSP.
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "folke/neodev.nvim" },
  { "neovim/nvim-lspconfig" },

  -- Show codeactions.
  { "kosayoda/nvim-lightbulb" },


  -- Notifications.
  { "j-hui/fidget.nvim" },

  -- Snippet engine.
  { "L3MON4D3/LuaSnip",
    build = "make install_jsregexp" },
  { "saadparwaiz1/cmp_luasnip" },

  -- LSP completion.
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },

  -- Snippets.
  { "rafamadriz/friendly-snippets" },

  -- Completion.
  { "hrsh7th/nvim-cmp" },

  -- Show git.
  { "lewis6991/gitsigns.nvim" },

  -- Plenary.
  { "nvim-lua/plenary.nvim" },

  -- Telescope.
  { "nvim-telescope/telescope.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Lspkind.
  { "onsails/lspkind-nvim" },

  -- Nvim tree.
  { "nvim-tree/nvim-tree.lua" },

  -- Treesitter.
  { "nvim-treesitter/nvim-treesitter" },

  -- Dev icons.
  { "kyazdani42/nvim-web-devicons" },

  -- Formatter.
  { "stevearc/conform.nvim" },
  { "zapling/mason-conform.nvim" },

  -- Debug Adapter
  { "mfussenegger/nvim-dap" },
  { "nvim-neotest/nvim-nio" },
  { "rcarriga/nvim-dap-ui" },

  -- Statusline.
  { "echasnovski/mini.statusline" },

  -- Pending keybinds.
  { "folke/which-key.nvim" },

  -- Git.
  { 'tpope/vim-fugitive' },
}


-- Mason.
require("mason").setup {}

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {}

-- Fidget.
require('fidget').setup {}

-- Neodev.
require("neodev").setup {}

-- Luasnip.
require("luasnip.loaders.from_vscode").lazy_load()

-- CMP.
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {},
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    -- Accept currently selected item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<C-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- can also be a function to dynamically calculate max width such as
      -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(_, vim_item)
        return vim_item
      end
    })
  }
})

-- CMP lsp.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

mason_lspconfig.setup_handlers({
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({ capabilities = capabilities })
  end, })

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

lspconfig.dartls.setup({})

lspconfig.denols.setup {
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.ts_ls.setup {
  root_dir = lspconfig.util.root_pattern("package.json"),
  single_file_support = false
}

lspconfig.sourcekit.setup {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}

-- mini.clue.
require("which-key").setup()

-- Gitsigns.
require('gitsigns').setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

-- Telescope.
local telescope = require("telescope.builtin")

keymap('n', '<leader>ff', telescope.find_files, { desc = "Find files" })
keymap('n', '<leader>fg', telescope.live_grep, { desc = "Live grep files" })
keymap('n', '<leader>fw', telescope.grep_string, { desc = "Live grep current word" })
keymap('n', '<leader>fb', telescope.buffers, { desc = "Find buffers" })
keymap('n', '<leader>fh', telescope.help_tags, { desc = "Find in help" })

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Conform.
require("conform").setup({
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})
require("mason-conform").setup({})

-- DAP.
local dap = require("dap")

require("dap.ext.vscode").load_launchjs(nil, { delve = { "go" } })

dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

-- Treesitter.
require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

-- Dap UI
require("dapui").setup()

local widgets = require("dap.ui.widgets")

keymap("n", "<F5>", dap.continue)
keymap("n", "<F10>", dap.step_over)
keymap("n", "<F11>", dap.step_into)
keymap("n", "<F12>", dap.step_out)
keymap("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
keymap("n", "<Leader>B", dap.set_breakpoint, { desc = "Set breakpoint" })
keymap("n", "<Leader>lp", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Logpoint message" })
keymap("n", "<Leader>dr", dap.repl.open, { desc = "Open repl" })
keymap("n", "<Leader>dl", dap.run_last, { desc = "Run last" })
keymap({ "n", "v" }, "<Leader>dh", widgets.hover, { desc = "Hover" })
keymap({ "n", "v" }, "<Leader>dp", widgets.preview, { desc = "Preview" })
keymap("n", "<Leader>df", function()
  widgets.centered_float(widgets.frames)
end, { desc = "Show frames" })
keymap("n", "<Leader>ds", function()
  widgets.centered_float(widgets.scopes)
end, { desc = "Show scopes" })

-- Statusline.
local statusline = require('mini.statusline')
statusline.setup()

-- Disable line information in statusline.
statusline.section_location = function()
  return ''
end

-- LSP.
keymap({ "n", "v" }, "<leader>ca",
  vim.lsp.buf.code_action, { desc = "Code action." })
keymap("n", "gr", vim.lsp.buf.rename, { desc = "Rename" })
keymap("n", "gd", telescope.lsp_definitions, { desc = "Define" })
keymap('n', 'gD', telescope.diagnostics, { desc = 'Find diagnostics.' })
keymap("n", 'gu', telescope.lsp_references, { desc = 'Usages' })
keymap("n", '<leader>D', telescope.lsp_type_definitions, { desc = 'Definition for type.' })
keymap("n", '<leader>ds', telescope.lsp_document_symbols, { desc = 'Document Symbols' })
keymap("n", '<leader>ws', telescope.lsp_dynamic_workspace_symbols, { desc = 'Workspace Symbols' })

-- Show codeactions.
require("nvim-lightbulb").setup({
  autocmd = { enabled = true }
})

-- Nvim tree.
require("nvim-tree").setup()

keymap("n", "<leader>e", ":NvimTreeToggle<CR>")
