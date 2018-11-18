" dein.vim setting
if &compatible
  set nocompatible
endif

if (v:version >= 800)
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

    call dein#add('Shougo/denite.nvim')
    call dein#add('python-mode/python-mode')
    call dein#add('scrooloose/nerdtree')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')

    call dein#end()
    call dein#save_state()
  endif
endif

filetype plugin indent on 
syntax enable


" ------------------------------------------------------------------------------
"  General
" ------------------------------------------------------------------------------

" エラー時のビープ音や画面フラッシュ.
set noerrorbells
set showcmd
" 行がウィンドウ幅より長い場合の折り返し.
set nowrap

" ------------------------------------------------------------------------------
"  tab
" ------------------------------------------------------------------------------

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" ------------------------------------------------------------------------------
"  Search
" ------------------------------------------------------------------------------

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 行番号を表示しない
set nonumber 

" ステータス行へのカーソル位置の表示.
set ruler

" 文字幅が曖昧 (文脈によって文字幅が異なる) 文字の表示幅.
"     single : ASCII 文字 1 文字分の幅で表示.
"     double : ASCII 文字 2 文字分の幅で表示.
set ambiwidth=double

set smartindent
set showmatch
set laststatus=2
set wildmode=list:longest
set scrolloff=3

" diff モード時のオプション.
set diffopt=context:77777

" ------------------------------------------------------------------------------
"  Backup
" ------------------------------------------------------------------------------
set nobackup
set noswapfile
set autoread
set hidden


" cursor moving
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk


" ------------------------------------------------------------------------------
"  File
" ------------------------------------------------------------------------------

" 改行コード.
"     dos  : <CR><LF>
"     mac  : <LF>
"     unix : <CR>
set fileformats=unix,dos,mac

" vim 内部, ターミナル, ファイルのエンコーディング.
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp,cp932

" 行頭, 行末を越えたカーソル移動を行うキー.
set whichwrap=b,s,h,l,<,>

" インクリメンタルサーチ.
set incsearch

" 検索ヒット時のハイライト表示.
set hlsearch

" 検索時の大文字小文字の区別.
set ignorecase

" 検索キーワードに大文字小文字が混在する場合の ignorecase の無効化.
set smartcase

" 検索で末尾に達した場合の先頭からの再検索の実行.
set nowrapscan

" ------------------------------------------------------------------------------
"  Edit
" ------------------------------------------------------------------------------

" UNDO レベル.
set undolevels=10240

" <BACKSPACE> で削除を許可する文字.
"     indent : autoindent により挿入されたインデント.
"     eol    : 改行文字.
"     start  : 挿入区間の開始.
set backspace=indent,eol,start

" 改行時の自動インデント.
set noautoindent

" 自動インデント時のスペース数.
set shiftwidth=4

" TAB 挿入時のスペースへの展開.
set expandtab


" Pymodeの設定
" line too long を無視する
let g:pymode_lint_ignore = ["E501"]

