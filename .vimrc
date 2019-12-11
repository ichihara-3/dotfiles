" plugin management with junegunn/vim-plug
" To use vim-plug, install the plugin into the autoload directory
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" check if the plugin manager is installed
let s:plug_path = glob('~/.vim/autoload/plug.vim')
if file_readable(s:plug_path)
  let g:vim_plug_is_installed = 1
else
  let g:vim_plug_is_installed = 0
  echomsg 'vim plug is not installed.'
  echomsg 'call :InstallPlug to get vim-plug'
endif

function! s:install_plug()
  if !g:vim_plug_is_installed
    echo 'installing vim-plug...'
    call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    source ~/.vimrc
  else
    echo 'vim-plug is already installed'
  endif
endfunction

command! InstallPlug call s:install_plug()

set pyxversion=3

" ======= plugins ======
" to install plugins bellow, call :PlugInstall after opening the vim.
if vim_plug_is_installed
  call plug#begin('~/.vim/plugged')

    " comment out / uncomment easily
    Plug 'tpope/vim-commentary'
    " yank, paste, change surroundings like ", ', (), {}, <tags>
    Plug 'tpope/vim-surround'
    " repeat vim-surround
    Plug 'tpope/vim-repeat'
    " git support
    Plug 'tpope/vim-fugitive'
    " show git diff in the sign column
    Plug 'airblade/vim-gitgutter'
    " pretty statusline
    Plug 'itchyny/lightline.vim'
    " fuzzy file finder
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    " undo tree
    Plug 'mbbill/undotree'

    " ====== languages support ======
    " golanguage support
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    " clang support. clang and clang-format should be installed.
    Plug 'justmao945/vim-clang', { 'for': ['c', 'cpp'] }
    " typescript support.
    " syntax highlight
    Plug 'leafgarland/typescript-vim', { 'for': ['ts'] }
    " auto completion
    Plug 'Quramy/tsuquyomi', { 'for': ['ts', 'vue'] }
    " html tags auto completion
    Plug 'mattn/emmet-vim', { 'for' : ['html', 'js', 'ts', 'vue'] }
    " html5 syntax highlighting
    Plug 'othree/html5.vim', { 'for' : ['html', 'js', 'ts', 'vue'] }
    " css3 syntax highlighting
    Plug 'hail2u/vim-css3-syntax', { 'for' : ['css', 'html', 'vue'] }

    " extended dark-powered tools
    if has('nvim')
      " auto completion
      Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
      " dark powered unite
      Plug 'Shougo/denite.nvim'
    else
      " auto completion
      Plug 'Shougo/deoplete.nvim', { 'do': 'pip3 install --user --upgrade pynvim' }
      " dark powered unite
      Plug 'Shougo/denite.nvim'
      " deoplete requirements for vim 8.
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
      " You may need install or upgrade novim-python to ver0.3.0+
      " pip3 install --user --upgrade pynvim
    endif

  call plug#end()
endif

" utility to check if whether the plugin is installed
function! s:PluginIsInstalled(name)
  if !exists('g:plugs')
    return 0
  endif

  return has_key(g:plugs, a:name) ? isdirectory(g:plugs[a:name].dir) : 0
endfunction


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
" vim update time span (default 4000ms)
" set shorter for vim-gitgutter:
"   https://github.com/airblade/vim-gitgutter#getting-started
set updatetime=100


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
" undo directory
set undodir=~/.vim/undo/
" enable undo file
set undofile
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
" open new buffer right side when :vsplit
set splitright
" open new buffer below current one when :split
set splitbelow
" automatically reload the editing file after the file has externally changed.
set autoread
" Allow virtual editing in Visual block mode.
set virtualedit=block
" turn off bells
set belloff=all
" enable mouse
set mouse=a

" ======= colors ======
" define color settings before set color schema
function! DefineMyColors()
  " change spell check highlighting to underline
  highlight clear SpellBad
  highlight SpellBad cterm=underline

  highlight clear SpellCap
  highlight SpellCap cterm=underline,bold

  highlight clear SpellRare
  highlight SpellRare cterm=underline

  " set Popup menu color to: Gray(7)
  highlight Pmenu ctermbg=7

  " vimdiff scheme colors
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

endfunction

" define autocommand of ColorScheme event so that
" color settings are not overwritten by setting colorscheme
augroup ChangeColors
  autocmd!
  autocmd ColorScheme * :call DefineMyColors()
augroup END

" set colorscheme
colorscheme slate

" ======= key mappings ======
" set mapleader to <space> key
let mapleader = "\<Space>"

" edit vimrc
nnoremap <leader>s :<C-u>edit ~/repos/ichihara-3/dotfiles/.vimrc<CR>

" fuzzy search files (fzf)
if s:PluginIsInstalled('fzf.vim') && s:PluginIsInstalled('fzf')
  nnoremap <silent> <leader><Space> :<C-u>FZF --reverse --multi<CR>
  " fuzzy search buffers
  nnoremap <silent> <leader>b :<C-u>Buffers<CR>
  " fuzzy search lines
  nnoremap <silent> <leader>l :<C-u>BLines<CR>
  " fuzzy search buffers history
  nnoremap <silent> <leader>h :<C-u>History<CR>
  " command history
  nnoremap <silent> <leader>c :<C-u>History:<CR>
  cnoremap <silent> <C-p> <C-u>History:<CR>
endif


" turn off highlight with typing Esc Key twice
nnoremap <ESC><ESC> :<C-u>noh<CR>

" tabs
" new tab
nnoremap <silent> <leader>t :<C-u>tabnew<CR>
" next tab
nnoremap <silent> <leader>n :<C-u>tabnext<CR>
" previous tab
nnoremap <silent> <leader>p :<C-u>tabprevious<CR>

" terminal
nnoremap <silent> <leader>T :<C-u>terminal<CR>

" window
" split virtical
nnoremap <leader>v :<C-u>vs<Space>
" close window
nnoremap <silent> <leader>x :<C-u>close<CR>

" filer
nnoremap <leader>f :<C-u>Vexplore<CR>

" fugitive(git)
if s:PluginIsInstalled('vim-fugitive')
  " Gstatus
  nnoremap <silent> <leader>gs :<C-u>Gstatus<CR>
  " Gcommit
  nnoremap <silent> <leader>gc :<C-u>Gcommit<CR>
  " Gpush
  nnoremap <silent> <leader>gp :<C-u>Gpush<CR>
  " Gdiff
  nnoremap <silent> <leader>gd :<C-u>Gdiff<CR>
endif

" ======= commands ======
" source current file
command! Rc source %

" ===============================
"   filetype specified settings
" ===============================

augroup FileTypeIndent
  autocmd!
  autocmd FileType vim,html,js,ts,css,vue,App,yaml,yaml setlocal tabstop=2
augroup END

" ===============================
"   autocommands
" ===============================

autocmd BufWritePre * :%s/\s\+$//ge

" ===============================
"         plugin settings
" ===============================

" ======= netrw =======
" window size of netrw
let g:netrw_winsize = 25
" hide netrw direcory banner
let g:netrw_banner = 0
" tree view
let g:netrw_liststyle = 3
" open in previous window
let g:netrw_browse_split = 4
" open left
let g:netrw_altv = 1


" ======= deoplete =======
if s:PluginIsInstalled('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
endif

" ======= denite.nvim =======

" ======= fzf =======
if s:PluginIsInstalled('fzf')
  " layout
  let g:fzf_layout = { 'left' : '~30%'}
  " keybindings
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
endif

" ======= vim-clang =======
" vim-clang settings
" to use vim-clang, clang must be installed.
if executable('clang') && s:PluginIsInstalled('vim-clang')
  " use c11 specs.
  let g:clang_c_options = '-std=c11'
  " use c++17(c++1z), libc++, the strict syntax checking with ISO C++
  let g:clang_cpp_options = '-std=c++17 -stdlib=libc++ -pedantic-errors'
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

" vim: set ai bs=indent,eol,start ts=2 sw=2 ambw=double:
