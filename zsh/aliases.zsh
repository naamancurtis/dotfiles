# Vim
alias vim="nvim"
alias vi="nvim"

# ls aliases
alias l='exa --long --header --git --all --sort name'
alias ls='exa --header --git-ignore -F --sort name'
alias lsa='exa -a --header -F --sort name'
alias lst="exa -T --git-ignore --group-directories-first"

# Default behaviour aliases
alias md='mkdir -p'
alias cat="bat"

# Aliases to protect against overwriting
alias cp='cp -i'
alias mv='mv -i'

# git related aliases
alias gag='git exec ag'
alias gp="git pull"
alias gco="git checkout"

# Rust aliases
alias ca="cargo"

alias d="docker"
alias dc="docker-compose"
alias k="kubectl"

alias zj="zellij"

alias python="python3"

alias gcafp="git add . && git commit --amend && git push -f"
