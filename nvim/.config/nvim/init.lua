-- vim: ts=2 sts=2 sw=2 et

-- Cache modules.
vim.loader.enable()

-- Set nerd font flag.
vim.g.have_nerd_font = true

-- Show line numbers.
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse.
vim.o.mouse = "a"

-- Disable showmode (Statusline already has it).
vim.o.showmode = false

-- Enable breakindent.
vim.o.breakindent = true

-- Save undo file.
vim.o.undofile = true

-- Set colorscheme.
vim.cmd.colorscheme("wildcharm")

-- Case insensitive search.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Use ripgrep for search if available.
if vim.fn.executable("rg") == 1 then
	vim.o.grepprg =
		"rg --smart-case --vimgrep --no-heading --follow --multiline --multiline-dotall --hidden --pcre2 --regexp"
	vim.o.grepformat = "%f:%l:%c:%m"
end

-- Automatically open quickfix list on search / grep.
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	desc = "Automatically open quickfix list on search",
	group = vim.api.nvim_create_augroup("kickstart-quickfix", { clear = true }),
	pattern = { "[^l]*" },
	command = "cwindow",
})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	desc = "Automatically open location list on search",
	group = "kickstart-quickfix",
	pattern = { "l*" },
	command = "lwindow",
})

-- Show signcolumn.
vim.o.signcolumn = "yes"

-- Decrease mapped sequence wait time.
vim.o.updatetime = 250

-- Timeout for mapped sequences.
vim.o.timeoutlen = 300

-- Split windows below and to the right.
vim.o.splitright = true
vim.o.splitbelow = true

-- Display tabs and spaces.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live.
vim.o.inccommand = "split"

-- Show cursorline.
vim.o.cursorline = true

-- Show ruler.
vim.o.ruler = true

-- Show column at 80 characters.
vim.o.colorcolumn = "80"

-- Default tab indentation (4 chars).
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Ask for confirmations.
vim.o.confirm = true

-- Enable project-local configuration (.nvim.lua, .exrc)
vim.o.exrc = true

-- Clear search highlight on <Esc>.
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics.
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

-- Diagnostic keymaps.
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Open diagnostic [Q]uickfix list" })

-- Terminal keymaps.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode.
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Window navigation.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Quickfix navigation and toggle.
vim.keymap.set("n", "<C-n>", function()
	if _G.git_review and _G.git_review.nav then
		_G.git_review.nav(1)
	else
		pcall(vim.cmd.cnext)
	end
end, { desc = "Next quickfix item (or review commit)" })
vim.keymap.set("n", "<C-p>", function()
	if _G.git_review and _G.git_review.nav then
		_G.git_review.nav(-1)
	else
		pcall(vim.cmd.cprev)
	end
end, { desc = "Previous quickfix item (or review commit)" })
vim.keymap.set("n", "<leader>cq", function()
	local qf_win = vim.fn.getqflist({ winid = 0 }).winid
	if qf_win ~= 0 then
		vim.cmd.cclose()
	else
		vim.cmd.copen()
	end
end, { desc = "Toggle [Q]uickfix list" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Vim pack.
-- check updates:  :lua vim.pack.update(nil, { offline = true })
-- update plugins: :lua vim.pack.update()

local function update_all()
	vim.notify("Updating plugins (vim.pack)...", vim.log.levels.INFO)
	pcall(function()
		vim.pack.update()
	end)

	vim.notify("Updating Treesitter parsers...", vim.log.levels.INFO)
	pcall(function()
		vim.cmd("TSUpdate")
	end)

	vim.notify("Updating Mason tools & registries...", vim.log.levels.INFO)
	pcall(function()
		vim.cmd("MasonUpdate")
	end)
	pcall(function()
		require("mason-tool-installer").check_install(true)
	end)
end

vim.api.nvim_create_user_command("UpdateAll", update_all, {
	desc = "Update vim.pack plugins, Treesitter parsers, and Mason tools",
})

local function run_build(name, cmd, cwd)
	local result = vim.system(cmd, { cwd = cwd }):wait()
	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout
		if output == "" then
			output = "No output from build command."
		end
		vim.notify(string.format("Build failed for %s:\n%s", name, output), vim.log.levels.ERROR)
	end
end

-- This autocommand runs after a plugin is installed or updated and
--  runs the appropriate build command for that plugin if necessary.
--
-- See `:help vim.pack-events`
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
			run_build(name, { "make" }, ev.data.path)
			return
		end

		if name == "LuaSnip" then
			if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
				run_build(name, { "make", "install_jsregexp" }, ev.data.path)
			end
			return
		end

		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
			return
		end
	end,
})

-- Helper function to generate GitHub URLs for plugins.
local function gh(repo)
	return "https://github.com/" .. repo
end

-- Guess indent.
vim.pack.add({ gh("NMAC427/guess-indent.nvim") })
require("guess-indent").setup({})

-- Todo comments.
vim.pack.add({ gh("folke/todo-comments.nvim") })
require("todo-comments").setup({ signs = false })

-- Mini.nvim.
vim.pack.add({ gh("nvim-mini/mini.nvim") })
if vim.g.have_nerd_font then
	require("mini.icons").setup()
	-- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
	MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({
	-- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
	mappings = {
		around_next = "aa",
		inside_next = "ii",
	},
	n_lines = 500,
})

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

-- Pairs.
require("mini.pairs").setup()

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })

-- Telescope
---@type (string|vim.pack.Spec)[]
local telescope_plugins = {
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
}

if vim.fn.executable("make") == 1 then
	table.insert(telescope_plugins, gh("nvim-telescope/telescope-fzf-native.nvim"))
end

vim.pack.add(telescope_plugins)

require("telescope").setup({
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]earch Telescope" })
vim.keymap.set({ "n", "v" }, "<leader>fcw", builtin.grep_string, { desc = "[F]ind [C]urrent [W]ord" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [G]rep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fu", builtin.oldfiles, { desc = "[F]ind [U]sed files" })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "[F]ind [C]ommands" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })

-- Override default behavior and theme when searching
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- LSP.
vim.pack.add({ gh("j-hui/fidget.nvim") })
require("fidget").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gr", vim.lsp.buf.rename, "Rename")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("gd", builtin.lsp_definitions, "Goto Definition")
		map("gu", builtin.lsp_references, "Find Usages")
		map("gri", builtin.lsp_implementations, "Goto Implementation")
		map("<leader>D", builtin.lsp_type_definitions, "Definition for Type")
		map("<leader>ds", builtin.lsp_document_symbols, "Document Symbols")
		map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end
		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

vim.pack.add({
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
})

require("mason").setup({})

require("mason-lspconfig").setup({
	automatic_enable = true,
})

local servers = {
	-- recomended by nvim help docs.
	lua_ls = {
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
			client.config.settings.Lua = vim.tbl_deep_extend("force", current_settings.Lua, {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				workspace = {
					checkThirdParty = false,
					-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
					--  See https://github.com/neovim/nvim-lspconfig/issues/3189
					library = vim.api.nvim_get_runtime_file("", true),
				},
			})
		end,
		---@type lspconfig.settings.lua_ls
		settings = {
			Lua = {
				format = { enable = false }, -- Disable formatting (formatting is done by stylua)
			},
		},
	},
	gopls = {},
	ts_ls = {},
	angularls = {},
	dockerls = {},
	docker_compose_language_service = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	-- Formatters / Linters
	"stylua",
	"luaformatter",
	"black",
	"prettier",
	"prettierd",
	"sqlfmt",
	"dockerfmt",
	-- Debuggers
	"delve",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end

vim.pack.add({ gh("stevearc/conform.nvim") })
require("conform").setup({
	notify_on_error = false,
	format_on_save = {
		timeout_ms = 500,
	},
	default_format_opts = {
		lsp_format = "fallback", -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
	},
	-- You can also specify external formatters in here.
	formatters_by_ft = {
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		python = { "black" },
		lua = { "stylua" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "[F]ormat buffer" })

vim.pack.add({
	gh("nvim-neo-tree/neo-tree.nvim"),
	gh("MunifTanjim/nui.nvim"),
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle [E]xplorer" })
require("neo-tree").setup({
	window = {
		mappings = {
			["C"] = "close_all_subnodes",
		},
	},
})

vim.pack.add({ { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") } })
require("luasnip").setup({})
vim.pack.add({ gh("rafamadriz/friendly-snippets") })
require("luasnip.loaders.from_vscode").lazy_load()

vim.pack.add({ { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") } })
require("blink.cmp").setup({
	keymap = {
		preset = "default",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	snippets = { preset = "luasnip" },
	fuzzy = { implementation = "lua" },
	signature = { enabled = true },
})

vim.pack.add({ { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" } })
local function treesitter_try_attach(buf, language)
	-- Check if a parser exists and load it
	if not vim.treesitter.language.add(language) then
		return
	end
	-- Enable syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)

	-- Enable treesitter based folds
	-- For more info on folds see `:help folds`
	-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	-- vim.wo.foldmethod = 'expr'

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

	-- Enable treesitter based indentation
	if has_indent_query then
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

local available_parsers = require("nvim-treesitter").get_available()
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then
			return
		end

		local installed_parsers = require("nvim-treesitter").get_installed("parsers")

		if vim.tbl_contains(installed_parsers, language) then
			-- Enable the parser if it is already installed
			treesitter_try_attach(buf, language)
		elseif vim.tbl_contains(available_parsers, language) then
			-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
			require("nvim-treesitter").install(language):await(function()
				treesitter_try_attach(buf, language)
			end)
		else
			-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
			treesitter_try_attach(buf, language)
		end
	end,
})

vim.pack.add({ gh("kosayoda/nvim-lightbulb") })
require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
})

vim.pack.add({
	gh("mfussenegger/nvim-dap"),
	gh("rcarriga/nvim-dap-ui"),
	gh("nvim-neotest/nvim-nio"),
	gh("jay-babu/mason-nvim-dap.nvim"),
	gh("leoluz/nvim-dap-go"),
})

-- Basic debugging keymaps, feel free to change to your liking!
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F1>", function()
	require("dap").step_into()
end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F2>", function()
	require("dap").step_over()
end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F3>", function()
	require("dap").step_out()
end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Breakpoint" })
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set("n", "<F7>", function()
	require("dapui").toggle()
end, { desc = "Debug: See last session result." })

local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup({
	-- Makes a best effort to setup the various debuggers with
	-- reasonable debug configurations
	automatic_installation = true,

	-- You can provide additional configuration to the handlers,
	-- see mason-nvim-dap README for more information
	handlers = {},

	-- You'll need to check that you have the required things installed
	-- online, please don't ask me how to install them :)
	ensure_installed = {
		-- Update this to ensure that you have the debuggers for the langs you want
		"delve",
	},
})

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
---@diagnostic disable-next-line: missing-fields
dapui.setup({
	-- Set icons to characters that are more likely to work in every terminal.
	--    Feel free to remove or use ones that you like more! :)
	--    Don't feel like these are good choices.
	icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
	---@diagnostic disable-next-line: missing-fields
	controls = {
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "⏎",
			step_over = "⏭",
			step_out = "⏮",
			step_back = "b",
			run_last = "▶▶",
			terminate = "⏹",
			disconnect = "⏏",
		},
	},
})

-- Change breakpoint icons
-- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
-- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
-- local breakpoint_icons = vim.g.have_nerd_font
--     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
--   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
-- for type, icon in pairs(breakpoint_icons) do
--   local tp = 'Dap' .. type
--   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
--   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
-- end

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Install golang specific config
require("dap-go").setup({
	delve = {
		-- On Windows delve must be run attached or it crashes.
		-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
		detached = vim.fn.has("win32") == 0,
	},
})

-- Adds git related signs to the gutter, as well as utilities for managing changes
vim.pack.add({ gh("lewis6991/gitsigns.nvim") })

-- Git Review with Quickfix commits navigation & Comments buffer
_G.git_review = {
	state = {
		active = false,
		target = nil,
		base = nil,
		review_tab = nil,
		comments_buf = nil,
		comments_win = nil,
		qf_win = nil,
	},
}

function _G.git_review.get_current_branch()
	local handle = io.popen("git symbolic-ref --short HEAD 2>/dev/null")
	local branch = handle and handle:read("*l")
	if handle then
		handle:close()
	end
	if branch and branch ~= "" then
		return branch
	end
	local h2 = io.popen("git rev-parse --short HEAD 2>/dev/null")
	local sha = h2 and h2:read("*l")
	if h2 then
		h2:close()
	end
	return sha or "HEAD"
end

function _G.git_review.get_or_create_comments_buf(target, base)
	if _G.git_review.state.comments_buf and vim.api.nvim_buf_is_valid(_G.git_review.state.comments_buf) then
		return _G.git_review.state.comments_buf
	end
	local buf = vim.api.nvim_create_buf(true, false)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].bufhidden = "hide"
	vim.bo[buf].swapfile = false
	pcall(vim.api.nvim_buf_set_name, buf, "review_comments.md")
	local lines = {
		"# Code Review: " .. (target or "Current Branch") .. " against " .. (base or "Picked Branch"),
		"- **Current Branch**: " .. (target or "HEAD"),
		"- **Base (Picked)**: " .. (base or "origin/main"),
		"- **Date**: " .. os.date("%Y-%m-%d %H:%M"),
		"",
		"## Comments & Notes",
		"",
	}
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	_G.git_review.state.comments_buf = buf
	return buf
end

function _G.git_review.update_diff(rev, item_index)
	local old_tab = _G.git_review.state.review_tab
	local gs = require("gitsigns")
	gs.diff(rev, nil, nil, function(err)
		if err then
			vim.notify("GitReview diff error: " .. tostring(err), vim.log.levels.WARN)
			return
		end
		local new_tab = vim.api.nvim_get_current_tabpage()
		_G.git_review.state.review_tab = new_tab

		if old_tab and old_tab ~= new_tab and vim.api.nvim_tabpage_is_valid(old_tab) then
			pcall(function()
				vim.api.nvim_set_current_tabpage(old_tab)
				vim.cmd("tabclose")
				vim.api.nvim_set_current_tabpage(new_tab)
			end)
		end

		vim.cmd("botright copen 5")
		_G.git_review.state.qf_win = vim.api.nvim_get_current_win()
		if item_index then
			pcall(vim.api.nvim_win_set_cursor, _G.git_review.state.qf_win, { item_index, 0 })
		end

		local cbuf = _G.git_review.get_or_create_comments_buf(_G.git_review.state.target, _G.git_review.state.base)
		local found_win = nil
		for _, w in ipairs(vim.api.nvim_tabpage_list_wins(new_tab)) do
			if vim.api.nvim_win_get_buf(w) == cbuf then
				found_win = w
				break
			end
		end
		if not found_win then
			vim.cmd("botright 42vsplit")
			found_win = vim.api.nvim_get_current_win()
			vim.api.nvim_win_set_buf(found_win, cbuf)
			vim.wo[found_win].wrap = true
			vim.wo[found_win].number = false
			vim.wo[found_win].relativenumber = false
		end
		_G.git_review.state.comments_win = found_win
	end)
end

function _G.git_review.start(picked_branch)
	if not picked_branch or picked_branch == "" then
		_G.git_review.pick_branch()
		return
	end
	local current_branch = _G.git_review.get_current_branch()
	local base = picked_branch
	local target = current_branch

	_G.git_review.state.active = true
	_G.git_review.state.target = target
	_G.git_review.state.base = base

	-- Commits on current branch against the picked branch (base..target)
	local cmd = string.format("git log --format=%%h%%x09%%s --reverse %s..%s 2>/dev/null", base, target)
	local handle = io.popen(cmd)
	local commits = {}
	if handle then
		for line in handle:lines() do
			local hash, subject = line:match("^(%w+)%s+(.*)$")
			if hash and subject then
				table.insert(commits, { hash = hash, subject = subject })
			end
		end
		handle:close()
	end

	if #commits == 0 then
		vim.notify("GitReview: No commits found on " .. target .. " ahead of " .. base, vim.log.levels.INFO)
	end

	local qf_items = {
		{
			text = string.format("[ALL] Full diff (%s vs %s)", target, base),
			user_data = { rev = base .. "..." .. target, idx = 1 },
		},
	}

	for i, c in ipairs(commits) do
		local has_parent = os.execute("git rev-parse --verify --quiet " .. c.hash .. "~1 >/dev/null 2>&1") == 0
		local rev = has_parent and (c.hash .. "~1.." .. c.hash) or c.hash
		table.insert(qf_items, {
			text = string.format("[%s] %s", c.hash, c.subject),
			user_data = { rev = rev, commit = c.hash, idx = i + 1 },
		})
	end

	vim.fn.setqflist(qf_items, "r")
	vim.fn.setqflist({}, "a", { title = "GitReview: " .. target .. " vs " .. base })

	_G.git_review.update_diff(qf_items[1].user_data.rev, 1)
end

function _G.git_review.pick_branch()
	require("telescope.builtin").git_branches({
		attach_mappings = function(prompt_bufnr, _)
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				local branch = selection and (selection.value or selection.name or selection[1])
				if branch then
					_G.git_review.start(branch)
				end
			end)
			return true
		end,
	})
end

function _G.git_review.nav(dir)
	local info = vim.fn.getqflist({ title = 0, idx = 0, items = 0 })
	if not info.title or not info.title:match("^GitReview:") then
		if dir > 0 then
			pcall(vim.cmd.cnext)
		else
			pcall(vim.cmd.cprev)
		end
		return
	end

	local new_idx = info.idx + dir
	if new_idx < 1 or new_idx > #info.items then
		vim.notify("GitReview: Reached end of commit list", vim.log.levels.INFO)
		return
	end

	pcall(vim.cmd, "cc " .. new_idx)
	local item = info.items[new_idx]
	if item and item.user_data and item.user_data.rev then
		_G.git_review.update_diff(item.user_data.rev, new_idx)
	end
end

function _G.git_review.toggle_comments()
	local cbuf = _G.git_review.get_or_create_comments_buf(_G.git_review.state.target, _G.git_review.state.base)
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_buf(w) == cbuf then
			vim.api.nvim_win_close(w, true)
			return
		end
	end
	vim.cmd("botright 42vsplit")
	local w = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(w, cbuf)
	vim.wo[w].wrap = true
end

function _G.git_review.add_comment(line1, line2)
	local s, e
	if line1 and line2 and line1 > 0 then
		s, e = line1, line2
	else
		local mode = vim.fn.mode()
		if mode == "v" or mode == "V" or mode == "\22" then
			s = vim.fn.line("v")
			e = vim.fn.line(".")
			if s > e then
				s, e = e, s
			end
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
		else
			s = vim.fn.line(".")
			e = s
		end
	end

	local cbuf = _G.git_review.get_or_create_comments_buf(_G.git_review.state.target, _G.git_review.state.base)
	local bufname = vim.api.nvim_buf_get_name(0)
	local ft = vim.bo.filetype

	local toplevel = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or ""
	local repo_name = (toplevel ~= "") and vim.fs.basename(toplevel) or ""

	local rel_path = ""
	local gs_path = bufname:match("^gitsigns://.-:(.+)$")
	if gs_path then
		rel_path = gs_path
	elseif toplevel ~= "" and vim.startswith(bufname, toplevel .. "/") then
		rel_path = bufname:sub(#toplevel + 2)
	else
		rel_path = vim.fn.expand("%:~:.")
	end
	if rel_path == "" then
		rel_path = "General"
	end

	local loc = (s == e) and tostring(s) or string.format("%d-%d", s, e)
	local title = (repo_name ~= "" and (repo_name .. " - ") or "") .. rel_path .. ":" .. loc

	local header = string.format("\n### `%s`\n", title)
	if s ~= e and (e - s + 1) <= 12 then
		local snippet_lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
		header = header .. "```" .. (ft ~= "" and ft or "") .. "\n" .. table.concat(snippet_lines, "\n") .. "\n```\n"
	end
	header = header .. "- "

	local lines = vim.split(header, "\n")
	local cur_lines = vim.api.nvim_buf_get_lines(cbuf, 0, -1, false)
	for _, l in ipairs(lines) do
		table.insert(cur_lines, l)
	end
	vim.api.nvim_buf_set_lines(cbuf, 0, -1, false, cur_lines)

	local found_win = nil
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_buf(w) == cbuf then
			found_win = w
			break
		end
	end
	if not found_win then
		vim.cmd("botright 42vsplit")
		found_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(found_win, cbuf)
		vim.wo[found_win].wrap = true
	end
	vim.api.nvim_set_current_win(found_win)
	local count = vim.api.nvim_buf_line_count(cbuf)
	pcall(vim.api.nvim_win_set_cursor, found_win, { count, #cur_lines[count] })
	vim.cmd("startinsert!")
end

function _G.git_review.close()
	if _G.git_review.state.review_tab and vim.api.nvim_tabpage_is_valid(_G.git_review.state.review_tab) then
		pcall(function()
			vim.api.nvim_set_current_tabpage(_G.git_review.state.review_tab)
			vim.cmd("tabclose")
		end)
	end
	vim.cmd("cclose")
	_G.git_review.state.active = false
	_G.git_review.state.review_tab = nil
	vim.notify("GitReview session closed", vim.log.levels.INFO)
end

require("gitsigns").setup({
	signs = {
		add = { text = "+" }, ---@diagnostic disable-line: missing-fields
		change = { text = "~" }, ---@diagnostic disable-line: missing-fields
		delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
		topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
		changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "Jump to next git [c]hange" })

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Jump to previous git [c]hange" })

		-- Actions
		-- visual mode
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "git [s]tage hunk" })
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "git [r]eset hunk" })
		-- normal mode
		map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
		map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
		map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
		map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
		map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
		map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "git preview hunk [i]nline" })
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "git [b]lame line" })
		map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
		map("n", "<leader>hD", function()
			gitsigns.diffthis("@")
		end, { desc = "git [D]iff against last commit" })
		map({ "v", "n", "o" }, "<leader>hB", function()
			_G.git_review.pick_branch()
		end, { desc = "git review [B]ranch (qflist commits + diff + comments)" })
		map("n", "<leader>hc", function()
			_G.git_review.toggle_comments()
		end, { desc = "git review toggle [c]omments buffer" })
		map({ "n", "x" }, "<leader>hn", function()
			_G.git_review.add_comment()
		end, { desc = "git review add [n]ote for line or range" })
		map("n", "<leader>hx", function()
			_G.git_review.close()
		end, { desc = "git review close [x] session" })
		map("n", "<leader>hQ", function()
			gitsigns.setqflist("all")
		end, { desc = "git hunk [Q]uickfix list (all files in repo)" })
		map("n", "<leader>hq", gitsigns.setqflist, { desc = "git hunk [q]uickfix list (all changes in this file)" })
		-- Toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
		map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "[T]oggle git intra-line [w]ord diff" })

		-- Text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk)
	end,
})

-- Quickfix FileType autocmd for GitReview commit diff switching
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(args)
		local info = vim.fn.getqflist({ title = 0 })
		if info.title and info.title:match("^GitReview:") then
			local function qf_jump()
				local line = vim.fn.line(".")
				local items = vim.fn.getqflist({ items = 0 }).items
				local item = items[line]
				if item and item.user_data and item.user_data.rev then
					pcall(vim.cmd, "cc " .. line)
					_G.git_review.update_diff(item.user_data.rev, line)
				else
					vim.cmd.normal({ "<CR>", bang = true })
				end
			end
			vim.keymap.set("n", "<CR>", qf_jump, { buffer = args.buf, silent = true, desc = "Review commit diff" })
			vim.keymap.set("n", "o", qf_jump, { buffer = args.buf, silent = true, desc = "Review commit diff" })
		end
	end,
})

-- Global GitReview commands and keymaps
vim.api.nvim_create_user_command("GitReview", function(opts)
	if opts.args and opts.args ~= "" then
		_G.git_review.start(opts.args)
	else
		_G.git_review.pick_branch()
	end
end, { nargs = "?", desc = "Start git review for branch" })

vim.api.nvim_create_user_command("GitReviewClose", function()
	_G.git_review.close()
end, { desc = "Close git review session" })

vim.api.nvim_create_user_command("GitReviewComments", function()
	_G.git_review.toggle_comments()
end, { desc = "Toggle git review comments buffer" })

vim.api.nvim_create_user_command("GitReviewComment", function(opts)
	_G.git_review.add_comment(opts.line1, opts.line2)
end, { range = true, desc = "Add review comment for current line or range" })

vim.keymap.set("n", "<leader>hB", function()
	_G.git_review.pick_branch()
end, { desc = "git review [B]ranch (qflist commits + diff + comments)" })
vim.keymap.set("n", "<leader>hc", function()
	_G.git_review.toggle_comments()
end, { desc = "git review toggle [c]omments buffer" })
vim.keymap.set({ "n", "x" }, "<leader>hn", function()
	_G.git_review.add_comment()
end, { desc = "git review add [n]ote for line or range" })
vim.keymap.set("n", "<leader>hx", function()
	_G.git_review.close()
end, { desc = "git review close [x] session" })

-- Which-key
vim.pack.add({ gh("folke/which-key.nvim") })
require("which-key").setup()

-- Fugitive
vim.pack.add({ gh("tpope/vim-fugitive") })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
