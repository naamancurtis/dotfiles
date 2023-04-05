-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

require "nj.globals"

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn
      .system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
        lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--  as they will be available in your neovim runtime.

require('lazy').setup('custom.plugins', {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌"
    }
  },
  git = {
    url_format = "ssh://git@github.com/%s.git"
  }
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.o.relativenumber = true

-- Decrease update time
vim.o.updatetime = 2508
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.splitright = true -- Prefer windows splitting to the right
vim.o.splitbelow = true -- Prefer windows splitting to the bottom

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {
  silent = true
})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true
})

vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true
})

-- Jump to previous buffer
vim.keymap.set('n', '<Space><Space>', '<C-^>', {
  silent = true,
  desc = "jump to previous buffer"
})

-- Arrow keys to resize windows
vim.keymap.set('n', '<up>', '10<C-W>+', {
  silent = true
})
vim.keymap.set('n', '<down>', '10<C-W>-', {
  silent = true
})
vim.keymap.set('n', '<left>', '3<C-W><', {
  silent = true
})
vim.keymap.set('n', '<right>', '3<C-W>>', {
  silent = true
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
  clear = true
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*'
})


-- -- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, {
--   desc = '[?] Find recently opened files'
-- })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, {
--   desc = '[ ] Find existing buffers'
-- })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false
--   })
-- end, {
--   desc = '[/] Fuzzily search in current buffer'
-- })

-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {
--   desc = '[S]earch [F]iles'
-- })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {
--   desc = '[S]earch [H]elp'
-- })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, {
--   desc = '[S]earch current [W]ord'
-- })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {
--   desc = '[S]earch by [G]rep'
-- })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {
--   desc = '[S]earch [D]iagnostics'
-- })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- require('nvim-treesitter.configs').setup {
--   -- Add languages to be installed here that you want installed for treesitter
--   ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vim', 'json', 'yaml', 'toml' },

--   -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
--   auto_install = false,

--   highlight = {
--     enable = true
--   },
--   indent = {
--     enable = true,
--     disable = { 'python' }
--   },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = '<c-space>',
--       node_incremental = '<c-space>',
--       scope_incremental = '<c-s>',
--       node_decremental = '<M-space>'
--     }
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ['aa'] = '@parameter.outer',
--         ['ia'] = '@parameter.inner',
--         ['af'] = '@function.outer',
--         ['if'] = '@function.inner',
--         ['ac'] = '@class.outer',
--         ['ic'] = '@class.inner'
--       }
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         [']m'] = '@function.outer',
--         [']]'] = '@class.outer'
--       },
--       goto_next_end = {
--         [']M'] = '@function.outer',
--         [']['] = '@class.outer'
--       },
--       goto_previous_start = {
--         ['[m'] = '@function.outer',
--         ['[['] = '@class.outer'
--       },
--       goto_previous_end = {
--         ['[M'] = '@function.outer',
--         ['[]'] = '@class.outer'
--       }
--     },
--     swap = {
--       enable = true,
--       swap_next = {
--         ['<leader>a'] = '@parameter.inner'
--       },
--       swap_previous = {
--         ['<leader>A'] = '@parameter.inner'
--       }
--     }
--   }
-- }

-- -- vim.opt.foldmethod = 'expr'
-- -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- -- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
--   desc = "Open floating diagnostic message"
-- })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
--   desc = "Open diagnostics list"
-- })

vim.g.listchars = { tab = "", trail = " ", extends = "", precedes = "" }

-- Configure Rust Tools through nvim diagnostics api
-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({
  name = 'DiagnosticSignError',
  text = ''
})
sign({
  name = 'DiagnosticSignWarn',
  text = ''
})
sign({
  name = 'DiagnosticSignHint',
  text = ''
})
sign({
  name = 'DiagnosticSignInfo',
  text = ''
})

-- vim.diagnostic.config({
--   virtual_text = true,
--   signs = true,
--   update_in_insert = true,
--   underline = true,
--   severity_sort = false,
--   float = {
--     border = 'rounded',
--     source = 'always',
--     header = '',
--     prefix = ''
--   }
-- })

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
