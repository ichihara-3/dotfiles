filetype plugin indent on

syntax on

set t_Co=256
set fileformats=unix

set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set nowrap

set virtualedit=block

set incsearch
set hlsearch
set ignorecase
set smartcase

set ruler
set number
set list
set listchars=tab:>-

set ambiwidth=double

set laststatus=2
set showtabline=2

set wildmenu
set wildmode=list:full
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll
let g:python_highlight_all = 1

set showcmd

set clipboard=unnamed

" set up for python


if exists('b:did_ftplugin_python')
    finish
endif
let b:did_ftplugin_python = 1

setlocal smarttab
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal foldmethod=indent
setlocal commentstring=#%s

" - af: a function
   " - if: inner function
   " - ac: a class
   " - ic: inner class

   " this plugin has aditional key-bind
"  -  '[pf', ']pf': move to next/previous function
 "  -  '[pc', ']pc': move to next/previous class
 xmap <buffer> af <Plug>(textobj-python-function-a)
 omap <buffer> af <Plug>(textobj-python-function-a)
 xmap <buffer> if <Plug>(textobj-python-function-i)
 omap <buffer> if <Plug>(textobj-python-function-i)
 xmap <buffer> ac <Plug>(textobj-python-class-a)
 omap <buffer> ac <Plug>(textobj-python-class-a)
 xmap <buffer> ic <Plug>(textobj-python-class-i)
 omap <buffer> ic <Plug>(textobj-python-class-i)

 setlocal omnifunc=jedi#completions
  
if version < 600
    syntax clear
elseif exists('b:current_after_syntax')
    finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save
