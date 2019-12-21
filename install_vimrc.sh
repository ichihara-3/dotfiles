#!/bin/bash
DIR=$(dirname $0)

if vim --version > /dev/null 2>&1; then
  echo backup: mv ~/.vimrc ~/.vimrc.bk
  mv ~/.vimrc ~/.vimrc.bk
  echo install: ln -s ${DIR}/.vimrc ~/.vimrc
  ln -sf ${DIR}/.vimrc ~/.vimrc
fi

echo finished!
