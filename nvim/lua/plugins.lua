local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- use "projekt0n/github-nvim-theme"
  use 'navarasu/onedark.nvim'
  use 'onsails/lspkind-nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-treesitter/nvim-treesitter'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'

  -- Rust
  use 'simrat39/rust-tools.nvim'
  use 'mfussenegger/nvim-dap'

  -- Typescript
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  use 'hrsh7th/vim-vsnip'

  use 'kyazdani42/nvim-web-devicons'

  -- Editor
  use 'machakann/vim-sandwich'
  --use 'christoomey/vim-system-copy'
  use 'christoomey/vim-tmux-navigator'

  -- Code support
  use 'preservim/nerdcommenter'
  use 'jiangmiao/auto-pairs'
  use 'mhartington/formatter.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
