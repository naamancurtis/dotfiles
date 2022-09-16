local srv_settings = {
    ['rust-analyzer'] = {
        updates = { channel = 'stable' },
        notifications = { cargoTomlNotFound = false },
        assist = {
            importGroup = true,
            importMergeBehaviour = 'module',
            importPrefix = 'by_crate',
        },
        callInfo = {
            full = true,
        },
        cargo = {
            allFeatures = true,
            autoreload = true,
            loadOutDirsFromCheck = true,
        },
        checkOnSave = {
            command = 'clippy',
            allFeatures = true,
            allTargets = true,
        },
        completion = {
            addCallArgumentSnippets = true,
            addCallParenthesis = true,
            postfix = {
                enable = true,
            },
            autoimport = {
                enable = true,
            },
        },
        diagnostics = {
            enable = true,
            enableExperimental = true,
        },
        hoverActions = {
            enable = true,
            debug = true,
            gotoTypeDef = true,
            implementations = true,
            run = true,
            linksInHover = true,
        },
        inlayHints = {
            chainingHints = true,
            parameterHints = true,
            typeHints = true,
        },
        lens = {
            enable = true,
            debug = true,
            implementations = true,
            run = true,
            methodReferences = true,
            references = true,
        },
        procMacro = {
            enable = true,
        },
    },
}


local extension_path = '~/.vscode/extensions/vadimcn.vscode-lldb-1.6.10'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local M = {
    setup = function(on_attach, capabilities)
        local rust_opts = {
            tools = {
                -- rust-tools options
                -- Automatically set inlay hints (type hints)
                autoSetHints = true,

                -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
                reload_workspace_from_cargo_toml = true,

                -- how to execute terminal commands
                -- options right now: termopen / quickfix
                executor = require("rust-tools/executors").termopen,

                runnables = {
                    -- whether to use telescope for selection menu or not
                    use_telescope = true

                    -- rest of the opts are forwarded to telescope
                },

                debuggables = {
                    -- whether to use telescope for selection menu or not
                    use_telescope = true

                    -- rest of the opts are forwarded to telescope
                },

                -- These apply to the default RustSetInlayHints command
                inlay_hints = {

                    -- Only show inlay hints for the current line
                    only_current_line = false,

                    -- Event which triggers a refersh of the inlay hints.
                    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                    -- not that this may cause  higher CPU usage.
                    -- This option is only respected when only_current_line and
                    -- autoSetHints both are true.
                    only_current_line_autocmd = "CursorHold",

                    -- wheter to show parameter hints with the inlay hints or not
                    show_parameter_hints = true,

                    -- prefix for parameter hints
                    parameter_hints_prefix = "ﲕ ",

                    -- prefix for all the other hints (type, chaining)
                    other_hints_prefix = " ",

                    -- whether to align to the length of the longest line in the file
                    max_len_align = false,

                    -- padding from the left if max_len_align is true
                    max_len_align_padding = 1,

                    -- whether to align to the extreme right or not
                    right_align = false,

                    -- padding from the right if right_align is true
                    right_align_padding = 7,

                    -- The color of the hints
                    highlight = "Comment",
                },

                hover_actions = {
                    -- the border that is used for the hover window
                    -- see vim.api.nvim_open_win()
                    border = {
                        {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                        {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                        {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                        {"╰", "FloatBorder"}, {"│", "FloatBorder"}
                    },

                    -- whether the hover action window gets automatically focused
                    auto_focus = false
                },
            },
            -- lsp
            server = {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = srv_settings,
            },

            -- debugging stuff
            dap = {
                adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
            },

        }
        require('rust-tools').setup(rust_opts)
    end,
}

return M
