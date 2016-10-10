set nocompatible

" Plugins {{{
call plug#begin()

Plug 'jonathanfilip/vim-lucius'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'reedes/vim-pencil'

call plug#end()
" }}}

" reedes/vim-pencil {{{
let g:pencil_gutter_color = 1
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd BufReadPre * call pencil#init()
augroup END
" }}}

" reedes/vim-pencil {{{
let g:pencil_gutter_color = 1
" }}}

" Searching {{{
set hlsearch
set ignorecase
set smartcase

nnoremap / /\v
vnoremap / /\v
" }}}

" Reading {{{
augroup newfile
  autocmd!
  autocmd BufNewFile * :q
augroup END

set nomodifiable
set ruler
set number
set nomodeline

set cursorline
set colorcolumn=+1,79

set background=dark
colorscheme lucius
" }}}

" Miscelaneous {{{
" Get rid of startup nag
set shortmess+=I

set wildmode=list:longest,full

let mapleader=','
nmap <silent> <leader>f :QFix<CR>
nmap <silent> <leader>p :Files<CR>
nnoremap <leader>s :Ag<CR>

" Copy file to system clipboard
map <leader>c :%y*<CR>

" Copy line to system clipboard
nmap <silent> <leader>l 0v$h"*y

" Work around being in a Python virtualenv
let g:python_host_prog='/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/python'

" }}}
