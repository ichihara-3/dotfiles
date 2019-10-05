" plugin management with junegunn/vim-plug
" To use vim-plug, install the plugin into the autoload directory 
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" automatically load vim-plug if not installed
let s:plug_path = glob('~/.vim/autoload/plug.vim')
if !file_readable(s:plug_path)
  echo 'installing vim-plug...'
  call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

" ======= plugins ====== 
" to install plugins bellow, call :PlugInstall after opening the vim.
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
  " fuzzy file finder
  Plug 'junegunn/fzf'
  " golanguage support
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' , 'for': ['go'] }
  " clang support. clang and clang-format should be installed.
  Plug 'justmao945/vim-clang', { 'for': ['c', 'cpp'] }

  " extended dark-powered completion
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    " deoplete requirements for vim 8. 
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    " You may need install or upgrade novim-python to ver0.3.0+
    " pip3 install --user --upgrade pynvim
  endif

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
" to aware modeline settings
set modeline
" tab length that used
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
" open new buffer light side when :vsplit
set splitright
" open new buffer below current one when :split
set splitbelow
" automatically reload the editing file after the file has externally changed.
set autoread
" Allow virtual editing in Visual block mode.
set virtualedit=block


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
" set mapleader to <space> key
let mapleader = "\<Space>"
" fuzzy search files
nnoremap <silent> <leader><Space> :<C-u>FZF --reverse --multi<CR>
" turn off highlight with typing Esc Key twice
nnoremap <ESC><ESC> :noh<CR>
" new tab
nnoremap <silent> <leader>t :tabnew<CR>
" next tab
nnoremap <silent> <leader>n :tabnext<CR>
" previous tab
nnoremap <silent> <leader>p :tabprevious<CR>



" =============================== 
"         plugin settings        
" =============================== 

" ======= deoplete =======
let g:deoplete#enable_at_startup = 1

" ======= fzf =======
" layout
let g:fzf_layout = { 'left' : '~30%'}
" keybindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" ======= vim-clang =======
" vim-clang settings
" to use vim-clang, clang must be installed.
if executable('clang')
  " use c11 specs.
  let g:clang_c_options = '-std=c11'
  " use c++17(c++1z), libc++, the strict syntax checking with ISO C++
  let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ -pedantic-errors'
  " auto format after saving the file. clang-format must be installed.
  if executable('clang-format')
    let g:clang_format_auto = 1
  else
    let g:clang_format_auto = 0
  endif
  " Google style format
  let g:clang_format_style = 'Google'
  " check syntax when saving the file.
  let g:clang_check_syntax_auto = 1
endif

" vim: set ai bs=indent,eol,start ts=2 ambw=double:
