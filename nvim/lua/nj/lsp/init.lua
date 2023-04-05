-- Taken from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/init.lua

local neodev = vim.F.npcall(require, "neodev")
if neodev then
  neodev.setup {
    override = function(_, library)
      library.enabled = true
      library.plugins = true
    end,
  }
end

local utils = require "nj.utils"

local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
  return
end

local autocmd_clear = vim.api.nvim_clear_autocmds

local semantic = vim.F.npcall(require, "nvim-semantic-tokens")

local is_mac = vim.fn.has "macunix" == 1

local telescope_mapper = require "nj.telescope.mappings"
local handlers = require "nj.lsp.handlers"

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })
local augroup_semantic = vim.api.nvim_create_augroup("custom-lsp-semantic", { clear = true })

local autocmd_format = function(async, filter)
  vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format { async = async, filter = filter }
    end,
  })
end

local filetype_attach = setmetatable({
  ocaml = function()
    autocmd_format(false)

    -- Display type information
    autocmd_clear { group = augroup_codelens, buffer = 0 }
    utils.autocmd {
      { "BufEnter", "BufWritePost", "CursorHold" },
      augroup_codelens,
      require("nj.lsp.codelens").refresh_virtlines,
      0,
    }

    vim.keymap.set(
      "n",
      "<space>tt",
      require("nj.lsp.codelens").toggle_virtlines,
      { silent = true, desc = "[T]oggle [T]ypes", buffer = 0 }
    )
  end,
  ruby = function()
    autocmd_format(false)
  end,
  go = function()
    autocmd_format(false)
  end,
  scss = function()
    autocmd_format(false)
  end,
  css = function()
    autocmd_format(false)
  end,
  rust = function()
    telescope_mapper("<space>wf", "lsp_workspace_symbols", {
      ignore_filename = true,
      query = "#",
    }, true, "LSP Workspace Symbols")

    autocmd_format(false)
  end,
  racket = function()
    autocmd_format(false)
  end,
  typescript = function()
    autocmd_format(false, function(client)
      return client.name ~= "tsserver"
    end)
  end,
  javascript = function()
    autocmd_format(false, function(client)
      return client.name ~= "tsserver"
    end)
  end,
  python = function()
    autocmd_format(false)
  end,
}, {
  __index = function()
    return function() end
  end,
})

local buf_nnoremap = function(opts, desc)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  utils.nmap(opts, desc)
end

local buf_inoremap = function(opts, desc)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  utils.imap(opts, desc)
end

local custom_attach = function(client, bufnr)
  if client.name == "copilot" then
    return
  end

  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  buf_inoremap({ "<c-s>", vim.lsp.buf.signature_help }, " LSP Signature Help")

  buf_nnoremap({ "<space>cr", vim.lsp.buf.rename }, " [c]ode [r]ename")
  buf_nnoremap({ "<space>ca", vim.lsp.buf.code_action }, " [c]ode [a]ction")

  buf_nnoremap({ "gd", vim.lsp.buf.definition }, " [g]o to [d]efinition")
  buf_nnoremap({ "gD", vim.lsp.buf.declaration }, " [g]o to [D]eclaration")
  buf_nnoremap({ "gT", vim.lsp.buf.type_definition }, " [g]o to [T]ype definition")
  buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }

  buf_nnoremap({ "<space>gI", handlers.implementation }, "[g]o to [I]mplementation")
  buf_nnoremap({ "<space>lr", "<cmd>lua R('nj.lsp.codelens').run()<CR>" }, "󰋛 CodeLens run")
  buf_nnoremap({ "<space>rr", "LspRestart" }, " LSP [r][r]estart")

  telescope_mapper("gr", "lsp_references", nil, true, " [g]o to [r]eferences")
  telescope_mapper("gI", "lsp_implementations", nil, true, " [g]o to [I]mplementation")
  telescope_mapper(
    "<space>wd",
    "lsp_document_symbols",
    { ignore_filename = true },
    true,
    " [w]orkspace to [d]ocuments"
  )
  telescope_mapper(
    "<space>ww",
    "lsp_dynamic_workspace_symbols",
    { ignore_filename = true },
    true,
    " [w][w]orkspace symbols"
  )

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    autocmd_clear { group = augroup_highlight, buffer = bufnr }
    utils.autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, bufnr }
    utils.autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, bufnr }
  end

  if false and client.server_capabilities.codeLensProvider then
    if filetype ~= "elm" then
      autocmd_clear { group = augroup_codelens, buffer = bufnr }
      utils.autocmd { "BufEnter", augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true }
      utils.autocmd { { "BufWritePost", "CursorHold" }, augroup_codelens, vim.lsp.codelens.refresh, bufnr }
    end
  end

  local caps = client.server_capabilities
  if semantic and caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    autocmd_clear { group = augroup_semantic, buffer = bufnr }
    utils.autocmd { "TextChanged", augroup_semantic, vim.lsp.buf.semantic_tokens_full, bufnr }
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype]()
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()

-- Completion configuration
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

-- Semantic token configuration
if semantic then
  semantic.setup {
    preset = "default",
    highlighters = { require "nvim-semantic-tokens.table-highlighter" },
  }

  semantic.extend_capabilities(updated_capabilities)
end

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local rust_analyzer = nil
local has_rt, rt = pcall(require, "rust-tools")
local rust_analyzer_opts = {
  updates = {
    channel = "stable",
  },
  notifications = {
    cargoTomlNotFound = false,
  },
  assist = {
    importGroup = true,
    importMergeBehaviour = "module",
    importPrefix = "crate",
  },
  callInfo = {
    full = true,
  },
  cargo = {
    features = "all",
    allFeatures = true,
    autoreload = true,
    loadOutDirsFromCheck = true,
  },
  checkOnSave = {
    command = "clippy",
    allFeatures = true,
    allTargets = true,
  },
  rustFmt = {
    extraArgs = { "+nightly" },
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
  imports = {
    granularity = {
      enforce = true,
    },
  },
}

if has_rt then
  local extension_path = vim.fn.expand "~/.vscode/extensions/sadge-vscode/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

  rt.setup {
    server = {
      capabilities = updated_capabilities,
      on_attach = function(c, b)
        -- inlays.set_all()
        buf_nnoremap({ "<space>k", ":RustMoveItemUp<CR>" }, "Move rust block up")
        buf_nnoremap({ "<space>j", ":RustMoveItemDown<CR>" }, "Move rust block down")
        custom_attach(c, b)
      end,
      -- on_attach = custom_attach,
      settings = rust_analyzer_opts,
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    tools = {
      -- on_initialized = function()
      --   inlays.set_all()
      -- end,
      autoSetHints = true,
      -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
      reload_workspace_from_cargo_toml = true,
      -- how to execute terminal commands
      -- options right now: termopen / quickfix
      executor = require("rust-tools/executors").termopen,
      runnables = {
        -- whether to use telescope for selection menu or not
        use_telescope = true,
        -- rest of the opts are forwarded to telescope
      },
      debuggables = {
        -- whether to use telescope for selection menu or not
        use_telescope = true,
        -- rest of the opts are forwarded to telescope
      },
      -- These apply to the default RustSetInlayHints command
      inlay_hints = {
        auto = true,
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
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        },
        -- whether the hover action window gets automatically focused
        auto_focus = false,
      },
    },
  }
else
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = rust_analyzer_opts,
    },
  }
end

local servers = {
  -- Also uses `shellcheck` and `explainshell`
  bashls = true,
  -- eslint = false,
  -- gdscript = false,
  -- graphql = true,
  -- html = false,
  pyright = true,
  vimls = true,
  yamlls = true,
  rust_analyzer = rust_analyzer,
  -- ocamllsp = false,

  -- cmake = (1 == vim.fn.executable "cmake-language-server"),
  -- dartls = pcall(require, "flutter-tools"),
  -- clangd = {
  --   cmd = {
  --     "clangd",
  --     "--background-index",
  --     "--suggest-missing-includes",
  --     "--clang-tidy",
  --     "--header-insertion=iwyu",
  --   },
  --   init_options = {
  --     clangdFileStatus = true,
  --   },
  -- },
  -- svelte = true,
  -- gopls = {
  -- root_dir = function(fname)
  --   local Path = require "plenary.path"
  --
  --   local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
  --   local absolute_fname = Path:new(fname):absolute()
  --
  --   if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
  --     return absolute_cwd
  --   end
  --
  --   return lspconfig_util.root_pattern("go.mod", ".git")(fname)
  -- end,

  --   settings = {
  --     gopls = {
  --       codelenses = { test = true },
  --       hints = inlays and {
  --             assignVariableTypes = true,
  --             compositeLiteralFields = true,
  --             compositeLiteralTypes = true,
  --             constantValues = true,
  --             functionTypeParameters = true,
  --             parameterNames = true,
  --             rangeVariableTypes = true,
  --           } or nil,
  --     },
  --   },
  --   flags = {
  --     debounce_text_changes = 200,
  --   },
  -- },
  -- omnisharp = {
  --   cmd = { vim.fn.expand "~/build/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  -- },
  -- racket_langserver = true,
  -- elmls = true,
  -- cssls = true,
  -- perlnavigator = true,
  -- tsserver = {
  --   init_options = ts_util.init_options,
  --   cmd = { "typescript-language-server", "--stdio" },
  --   filetypes = {
  --     "javascript",
  --     "javascriptreact",
  --     "javascript.jsx",
  --     "typescript",
  --     "typescriptreact",
  --     "typescript.tsx",
  --   },
  --   on_attach = function(client)
  --     custom_attach(client)
  --
  --     ts_util.setup { auto_inlay_hints = false }
  --     ts_util.setup_client(client)
  --   end,
  -- },
}

-- Can remove later if not installed (TODO: enable for not linux)
if vim.fn.executable "tree-sitter-grammar-lsp-linux" == 1 then
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = { "grammar.js", "*/corpus/*.txt" },
    callback = function()
      vim.lsp.start {
        name = "tree-sitter-grammar-lsp",
        cmd = { "tree-sitter-grammar-lsp-linux" },
        root_dir = "/",
        capabilities = updated_capabilities,
        on_attach = custom_attach,
      }
    end,
  })
end

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls" },
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

if is_mac then
  setup_server("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            -- vim
            "vim",

            -- Busted
            "describe",
            "it",
            "before_each",
            "after_each",
            "teardown",
            "pending",
            "clear",

            -- Colorbuddy
            "Color",
            "c",
            "Group",
            "g",
            "s",

            -- Custom
            "RELOAD",
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  })
else
  require("lspconfig").lua_ls.setup {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    settings = {
      Lua = { workspace = { checkThirdParty = false }, semantic = { enable = false } },
    },
  }
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

--[ An example of using functions...
-- 0. nil -> do default (could be enabled or disabled)
-- 1. false -> disable it
-- 2. true -> enable, use defaults
-- 3. table -> enable, with (some) overrides
-- 4. function -> can return any of above
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, method, params, client_id, bufnr, config)
--   local uri = params.uri
--
--   vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--       underline = true,
--       virtual_text = true,
--       signs = sign_decider,
--       update_in_insert = false,
--     }
--   )(err, method, params, client_id, bufnr, config)
--
--   bufnr = bufnr or vim.uri_to_bufnr(uri)
--
--   if bufnr == vim.api.nvim_get_current_buf() then
--     vim.lsp.diagnostic.set_loclist { open_loclist = false }
--   end
-- end
--]]

require("null-ls").setup {
  sources = {
    -- require("null-ls").builtins.formatting.stylua,
    -- require("null-ls").builtins.diagnostics.eslint,
    -- require("null-ls").builtins.completion.spell,
    -- require("null-ls").builtins.diagnostics.selene,
    require("null-ls").builtins.formatting.prettierd,
    require("null-ls").builtins.formatting.isort,
    require("null-ls").builtins.formatting.black,
  },
}

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}
