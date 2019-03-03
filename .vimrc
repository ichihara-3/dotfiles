" enable syntax highlighting
syntax enable
" enable filetype detection, filetype plugin, indent file
filetype plugin indent on

" highlight search
set hlsearch
" incremental search
set incsearch
" case-insensitive search
set ignorecase

" underline on where cursor is
set cursorline

" show typing commands and counts of selected area
set showcmd

" tab length that appears
set tabstop=4
" width of indent (the size of tabstop is used)
set shiftwidth=0
" use spaces to insert a <TAB>
set expandtab

" file encodings to use
set fileencodings=utf-8,euc-jp,cp932,sjis,latin1

" complete longest common string, then start wildmenu
set wildmenu
set wildmode=longest,full

" print the line number in front of each line
set number

" enable to hide modified buffers without :write
set hidden
