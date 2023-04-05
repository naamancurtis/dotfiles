return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nj.lsp"
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup {
        auto_update = true,
        debounce_hours = 24,
        ensure_installed = {
          "black", "isort",
        },
      }
    end,
  },

  "simrat39/inlay-hints.nvim",
  { "j-hui/fidget.nvim", opts = {} },
  "folke/neodev.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jose-elias-alvarez/nvim-lsp-ts-utils",
}
