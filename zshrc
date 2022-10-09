# Functions
source ~/.zsh/functions.zsh

# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

source $(brew --prefix)/opt/antigen/share/antigen/antigen.zsh

# External plugins (initialized before)
source ~/.zsh/plugins_before.zsh

# Settings
source ~/.zsh/settings.zsh

# Aliases
source ~/.zsh/aliases.zsh

# Custom prompt

if [ $TERM_PROGRAM != "Apple_Terminal" ]; then
    source ~/.zsh/oh-my-posh.zsh
else
    source ~/.zsh/prompt.zsh
fi


eval "$(direnv hook zsh)"

# External plugins (initialized after)
source ~/.zsh/plugins_after.zsh

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/naaman/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/naaman/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/naaman/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/naaman/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

