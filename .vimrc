" plugin management
" with junegunn/vim-plug
" To use vim-plug, install the plugin into the autoload directory
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
call plug#begin('~/.vim/plugged')

  " comment out / uncomment easily
  Plug 'tpope/vim-commentary'
  " yank, paste, change surroundings like ", ', (), {}, <tags>
  Plug 'tpope/vim-surround'
  " repeat vim-surround
  Plug 'tpope/vim-repeat'
  " golanguage support
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  " git support
  Plug 'tpope/vim-fugitive'

call plug#end()

" enable syntax highlighting
syntax enable
" enable filetype detection, filetype plugin, indent file
filetype plugin indent on

" ======= search ====== 
" highlight search
set hlsearch
" incremental search
set incsearch
" case-insensitive search
set ignorecase


" ======= appearances ====== 
" underline on where cursor is
set cursorline
" print the line number in front of each lines
set number
" use ambiguous width font with twice of ascii's. 
" e.g. Japanese Fonts びむ
" Only effective when 'encoding' is "utf-8"
set ambiwidth=double


" ======= status ====== 
" show typing commands and counts of selected area
set showcmd
" always show a status line
set laststatus=2
" complete longest common string, then start wildmenu
set wildmenu
set wildmode=longest,full


" file encodings to use
set fileencodings=utf-8,euc-jp,cp932,sjis,latin1
" enable to hide modified buffers without :write
set hidden
" add current path with fuzzy search
set path+=**

" set spell check
set spell
set spelllang=en,cjk

" adjust letter-case with auto-completion
set infercase

" tab length that appears
set tabstop=4
" width of indent (the size of tabstop is used)
set shiftwidth=0
" use spaces to insert a <TAB>
set expandtab

" backspacing over autoindent, line breaks, start of insert
set backspace=indent,eol,start


" ======= colors ====== 
" set colorscheme
colorscheme slate
" change spell check highlighting to underline
highlight clear SpellBad
highlight SpellBad cterm=underline

highlight clear SpellCap
highlight SpellCap cterm=underline,bold

highlight clear SpellRare
highlight SpellRare cterm=underline

" set Popup menu color to: Gray(7)
highlight Pmenu ctermbg=7


" ======= key mappings ====== 
" turn off highlight with typing Esc Key twice
nnoremap <ESC><ESC> :noh<CR>
