local utils = require('utils')
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap

-- Default VIM
nnoremap('<leader>hh', ':noh<cr>')
nnoremap('<space><space>', '<C-^>')


-- Telescope

nnoremap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
nnoremap('<leader>s', '<cmd> lua require("telescope.builtin").live_grep()<cr>')
nnoremap('<leader>;', '<cmd> lua require("telescope.builtin").buffers()<cr>')
nnoremap('<leader>ch', '<cmd> lua require("telescope.builtin").command_history()<cr>')
nnoremap('<leader>qf', '<cmd> lua require("telescope.builtin").quickfix()<cr>')
nnoremap('<leader>km', '<cmd> lua require("telescope.builtin").keymaps()<cr>')

nnoremap('<leader>gr', '<cmd> lua require("telescope.builtin").lsp_references()<cr>')
nnoremap('<leader>di', '<cmd> lua require("telescope.builtin").diagnostics()<cr>')
nnoremap('<leader>ts', '<cmd> lua require("telescope.builtin").treesitter()<cr>')

nnoremap('<up>', '10<C-W>+')
nnoremap('<down>', '10<C-W>-')
nnoremap('<left>', '3<C-W>>')
nnoremap('<right>', '3<C-W><')

-- Text Editting

nnoremap('<space>c<space>', ':call nerdcommenter#Comment(0, \'toggle\')<cr>')
vnoremap('<space>c<space>', ':call nerdcommenter#Comment(0, \'toggle\')<cr>')

-- Rust
nnoremap('<leader>rr', '<cmd> lua require("rust-tools.runnables").runnables()<cr>')

-- Copy
nnoremap('<space>cp', '"+y')
vnoremap('<space>cp', '"+y')

-- Paste
nnoremap('<space>cv', '"+p')
nnoremap('<space>cV', '"+P')
vnoremap('<space>cv', '"+p')
vnoremap('<space>cV', '"+p')
