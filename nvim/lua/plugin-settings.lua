
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
            "--config-path "
              .. os.getenv("XDG_CONFIG_HOME")
              .. "/stylua/stylua.toml",
            "-",
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
