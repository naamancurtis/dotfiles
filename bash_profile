source ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"

ulimit -n 1024

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/naaman/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

