# Dotfiles

This repo uses [Dotbot](https://github.com/anishathalye/dotbot) to manage installations. 

I normally develop on MacOS, so this dotfiles repo contains `Homebrew`
and uses it to install quite a lot of tools.

With the `DotBot` plugin, installing this repo is as simple as cloning it and running `./install` located in the root.

## Setup

|Thing|Technology|
|:--:|:--:|
|Terminal| `Alacritty` |
|Shell| `zsh` |
|Editor| `Neovim` |
|Terminal Multiplexing | `Tmux`|

## Making Local Customizations

You can make local customizations for some programs by editing these files:

- vim : `~/.vimrc_local`
- zsh : `~/.zshrc_local_before` run before .zshrc
- zsh : `~/.zshrc_local_after` run after .zshrc
- git : `~/.gitconfig_local`
- tmux : `~/.tmux_local.conf`

These files should be automatically created after running the `./install`
script.
