#!/bin/bash
set -e

SOURCEDIR=$(cd $(dirname $0); pwd)/nvim
CONFIGDIR=~/.config/nvim
echo $SOURCEDIR

if vim --version > /dev/null 2>&1; then

  if ! [[ -e ${CONFIGDIR} ]]; then
    mkdir -p ${CONFIGDIR}
  elif [[ -e ${CONFIGDIR}/init.vim ]]; then
    echo backup: mv ${CONFIGDIR}/init.vim ${CONFIGDIR}/init.vim.bk
    mv ${CONFIGDIR}/init.vim ${CONFIGDIR}/init.vim.bk
  fi
  echo install: ln -s ${SOURCEDIR}/init.vim ${CONFIGDIR}/init.vim
  ln -sf ${SOURCEDIR}/init.vim ${CONFIGDIR}/init.vim
else
  echo vim not exists...
fi

echo finished!
