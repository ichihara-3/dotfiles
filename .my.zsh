export EDITOR=vim
export PATH="${PATH}:${HOME}/go/bin"

# FZF configurations
export FZF_DEFAULT_COMMAND="find . -type d -name '.git' -prune -o -type f -name '*.pyc' -prune -o -type f -print"
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS="--height 40% --reverse --border"
export FZF_CTRL_T_OPTS="--height 40% --reverse --border --preview 'cat {}'"

alias pn='prompt -s $(prompt -l |tail -n 1 | tr " " "\n" | fzf)'
