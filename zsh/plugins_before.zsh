# External plugins (initialized before)

antigen use oh-my-zsh

antigen bundle git
antigen bundle vi-mode
antigen bundle brew
antigen bundle direnv
antigen bundle docker
antigen bundle fd
antigen bundle nvm
antigen bundle ripgrep
antigen bundle rust
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle z

case `uname` in
  Darwin)
    # Commands for OS X go here
    antigen bundle macos
  ;;
  Linux)
    # Commands for Linux go here
  ;;
esac

antigen apply
