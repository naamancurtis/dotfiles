# Functions
source ~/.shell/functions.sh

# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

source $(brew --prefix)/opt/antigen/share/antigen/antigen.zsh

# External plugins (initialized before)
source ~/.zsh/plugins_before.zsh

# Settings
source ~/.zsh/settings.zsh

# Bootstrap
source ~/.shell/bootstrap.sh

# External settings
source ~/.shell/external.sh

# Aliases
source ~/.shell/aliases.sh

# Custom prompt
source ~/.zsh/prompt.zsh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# External plugins (initialized after)
source ~/.zsh/plugins_after.zsh

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi
