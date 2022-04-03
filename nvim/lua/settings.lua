local utils = require('utils')
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap
local opt = vim.opt

local function set_ui_options()
  opt.mouse = "a"
  opt.title = true
  opt.number = true
  opt.relativenumber = true
  opt.colorcolumn = "120"
end

local function set_editor_options()
  local options = {
    autoread = true,
    hidden = true,
    ignorecase = true,
    inccommand = "nosplit",
    incsearch = true,
    laststatus = 2,
    list = true,
    modeline = true,
    shada = { "!", "'500", "<50", "s10", "h" },
    showcmd = true,
    showmode = false,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    startofline = false,
    textwidth = 120,
    wildignorecase = true,
    wildmenu = true,
    wildmode = "list:longest",
    updatetime = 250,
    autoindent = true,
    smartindent = true,
    shortmess = vim.o.shortmess .. "c",
    scrolloff = 12,
    completeopt = { "menu", "menuone", "noselect" },
    clipboard = "unnamedplus",
    shiftwidth = 2,
    softtabstop = 2,
    tabstop = 2,
    smarttab = true,
    swapfile = false,
    expandtab = true,
    foldmethod = "indent",
    foldlevelstart = 99,
    signcolumn = 'yes',
    undodir = '~/.vimdid'
  }
  for k, v in pairs(options) do
    opt[k] = v
  end
end


vim.g.listchars = { tab = "", trail = " ", extends = "", precedes = "" }

set_editor_options()
set_ui_options()

local onedark = require('onedark')
onedark.setup  {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    -- toggle theme style ---
    -- toggle_style_key = '<leader>ts', -- Default keybinding to toggle
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

onedark.load()

--[[
require('github-theme').setup({
 theme_style = "dark",
  function_style = "italic",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = {hint = "orange", error = "#ff0000"},

  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
      DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
      -- this will remove the highlight groups
      TSField = {},
    }
  end
})
--]]

-- Icons

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
