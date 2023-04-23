-- lspconfig.rc

require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()

local lspconfig = require("lspconfig")

-- NVIM cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup_handlers({
  function (server_name) -- default handler (optional)
    lspconfig[server_name].setup {
      capabilities = capabilities
    }
  end,
})

-- Custom configurations.
lspconfig.lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
