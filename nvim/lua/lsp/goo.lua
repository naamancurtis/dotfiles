local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('go').setup{
  lsp_cfg = {
    capabilities = capabilities,
  },
  on_attach = on_attach
}
