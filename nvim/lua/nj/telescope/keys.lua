local sorters = require "telescope.sorters"

local map_tele = require "nj.telescope.mappings"

-- Dotfiles
map_tele("<leader>ed", "edit_dotfiles", "edit dotfiles")
map_tele("<space><space>d", "diagnostics", "search diagnostics")

map_tele("<leader>f/", "grep_last_search", "grep last search", {
  layout_strategy = "vertical",
}, "Grep last search")

-- Files
map_tele("<leader>gf", "git_files", "[g]it [f]iles")
map_tele("<leader>rg", "live_grep_file", "[r]ip[g]rep current file")
map_tele("<leader>rgp", "live_grep", "[r]ip[g]rep [p]roject")
map_tele("<leader>of", "oldfiles", "[o]ld f]iles")
map_tele("<leader>sf", "find_files", "[s]earch [f]iles")
map_tele("<leader>fs", "fs", "folds")
map_tele("<leader>pp", "project_search", "project search")
map_tele("<leader>fe", "file_browser", "file browser")
map_tele("<leader>fz", "search_only_certain_files", "search certain files")

-- Git
map_tele("<leader>gs", "git_status", "git status")
map_tele("<leader>gc", "git_commits", "git commits")

-- Nvim
map_tele("<leader>bf", "buffers", "open [b]uffer [f]iles")
map_tele("<leader>fp", "my_plugins", "my plugins")
map_tele("<leader>ip", "installed_plugins", "[i]nstalled [p]lugins")
map_tele("<leader>sa", "search_all_files", "[s]earch [a]ll files")
map_tele("<leader>ff", "curbuf", "[f]uzzy [f]ind current buffer")
map_tele("<leader>ht", "help_tags", "[h]elp [t]ags")
map_tele("<leader>vo", "vim_options", "[v]im [o]ptions")
map_tele("<leader>gp", "grep_prompt", "[g]rep [p]rompt")
map_tele("<leader>wt", "treesitter", "tree sitter")

-- Telescope Meta
map_tele("<leader>tb", "builtin", "[t]elescope [b]uiltins")

vim.api.nvim_set_keymap("n", "<leader>cp", ":Telescope neoclip<CR>", { silent = true, desc = "open yanked history" })
vim.api.nvim_set_keymap("i", "<leader>cp", ":Telescope neoclip<CR>", { silent = true, desc = "open yanked history" })
