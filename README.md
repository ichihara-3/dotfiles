# dotfiles

contents::


```
.
├── vim
│   ├── vimrc.vim
│   └── debug-lsp.vim
├── tmux
│   └── tmux.conf
├── nvim
│   └── init.vim
├── install_vimrc.sh
├── install_tmuxconf.sh
├── install_nvim_init.sh
├── README.md
├── .my.zsh
├── .gitignore
```

to install vimrc, run

```bash
bash install_vimrc.sh
```

This script will backup current ~/.vimrc and create symlink to the vim/vimrc.vim.
