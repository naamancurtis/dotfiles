# Initialize completion
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select=4
zmodload zsh/complist

# Initialize editing command line
autoload -U edit-command-line && zle -N edit-command-line

# Enable interactive comments (# on the command line)
setopt interactivecomments

# Nicer history
HISTSIZE=1048576
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt incappendhistory
setopt extendedhistory

# Time to wait for additional characters in a sequence
KEYTIMEOUT=1 # corresponds to 10ms

# Use incremental search
bindkey "^R" history-incremental-search-backward

# Use vim mode
bindkey -v
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
export EDITOR="vi"

bindkey -r "^J"

# Disable shell builtins
disable r

export ZSH=$HOME/.oh-my-zsh
export CARGO_TARGET_DIR="$HOME/code/.cargo"

path+='/code/exec'
path+=$BREW
path+=$HOME/.cargo/bin
path+=/usr/local/opt/llvm/bin
path+=/usr/local/bin/rust-analyzer
path+=$HOME/go/bin

export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,bg=underline"
export ZVM_VI_SURROUND_BINDKEY="s-prefix"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh"] &&  \. "/opt/homebrew/opt/nvm/nvm.sh" # loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"] &&  \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # loads nvm bash completion

export PATH
ulimit -n 1024
