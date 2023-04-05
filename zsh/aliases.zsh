# Vim
alias vim="nvim"
alias vi="nvim"

# ls aliases
alias l='exa --long --header --git --group-directories-first --all --sort name --icons --no-user'
alias ls='exa --header --git-ignore -F --group-directories-first --icons'
alias lsa='exa -a --header -F --group-directories-first --icons'
alias lst="exa -T --git-ignore --group-directories-first --icons"

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

alias gcafp="git add . && git commit -S --amend && git push -f"
