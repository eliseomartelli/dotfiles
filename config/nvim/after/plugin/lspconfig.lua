require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
  function (server_name) -- default handler (optional)
    lspconfig[server_name].setup {}
  end,
})

lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

