
-- Commenting
vim.g['NERDCreateDefaultMappings'] = 1
vim.g['NERDSpaceDelims'] = 1
vim.g['NERDCompactSexyComs'] = 1
vim.g['NERDDefaultAlign'] = 'left'
vim.g['NERDCommentEmptyLines'] = 1
vim.g['NERDTrimTrailingWhitespace'] = 1
vim.g['NERDToggleCheckAllLines'] = 1


require('formatter').setup({
  filetype = {
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
          stdin = true
        }
      end
    },
    typescript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
          stdin = true
        }
      end
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout", "--edition=2021"},
          stdin = true
        }
      end
    },
    json = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote"},
          stdin = true
        }
      end
    },
    sh = {
        -- Shell Script Formatter
       function()
         return {
           exe = "shfmt",
           args = { "-i", 2 },
           stdin = true,
         }
       end,
   },
   lua = {
      function()
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories"
          },
          stdin = true,
        }
      end,
    },
    terraform = {
      function()
        return {
          exe = "terraform",
          args = { "fmt", "-" },
          stdin = true
        }
      end
    },
    -- Configuration for gofmt
    go = {
      function()
        return {
          exe = "gofmt",
          stdin = true
        }
      end
    },
    python = {
      function()
        return {
          exe = "python3 -m autopep8",
          args = {
            "--in-place --aggressive --aggressive",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
          },
          stdin = false
        }
      end
    },
    prisma = {
      function()
        return {
          exe = "prisma-fmt",
          args = {"format", "-i", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
          stdin = true
        }
      end
    },
    yaml = {
      function()
        return {
          exe = "yamlfmt",
          args = {"-w", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
          stdin = true
        }
      end
    }
  }
})

require "nvim-treesitter.configs".setup {
  incremental_selection = {
    enable = enable,
    keymaps = {
      -- mappings for incremental selection (visual mappings)
      init_selection = "gnn", -- maps in normal mode to init the node/scope selection
      node_incremental = "grn", -- increment to the upper named parent
      scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "grm" -- decrement to the previous node
    }
  },

  textobjects = {
    -- syntax-aware textobjects
    enable = enable,
    lsp_interop = {
      enable = enable,
      peek_definition_code = {
        ["DF"] = "@function.outer",
        ["DF"] = "@class.outer"
      }
    },
    keymaps = {
      ["iL"] = {
        -- you can define your own textobjects directly here
        go = "(function_definition) @function",
      },
      -- or you use the queries from supported languages with textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["aC"] = "@class.outer",
      ["iC"] = "@class.inner",
      ["ac"] = "@conditional.outer",
      ["ic"] = "@conditional.inner",
      ["ae"] = "@block.outer",
      ["ie"] = "@block.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["is"] = "@statement.inner",
      ["as"] = "@statement.outer",
      ["ad"] = "@comment.outer",
      ["am"] = "@call.outer",
      ["im"] = "@call.inner"
    },
    move = {
      enable = enable,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer"
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer"
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer"
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer"
      }
    },
    select = {
      enable = enable,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
          go = "(method_declaration) @function"
        }
      }
    },
    swap = {
      enable = enable,
      swap_next = {
        ["<leader>a"] = "@parameter.inner"
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner"
      }
    }
  }
}
