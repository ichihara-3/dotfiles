" I usually create symlink to vimrc in dotfiles directory,
" so storing real path of the vimrc is useful.
function! s:GetVimrc ()
  return resolve($MYVIMRC)
endfunction

let g:my_vimrc_file = s:GetVimrc()

" ======= vim-plug ======
" plugin management with junegunn/vim-plug

" check if the plugin manager is installed

if !exists('g:vim_plug_is_installed')

  let s:plug_path = glob('~/.vim/autoload/plug.vim')
  if file_readable(s:plug_path)
    let g:vim_plug_is_installed = 1
  else
    let g:vim_plug_is_installed = 0
    echomsg 'vim plug is not installed.'
    echomsg 'call :InstallPlug to get vim-plug'
  endif
endif

" install junegunn/vim-plug
function! s:install_plug() abort
  if !g:vim_plug_is_installed
    echo 'installing vim-plug...'
    if !executable('curl')
      echo '`curl` not found'
      return
    endif
    call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    runtime '~/.vim/autoload/plug.vim'
    call s:configure_plugins()
    let g:vim_plug_is_installed = 1
    echo 'finished!'
    echo 'to install plugins, call :PlugInstallWithSettings'
  else
    echo 'vim-plug is already installed'
  endif
endfunction

" ======= plugins ======
" to install plugins bellow, call :PlugInstall after opening the vim.

function! s:configure_plugins()
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
    Plug 'rbong/vim-crystalline'

    " fuzzy file finder
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    " fzf with most recently used files
    Plug 'pbogut/fzf-mru.vim'
    " fzf git switch
    Plug 'ichihara-3/fzf-gitswitch.vim'
    " powerup register
    Plug 'junegunn/vim-peekaboo'

    " Goyo mode
    Plug 'junegunn/goyo.vim'
    if !has('nvim')
      " terminal empty line enhancement
      Plug 'tyru/empty-prompt.vim'
    endif
    " user operator definition
    Plug 'kana/vim-operator-user'
    " replace with register
    Plug 'kana/vim-operator-replace'
    " filer
    Plug 'preservim/nerdtree'
    " nerdtree git plugin
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " ====== color schemes ======
    " gruvbox
    Plug 'morhetz/gruvbox'

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

    " go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " asyncomplete
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    " asyncomplete sources
    " files/directories
    Plug 'prabirshrestha/asyncomplete-file.vim'
    " Buffer Completion
    Plug 'prabirshrestha/asyncomplete-buffer.vim'

    " Language Server Protocols
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
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
function! s:is_installed(name) abort
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

" use 256 colors mode
set t_Co=256

if v:lang =~ "ja_JP"
  set helplang=ja
endif

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
" show vertical column line
set cursorcolumn
" show textwidth line
set colorcolumn=+1
" print the line number in front of each lines
set number
" use ambiguous width font with twice of ascii's.
" e.g. Japanese Fonts びむ
" Only effective when 'encoding' is "utf-8"
set ambiwidth=double

" set ambiwidth=single when terminal is open
" Because a prompt may be doubled or the format is collapsed
" with powerlevel10k in a terminal in Vim.
augroup TermSettings
  autocmd!
  if exists("TerminalOpen")
    autocmd TerminalOpen * set ambiwidth=single
  endif
  autocmd BufEnter * if &buftype=="terminal" | set ambiwidth=single | endif
  autocmd BufLeave * if &buftype=="terminal" | set ambiwidth=double | endif
augroup END

" show some special charcters
set list
set listchars=tab:>-,nbsp:%
" vim update time span (default 4000ms)
" set shorter for vim-gitgutter:
"   https://github.com/airblade/vim-gitgutter#getting-started
set updatetime=100
" number of screen lines to keep above and below the cursor.
set scrolloff=2
" regexengine
" to solve problem of too slow ts syntax highlighting
" https://jameschambers.co.uk/vim-typescript-slow
set regexpengine=0

" gui font
if has("gui_running")
  if has("gui_macvim")
    set guifont=Ricty:h17
  endif
endif

" ======= status ======
" show typing commands and counts of selected area
set showcmd
" always show a status line
set laststatus=2
" mode in status line is no longer needed since lightline shows it
set noshowmode
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

if &undofile && !isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif

" default tabstop is 2
set tabstop=2
" width of indent (the size of tabstop is used)
set shiftwidth=0
" use spaces to insert a <TAB>
set expandtab
" backspacing over autoindent, line breaks, start of insert
set backspace=indent,eol,start
" file encodings to use
set encoding=utf-8
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
" numbers are always considered to be decimal
set nrformats=

" delete spaces at the end of lines
augroup PreWriting
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END

" check if buffers are modified
function! s:buffer_modified ()
  return len(getbufinfo({'bufmodified': 1})) != 0
endfunction

" change directory to of current file or specified directory
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd ' .. a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

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

" move display lines with normal up/down keys
nnoremap j gj
nnoremap k gk


" set mapleader to <space> key
let mapleader = "\<Space>"

" edit vimrc
nnoremap <silent> <leader>s :<C-u>exec 'edit' g:my_vimrc_file<CR>

" replace
map _ <Plug>(operator-replace)

" fuzzy search files (fzf)

function! s:preview_command()
  return  executable('bat') ? 'bat  --style=header,grid --line-range :100 {}' : 'cat {}'
endfunction

" preview with `bat` if executable, if can't, `cat` is used
nnoremap <silent> <leader><Space> :<C-u>call fzf#vim#files(
    \ '',
    \ {'options': [
    \           '--reverse',
    \           '--info=inline',
    \           '--preview', <SID>preview_command()
    \ ]},
    \ 0
    \ )<CR>
" fuzzy search buffers
nnoremap <silent> <leader>b :<C-u>call fzf#vim#buffers('', {'options': ['--reverse']})<CR>
" fuzzy search lines
nnoremap <silent> <leader>l :<C-u>call fzf#vim#buffer_lines('', {'options': ['--reverse']})<CR>
" fuzzy search with ag
nnoremap <silent> <leader>a :<C-u>Ag<space>
" command history
nnoremap <silent> <leader>c :<C-u>call fzf#vim#command_history({'options': ['--no-reverse']})<CR>
" fuzzy search most recently used files
nnoremap <silent> <leader>m :<C-u>execute 'FZFMru --preview ' .. "'" .. <SID>preview_command() .. "'"<CR>

" change current directory
nnoremap <silent> <leader>cd :<C-u>CD<CR>

" lsp help
nmap <silent> <leader>h <Plug>(lsp-hover)
" show lsp diagnostics
nmap <silent> <leader>e <Plug>(lsp-document-diagnostics)

" turn off highlight with typing Esc Key twice
nnoremap <silent> <ESC><ESC> :<C-u>noh<CR>

" toggle numbers
function! s:toggle_numbers()
  let &number = !&number
endfunction

nnoremap <silent> <leader>nn :<C-u>call <SID>toggle_numbers()<CR>

" tabs
" new tab
nnoremap <silent> <leader>, :<C-u>tabnew<CR>
" next tab
nnoremap <silent> <leader>] :<C-u>tabnext<CR>
" previous tab
nnoremap <silent> <leader>[ :<C-u>tabprevious<CR>

" terminal
nnoremap <silent> <leader>t :<C-u>terminal<CR>

" window
" split virtical
nnoremap <silent> <leader>\| :<C-u>vsplit<CR>
" split horizontal
nnoremap <silent> <leader>- :<C-u>split<CR>
" close window
nnoremap <silent> <leader>x :<C-u>close<CR>

" filer
nnoremap <silent> <leader>f :<C-u>NERDTreeToggle<CR>

" git
" Gstatus
nnoremap <silent> <leader>gs :<C-u>Git<CR>
" Gpush
nnoremap <silent> <leader>gp :<C-u>Git push<CR>
" Gdiff
nnoremap <silent> <leader>gd :<C-u>Gdiffsplit<CR>
" git switch
nmap <silent> <leader>gc <Plug>(fzf_gs)
" git checkout new branch
function! s:git_switch_prompt()
  let branchname = trim(input("branch name(<TAB> for completion) >> ", "", "customlist,fugitive#CompleteObject"))
  if branchname != ''
    let cwd = getcwd()
    let changeto = expand('%:p:h')
    try
      call chdir(changeto)
      silent call system('git show-ref --verify --quiet "refs/heads/' .. branchname .. '"')
      if v:shell_error
        if confirm("Checkout a new branch?", "&Yes\n&No") == 1
          execute "Git switch -c " .. branchname
        else
          return
        endif
      else
        redraw
        execute "Git switch " .. branchname
      endif
    finally
      call chdir(cwd)
    endtry
  endif
endfunction
nnoremap <silent> <leader>gn :<c-u>call <SID>git_switch_prompt()<CR>

" colors
function! s:toggle_background()
  if &background == 'dark'
    set background=light
  else
    set background=dark
  endif
endfunction

nnoremap <silent> <leader>cc :<C-u>call <SID>toggle_background()<CR>

" paste mode
function! s:toggle_paste()
  let &paste=!&paste
endfunction

nnoremap <silent> <leader>pp :<C-u>call <SID>toggle_paste()<CR>

" ======= commands ======
" cd command
command! -nargs=? -complete=dir -bang CD call <SID>ChangeCurrentDir('<args>','<bang>')
" source current file
command! Rc source %
" command to install vim-plug
command! InstallPlug call s:install_plug()
" command to install plugins with settings
command! PlugInstallWithSettings PlugInstall | call s:set_up_plugins()
" vertical terminal
command! Vt vertical terminal

" ===============================
"   filetype specific settings
" ===============================

augroup SetFileType
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile setfiletype groovy
augroup END

augroup FileTypeIndent
  autocmd!
  autocmd FileType python setlocal tabstop=4
  autocmd FileType go setlocal tabstop=8
augroup END

augroup PythonSettings
  autocmd!
  " highlight the keyword `self` not highlighted by default
  autocmd FileType python syntax keyword keywordSelf self | highlight link keywordSelf Keyword
augroup END

" not to comment out on newline:
" r: when insert, o:when normal and type 'o' 'O'
augroup NoNewCommentLine
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END

" ===============================
"         plugin settings
" ===============================

function! s:set_up_plugins()

  " ======= vim-crystalline =======
  if s:is_installed('vim-crystalline')
    function! StatusLine(current, width)
      let l:s = ''
      if !(v:lang =~ 'UTF-8')
        let g:crystalline_separators = ['', '']
      endif

      if a:current
        if v:lang =~ 'UTF-8'
          let l:s .= crystalline#mode() . '🐶' . crystalline#right_mode_sep('')
        else
          let l:s .= crystalline#mode() .  " V'w'V < wan! " . crystalline#right_mode_sep('')
        endif
      else
        let l:s .= '%#CrystallineInactive#'
      endif
      let l:s .= ' %f%h%w%m%r '
      if a:current
        if v:lang =~ 'UTF-8'
          let l:s .= crystalline#right_sep('', 'Fill') . ' %{FugitiveStatusline()}' . ' 🐱'
        else
          let l:s .= crystalline#right_sep('', 'Fill') . ' %{FugitiveStatusline()}' . ' =^..^= < nyan!'
        endif
      endif

      let l:s .= '%='
      if a:current
        let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
        let l:s .= crystalline#left_mode_sep('')
      endif
      if a:width > 80
        let l:s .= ' %{&ft} [%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
      else
        let l:s .= ' '
      endif

      return l:s
    endfunction

    function! TabLine()
      let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
      return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
    endfunction

    let g:crystalline_enable_sep = 1
    let g:crystalline_statusline_fn = 'StatusLine'
    let g:crystalline_tabline_fn = 'TabLine'
    let g:crystalline_theme = 'gruvbox'

    set showtabline=2
    set guioptions-=e
    set laststatus=2

  endif

  " ======= vim-emoji =======

  if s:is_installed('vim-gitgutter')
    let g:gitgutter_sign_added = '+'
    let g:gitgutter_sign_modified = '~'
    let g:gitgutter_sign_removed = '-'
    let g:gitgutter_sign_modified_removed = '!'
  endif


  " ======= fzf =======
  if s:is_installed('fzf')
    " layout
    let g:fzf_layout = { 'left' : '~40%'}
    " keybindings
    let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  endif

  " ======= vim-clang =======
  " vim-clang settings
  " to use vim-clang, clang must be installed.
  " use c11 specs.
  if s:is_installed('vim-clang')
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

  " ======= vim-go =======

  let g:go_template_autocreate = 0
  let g:go_fmt_command = "goimports"

  " ======= asyncomplete settings =======

  if s:is_installed('asyncomplete.vim')
    augroup AsyncComplete
      autocmd!
      " files
      if s:is_installed('asyncomplete-file.vim')
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
            \ 'name': 'file',
            \ 'whitelist': ['*'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#file#completor')
            \ }))
      endif

      " buffers
      if s:is_installed('asyncomplete-buffer.vim')
        autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \ 'name': 'buffer',
            \ 'whitelist': ['*'],
            \ 'blacklist': [],
            \ 'completor': function('asyncomplete#sources#buffer#completor'),
            \ 'config': {
            \    'max_buffer_size': 5000000,
            \  },
            \ }))
      endif
    augroup END
  endif


  " ======= vim-empty-line =======
  if s:is_installed('empty-prompt.vim') && v:version >= 801 && has('patch-8.1.1228')
    function! s:empty_prompt_mappings() abort
      " If current line is empty prompt ...

      " : works as <C-w>:
      call empty_prompt#map(#{lhs: ':', rhs: '<C-w>:'})
      " <Esc> works as <C-w>N
      call empty_prompt#map(#{lhs: '<Esc>', rhs: '<C-w>N'})

      " empty prompt pattern
      let g:empty_prompt#pattern = '\(❯\|.*\$\)\s*$'

    endfunction

    augroup EmptyLine
      autocmd!
      autocmd VimEnter * ++once call s:empty_prompt_mappings()
    augroup END
  endif

 " ======= colorscheme  =======

  if s:is_installed('gruvbox')
    colorscheme gruvbox
    set background=dark
  endif

endfunction

call s:set_up_plugins()
" ===============================
"     plugin settings end
" ===============================

" vim: set ai bs=indent,eol,start ts=2 sw=2 ambw=double:
