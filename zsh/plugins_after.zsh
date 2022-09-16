# External plugins (initialized after)

plugins=(
    vi-mode
    git
    zsh
    zsh-completions
    rust
    direnv
    docker
    nvm
    fd
    macos
    ripgrep
    brew
    zsh-autosuggestions
    fast-syntax-highlighting
)
autoload -U compinit && compinit
