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

" set colorscheme
colorscheme slate

" highlight search
set hlsearch
" incremental search
set incsearch
" case-insensitive search
set ignorecase

" adjust letter-case with auto-completion
set infercase

" underline on where cursor is
set cursorline

" use ambiguous width font with twice of ascii's. 
" e.g. Japanese Fonts びむ
" Only effective when 'encoding' is "utf-8"
set ambiwidth=double

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

" add current path with fuzzy search
set path+=**

" set spell check
set spell
set spelllang=en,cjk

" change spell check highlighting to underline
highlight clear SpellBad
highlight SpellBad cterm=underline

highlight clear SpellCap
highlight SpellCap cterm=underline,bold

highlight clear SpellRare
highlight SpellRare cterm=underline

" set Popup menu color to: Gray(7)
highlight Pmenu ctermbg=7

" turn off highlight with typing Esc Key twice
nnoremap <ESC><ESC> :noh<CR>

