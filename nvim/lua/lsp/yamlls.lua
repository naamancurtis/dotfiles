local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            yaml = {
                schemas = {
                    -- Examples
                    -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
                    -- ["../path/relative/to/file.yml"] = "/.github/workflows/*"
                    -- ["/path/from/root/of/project"] = "/.github/workflows/*"
                }
            },
        },
    })
end

return M