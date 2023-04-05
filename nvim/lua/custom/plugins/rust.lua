return {
  { 'simrat39/rust-tools.nvim' },
  {
    "Saecki/crates.nvim",
    config = function()
      require("crates").setup()
    end,
  },
}
