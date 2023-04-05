# Functions
source ~/.zsh/functions.zsh

# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

IS_PERSONAL=${PERSONAL_MACHINE-false}

if [ $IS_PERSONAL = true ]; then
    # Personal
    source ~/.zsh/personal.zsh

    # External plugins (initialized before)
    source ~/.zsh/plugins_before.zsh
else
    echo "Manually sourcing vi-mode, skipping other plugins"
    source ~/.zsh/plugins/jeffreytse.zsh-vi-mode.zsh
fi

# Settings
source ~/.zsh/settings.zsh

# Aliases
source ~/.zsh/aliases.zsh

# Custom prompt
eval "$(starship init zsh)"

# Enable direnv
eval "$(direnv hook zsh)"

if [ $IS_PERSONAL = true ]; then
    # External plugins (initialized after)
    source ~/.zsh/plugins_after.zsh
fi

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
