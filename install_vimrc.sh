#!/bin/bash
DIR=$(cd $(dirname $0); pwd)/vim
echo $DIR

if vim --version > /dev/null 2>&1; then
  if [[ -e ~/.vimrc ]]; then
    echo backup: mv ~/.vimrc ~/.vimrc.bk
    mv ~/.vimrc ~/.vimrc.bk
  fi
  echo install: ln -sf ${DIR}/.vimrc ~/.vimrc
  ln -sf ${DIR}/vimrc.vim ~/.vimrc
else
  echo vim not exists...
fi

echo finished!
