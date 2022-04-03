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
    brew
)
autoload -U compinit && compinit
