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
  " git support
  Plug 'tpope/vim-fugitive'
  " pretty statusline
  Plug 'itchyny/lightline.vim'
  " golanguage support
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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

" add current path with fuzzy search
set path+=**


" ======= appearance ====== 
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
" mode in status line is no longer needed since lightline shows it
set noshowmode
" show lines and columns
" set ruler
" statusline
" %F: Full path to the file
" %m: modify flag:: modifiable -> + / unmodifilable -> -
" %=: right aligned
" %y: filetype
" %c: column number
" %l: current line number
" %L: number of lines of the fille
" set statusline=%F%m%=%y[ENC=%{&fileencoding}]\ \ %c\ [%l/%L]

" complete longest common string, then start wildmenu
set wildmenu
set wildmode=longest,full


" ======= completion ====== 
" set spell check
set spell
set spelllang=en,cjk

" adjust letter-case with auto-completion
set infercase


" ======= editing ====== 
" tab length that appears
set tabstop=4
" width of indent (the size of tabstop is used)
set shiftwidth=0
" use spaces to insert a <TAB>
set expandtab
" backspacing over autoindent, line breaks, start of insert
set backspace=indent,eol,start
" file encodings to use
set fileencodings=utf-8,euc-jp,cp932,sjis,latin1
" enable to hide modified buffers without :write
set hidden


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
