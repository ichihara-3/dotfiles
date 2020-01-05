" I usually create symlink to vimrc in dotfiles directory so that
" to store real path of the vimrc is useful.
function! s:GetVimrc ()
  return resolve($MYVIMRC)
endfunction

let g:my_vimrc_file = s:GetVimrc()

" ======= vim-plug ======
" plugin management with junegunn/vim-plug

" check if the plugin manager is installed
let s:plug_path = glob('~/.vim/autoload/plug.vim')
if file_readable(s:plug_path)
  let g:vim_plug_is_installed = 1
else
  let g:vim_plug_is_installed = 0
  echomsg 'vim plug is not installed.'
  echomsg 'call :InstallPlug to get vim-plug'
endif

" install junegunn/vim-plug and add
function! s:install_plug()
  if !g:vim_plug_is_installed
    echo 'installing vim-plug...'
    call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    if exists('*configure_plugins')
      call s:configure_plugins()
    endif
    echo 'finished!'
    echo 'to install plugins, call :PlugInstall'
  else
    echo 'vim-plug is already installed'
  endif
endfunction

command! InstallPlug call s:install_plug()

" ======= plugins ======
" to install plugins bellow, call :PlugInstall after opening the vim.

function s:configure_plugins()
  call plug#begin('~/.vim/plugged')

    " vim Japanese version help
    Plug 'vim-jp/vimdoc-ja'
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
    " enhance netrw
    Plug 'tpope/vim-vinegar'

    " ====== languages support ======
    " clang support. clang and clang-format should be installed.
    if executable('clang') && executable('clang-format')
      Plug 'justmao945/vim-clang', { 'for': ['c', 'cpp'] }
    endif
    " html tags auto completion
    Plug 'mattn/emmet-vim', { 'for' : ['html', 'js', 'ts', 'vue'] }
    " html5 syntax highlighting
    Plug 'othree/html5.vim', { 'for' : ['html', 'js', 'ts', 'vue'] }
    " css3 syntax highlighting
    Plug 'hail2u/vim-css3-syntax', { 'for' : ['css', 'html', 'vue'] }
    " toml syntax support
    Plug 'cespare/vim-toml', { 'for' : ['toml'] }

    " asyncomplete
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    " asyncomplete sources
    " lsp
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    " files/directories
    Plug 'prabirshrestha/asyncomplete-file.vim'

    " Language Server Protocols
    " vim-lsp
    Plug 'prabirshrestha/vim-lsp'

    " LSP auto settings
    Plug 'mattn/vim-lsp-settings'


  call plug#end()
endfunction

if vim_plug_is_installed
  call s:configure_plugins()
endif

" utility to check if the plugin is installed
function! s:IsInstalled(name)
  if !exists('g:plugs')
    return 0
  endif

  " The plugin name should exist in g:plugs dictionary
  " if the plugin is already installed.
  return has_key(g:plugs, a:name) ? isdirectory(g:plugs[a:name].dir) : 0
endfunction


" enable syntax highlighting
syntax enable
" enable filetype detection, filetype plugin, indent file
filetype plugin indent on

" vim help languages
set helplang=ja

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
" open new buffer below when :split
set splitbelow
" automatically reload the editing file after the file has externally changed.
set autoread
" Allow virtual editing in Visual block mode.
set virtualedit=block
" turn off bells
set belloff=all
" enable mouse
set mouse=a
" diff mode settings
" vertical diff with fill lines
set diffopt=filler,vertical
" use clipboard
set clipboard=unnamed,unnamedplus

augroup PreWriting
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END

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

" ======= git ======

function! s:switch (line)
  let l:branch = substitute(a:line, '^\s*\w*/\(\w*\)\s*.*$', '\1', '')
  echo l:branch
  let l:result = system('git switch ' . l:branch)
  if v:shell_error != 0
    call system('git checkout ' . l:branch)
    if v:shell_error != 0
      call system('git -b checkout ' . l:branch)
    endif
  endif
  if v:shell_error == 0
    bufdo edit!
    echomsg 'switched to ::' . l:branch
  else
    echohl Warningmsg
    echomsg l:result
    echohl None
  endif
endfunction

function! s:branches ()
  let l:current = trim(system("git branch --points-at=HEAD --format='%(refname:lstrip=2)'"))
  let l:branches = system('git branch -r |sed -e "/HEAD/d" -e "/->/d" -e "/' . l:current . '/d"')
  return split(l:branches, '\n')
endfunction

if s:IsInstalled('fzf')
  function! s:git_switch ()
    call fzf#run(fzf#wrap({
    \ 'source': s:branches(),
    \ 'sink': function('s:switch')
    \ }))
  endfunction
endif

" ======= key mappings ======
" set mapleader to <space> key
let mapleader = "\<Space>"

" edit vimrc
nnoremap <silent> <leader>s :<C-u>exec 'edit' g:my_vimrc_file<CR>

" fuzzy search files (fzf)
if s:IsInstalled('fzf.vim') && s:IsInstalled('fzf')

  nnoremap <silent> <leader><Space> :<C-u>FZF --reverse --multi<CR>
  " fuzzy search buffers
  nnoremap <silent> <leader>b :<C-u>call fzf#vim#buffers('', {"--reverse": 1})<CR>
  " fuzzy search lines
  nnoremap <silent> <leader>l :<C-u>call fzf#vim#buffer_lines('', {"--reverse": 1})<CR>
  " fuzzy search buffers history
  nnoremap <silent> <leader>h :<C-u>call fzf#vim#history(0)<CR>
  " command history
  nnoremap <silent> <leader>c :<C-u>call fzf#vim#command_history(0)<CR>
  cnoremap <silent> <C-p> <C-u>call fzf#vim#command_history(0)<CR>

  nnoremap <silent> <leader>gb :<C-u>call <SID>git_switch()<CR>
endif


" turn off highlight with typing Esc Key twice
nnoremap <silent> <ESC><ESC> :<C-u>noh<CR>

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
nnoremap <silent> <leader>v :<C-u>vs<CR>
" close window
nnoremap <silent> <leader>x :<C-u>close<CR>

" filer
nnoremap <silent> <leader>f :<C-u>Vexplore<CR>

" fugitive(git)
if s:IsInstalled('vim-fugitive')
  " Gstatus
  nnoremap <silent> <leader>gs :<C-u>Gstatus<CR>
  " Gcommit
  nnoremap <silent> <leader>gc :<C-u>Gcommit<CR>
  " Gpush
  nnoremap <silent> <leader>gp :<C-u>Gpush<CR>
  " Gdiff
  nnoremap <silent> <leader>gd :<C-u>Gdiffsplit<CR>
endif

" ======= commands ======
" source current file
command! Rc source %

" ===============================
"   filetype specific settings
" ===============================

augroup FileTypeIndent
  autocmd!
  autocmd FileType vim,html,js,ts,css,vue,App,yaml,toml,sh setlocal tabstop=2
augroup END

" not to comment out on newline: r(when insert) o(when normal and type 'o' 'O')
augroup NoNewCommentLine
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END

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


" ======= fzf =======
if s:IsInstalled('fzf')
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
if executable('clang') && s:IsInstalled('vim-clang')
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

" ======= asyncomplete settings =======
" files
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))


" ======= lightline settings =======
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ ['mode', 'paste'], ['fugitive', 'filename'] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2v',
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ }
      \ }


function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? ' ' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head())
      return ' ' . fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" vim: set ai bs=indent,eol,start ts=2 sw=2 ambw=double:
