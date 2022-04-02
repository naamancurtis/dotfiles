# External plugins (initialized after)

plugins=(
    git 
    zsh 
    cargo 
    zsh-completions 
    rust 
    zsh-autosuggestions 
    fast-syntax-highlighting 
    macos 
    ripgrep 
    tmux
    brew
)
autoload -U compinit && compinit
