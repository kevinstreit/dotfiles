if [[ -s "$HOME/.zprezto/init.zsh" ]]; then
  source "$HOME/.zprezto/init.zsh"
fi

if [[ -f ~/.zshsambamba ]]; then
  source ~/.zshsambamba
fi

ulimit -s unlimited

setopt inc_append_history
setopt share_history
setopt extendedglob
unsetopt correct_all
unsetopt nomatch

ulimit -s unlimited

bindkey '\e[3~' delete-char
bindkey -M viins '\e[3~' delete-char
bindkey -M vicmd '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char

alias now='date +'\''%F-%H%M'\'

if which fasd >/dev/null 2>&1; then
  eval "$(fasd --init auto)"

  alias o="a -e $OPEN"
  alias j='z'

  v = function() {
    FILE=$(fasd -f -b viminfo -i $@)
    if [[ -z $FILE ]]; then
      return 1
    fi

    local DIR=${FILE:h}
    local VIM_WD=$DIR
    echo "searching project root for file '$FILE'"
    while [[ $DIR != '/' ]]; do
      local PVIMRC="$DIR/.pvimrc"
      if [[ -f $PVIMRC ]]; then
        echo "Found project root '$DIR'"
        VIM_WD=$DIR
        break
      fi
      DIR=${DIR:h}
    done

    local OLD_PWD=$(pwd)
    cd $VIM_WD
    vim $FILE
    cd $OLD_PWD
  }
fi

if which tmux >/dev/null 2>&1; then
  case $- in *i*)
    if [ -z "$TMUX" ]; then exec tmux; fi
    PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")';;
  esac
fi

echo LALA $-

if [[ -n $TMUX ]]; then
  alias updateEnv="tmux show-environment | sed 's/^\([^-].*=\)\(.*\)/export \1\"\2\"/;s/^-/unset /' | source /dev/stdin"
  alias ue=updateEnv
fi

source /usr/share/doc/pkgfile/command-not-found.zsh
