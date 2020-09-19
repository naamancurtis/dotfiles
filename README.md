# Dotfiles

This repo uses [Dotbot](https://github.com/anishathalye/dotbot) to manage
installations. Therefore setup is as simple as running `install` after cloning
the repo.

## Making Local Customizations

You can make local customizations for some programs by editing these files:

- vim : `~/.vimrc_local`
- zsh / bash : `~/.shell_local_before` run first
- zsh : `~/.zshrc_local_before` run before .zshrc
- zsh : `~/.zshrc_local_after` run after .zshrc
- zsh / bash : `~/.shell_local_after` run last
- git : `~/.gitconfig_local`
- tmux : `~/.tmux_local.conf`

