require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers({
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
})
