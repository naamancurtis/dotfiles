vim.g.mapleader = ","
vim.g.python3_host_prog = vim.fn.expand('~/usr/local/bin/python3')

require('plugins')
require('maps')
require('au')
require('settings')
require('plugin-settings')
require('autocmds')
require('lsp')
