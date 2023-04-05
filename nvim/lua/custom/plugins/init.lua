return {
  "milisims/nvim-luaref",
  "tpope/vim-sleuth",
  "godlygeek/tabular", -- Quickly align text by pattern
  "tpope/vim-repeat", -- Repeat actions better
  "tpope/vim-abolish", -- Cool things with words!
  -- Helps working with the quickfix menu
  -- https://github.com/romainl/vim-qf
  "romainl/vim-qf",
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      operators = {
        gc = "Comments",
        cs = "Change surroundings cs{target}{replacement}",
        ds = "Delete surroundings ds{char}",
        yss = "Wrap line with surroundings ys{motion}{char}",
      },
    },
  },
  "monaqa/dial.nvim", -- Number/date incrementing/decrementing
  "nvim-lua/plenary.nvim",
  "tjdevries/colorbuddy.nvim",
  "tjdevries/complextras.nvim",
  "tjdevries/express_line.nvim",

  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup {
        setopt = true,
      }
    end,
  },

  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
}
