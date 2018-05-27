" dein.vim setting
if &compatible
  set nocompatible
endif

" dein.vim install if not exists
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/gihub.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir,':p')
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/plugins'))
  call dein#begin(expand('~/.vim/plugins'))

  call dein#add('scrooloose/nerdtree')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on 
syntax enable

" setting
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set nowrap
set number 
"set cursorline
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set scrolloff=3

" to edit with a mouse
set list listchars=tab:\>\-
set expandtab
set tabstop=2
set shiftwidth=2

" search settings
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" move to home/end and start editing
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^a
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^a

" cursor moving
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
