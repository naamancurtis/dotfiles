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

# Disable shell builtins
disable r

export ZSH=$HOME/.oh-my-zsh
# export MONO_GAC_PREFIX="/usr/local"
export CARGO_TARGET_DIR="$HOME/code/.cargo"

path+='/code/exec'
path+=$BREW
path+=$HOME/.cargo/bin
path+=/usr/local/opt/llvm/bin
path+=/usr/local/bin/rust-analyzer
path+=$HOME/go/bin

export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export GUILE_LOAD_PATH="/usr/local/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/usr/local/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/usr/local/lib/guile/3.0/extensions"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,bg=underline"

export PATH
ulimit -n 1024
