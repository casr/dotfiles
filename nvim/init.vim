set nocompatible

" Plugins {{{
call plug#begin()

Plug 'Valloric/YouCompleteMe', {'do': './install.py --tern-completer'}
Plug 'benekastah/neomake'
Plug 'digitaltoad/vim-pug'
Plug 'jonathanfilip/vim-lucius'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'moll/vim-node'
Plug 'ntpeters/vim-better-whitespace'
Plug 'reedes/vim-colors-pencil'
Plug 'reedes/vim-pencil'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
" }}}

" Valloric/YouCompleteMe {{{
let g:ycm_autoclose_preview_window_after_completion = 1
" }}}

" reedes/vim-pencil {{{
let g:pencil_gutter_color = 1
" }}}

" tpope/vim-sensible {{{
" If any options need to overriden then you must explictly
" call sensible to load sooner.
"runtime! plugin/sensible.vim
" }}}

" vim-airline/vim-airline {{{
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'lucius'
let g:airline_powerline_fonts = 1
" }}}
"
" mhinz/vim-signify {{{
let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
" }}}

" Helper functions {{{
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
" }}}

" Searching {{{
set hlsearch
set ignorecase
set smartcase

nnoremap / /\v
vnoremap / /\v
" }}}

" Editing {{{
set nomodeline
set nowrap
set expandtab
set softtabstop=2
set shiftwidth=2

set hidden

set cursorline
set colorcolumn=+1,79

set background=dark
colorscheme lucius
LuciusDarkHighContrast
" }}}

" Miscelaneous {{{
" Get rid of startup nag
set shortmess+=I

set wildmode=list:longest,full

let mapleader=','
set pastetoggle=<F2>
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
