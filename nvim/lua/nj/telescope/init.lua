SHOULD_RELOAD_TELESCOPE = true
local reloader = function()
  if SHOULD_RELOAD_TELESCOPE then
    R "plenary"
    R "telescope"
    R "nj.telescope.setup"
  end
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"

local M = {}

function M.edit_dotfiles()
  require("telescope.builtin").find_files {
    cwd = "~/code/dotfiles",
    prompt = "~ dotfiles ~",
    find_command = {
      "fd",
      ".",
      "-i",
      "-t",
      "file",
      "--strip-cwd-prefix",
    },

    layout_strategy = "horizontal",
  }
end

function M.find_files()
  -- local opts = themes.get_ivy {
  --   hidden = false,
  --   sorting_strategy = "ascending",
  --   layout_config = { height = 9 },
  -- }
  require("telescope.builtin").find_files {
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    layout_config = {
      -- height = 10,
    },
  }
end

function M.fs()
  local opts = themes.get_ivy { hidden = false, sorting_strategy = "descending" }
  require("telescope.builtin").find_files(opts)
end

function M.builtin()
  require("telescope.builtin").builtin()
end

function M.git_files()
  local path = vim.fn.expand "%:h"
  if path == "" then
    path = nil
  end

  local width = 0.75

  local opts = {
    cwd = path,

    layout_config = {
      width = width,
      prompt_position = "bottom",
    },
  }

  require("telescope.builtin").git_files(opts)
end

function M.buffer_git_files()
  require("telescope.builtin").git_files(themes.get_dropdown {
    cwd = vim.fn.expand "%:p:h",
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.lsp_code_actions()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require("telescope.builtin").lsp_code_actions(opts)
end

function M.live_grep_file()
  local path = vim.fn.expand "%"
  local opts = {
    shorten_path = true,
    fzf_separator = "|>",
  }
  if path ~= "" then
    opts.search_dirs = { path }
  end
  require("telescope.builtin").live_grep(opts)
end

function M.live_grep()
  require("telescope.builtin").live_grep {
    shorten_path = true,
    fzf_separator = "|>",
  }
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = { "shorten" },
    search = vim.fn.input "Grep String > ",
  }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.path_display = { "shorten" }
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

function M.oldfiles()
  require("telescope").extensions.frecency.frecency(themes.get_ivy {})
end

function M.my_plugins()
  require("telescope.builtin").find_files {
    cwd = "~/plugins/",
  }
end

function M.installed_plugins()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath "data" .. "/lazy/",
  }
end

function M.project_search()
  require("telescope.builtin").find_files {
    cwd = require("lspconfig.util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.buffers()
  require("telescope.builtin").buffers {
    shorten_path = true,
  }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    border = true,
    previewer = false,
    shorten_path = false,
    layout_config = {
      width = 0.75,
      height = 0.5,
    },
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require("telescope.builtin").help_tags {
    show_version = true,
  }
end

function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = {
      "fd",
      ".",
      "-i",
      "-t",
      "file",
      "-H",
      "--strip-cwd-prefix",
    },
  }
end

function M.file_browser()
  local opts

  opts = {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_config = {
      prompt_position = "top",
    },

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        local finder = current_picker.finder

        finder.path = new_cwd
        finder.files = true
        current_picker:refresh(false, { reset_prompt = true })
      end

      map("i", "-", function()
        modify_cwd(current_picker.cwd .. "/..")
      end)

      map("i", "~", function()
        modify_cwd(vim.fn.expand "~")
      end)

      -- local modify_depth = function(mod)
      --   return function()
      --     opts.depth = opts.depth + mod
      --
      --     current_picker:refresh(false, { reset_prompt = true })
      --   end
      -- end
      --
      -- map("i", "<M-=>", modify_depth(1))
      -- map("i", "<M-+>", modify_depth(-1))

      map("n", "yy", function()
        local entry = action_state.get_selected_entry()
        vim.fn.setreg("+", entry.value)
      end)

      return true
    end,
  }

  require("telescope").extensions.file_browser.file_browser(opts)
end

function M.git_status()
  local opts = themes.get_dropdown {
    border = true,
    previewer = false,
    shorten_path = false,
  }

  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  require("telescope.builtin").git_status(opts)
end

function M.git_commits()
  require("telescope.builtin").git_commits {
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.lsp_references()
  require("telescope.builtin").lsp_references {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
end

function M.lsp_implementations()
  require("telescope.builtin").lsp_implementations {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
end

function M.vim_options()
  require("telescope.builtin").vim_options {
    layout_config = {
      width = 0.5,
    },
    sorting_strategy = "ascending",
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    local has_custom, custom = pcall(require, string.format("nj.telescope.custom.%s", k))

    if M[k] then
      return M[k]
    elseif has_custom then
      return custom
    else
      return require("telescope.builtin")[k]
    end
  end,
})
