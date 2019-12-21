#!/bin/bash
PWD=$(pwd)

if vim --version > /dev/null 2>&1; then
  echo backup: mv ~/.vimrc ~/.vimrc.bk
  mv ~/.vimrc ~/.vimrc.bk
  echo install: ln -s ${PWD}/.vimrc ~/.vimrc
  ln -sf ${PWD}/.vimrc ~/.vimrc
fi

echo finished!
