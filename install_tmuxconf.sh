#!/bin/bash

DIR=$(cd $(dirname $0); pwd)/tmux
echo ${DIR}

if tmux -V > /dev/null 2>&1; then
  if [[ -e ~/.tmux.conf ]]; then
    echo backup: mv ~/.tmux.conf ~/.tmux.conf.bk
    mv ~/.tmux.conf ~/.tmux.conf.bk
  fi
  echo install: ln -sf ${DIR}/.tmux.conf ~/.tmux.conf
  ln -sf ${DIR}/tmux.conf ~/.tmux.conf
else
  echo tmux not exists...
fi

echo finished!
