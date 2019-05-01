" plugin management
" with junegunn/vim-plug
" to use vim-plug, install the plugin into the autoload directory
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
call plug#begin('~/.vim/plugged')

" comment out / uncomment easily
Plug 'tpope/vim-commentary'
" yank, paste, change surroundings like ", ', (), {}, <tags>
Plug 'tpope/vim-surround'
" repeat vim-surround
Plug 'tpope/vim-repeat'

call plug#end()


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

" always show a status line
set laststatus=2

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

" print the line number in front of each lines
set number

" enable to hide modified buffers without :write
set hidden

" turn off highlight with typing Esc Key twice
nnoremap <ESC><ESC> :noh<CR>
