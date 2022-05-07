local M = {}

M.setup = function(on_attach, capabilities)
  require('lspconfig').gopls.setup{
    cmd = {'gopls'},
      capabilities = capabilities,
      settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
       },
       staticcheck = true,
      },
    },
    on_attach = on_attach
  }
end

return M
