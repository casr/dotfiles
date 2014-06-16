set nocompatible
execute pathogen#infect()


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

function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    if exists('*mkdir')
      call mkdir(a:dir, 'p')
    else
      echo 'Unable to create directory: ' . a:dir
    endif
  endif

  if exists('*filewritable')
    if (filewritable(a:dir) != 2)
      echo 'Unable to write to directory: ' . a:dir
    endif
  endif
endfunction

" }}}


" Common settings {{{

set nomodeline
set nowrap
set expandtab
set softtabstop=4
set shiftwidth=4

set hlsearch
set ignorecase
set smartcase

set shortmess+=I

call EnsureDirExists($HOME . '/.vim/.swap')
set directory=$HOME/.vim/.swap,/tmp

if exists('+undofile')
  set undofile

  call EnsureDirExists($HOME . '/.vim/.undo')
  set undodir=$HOME/.vim/.undo,/tmp
endif

if exists('+colorcolumn')
  set colorcolumn=+1,79
endif

set wildmode=list:longest,full

if !exists('g:colors_name')
  "set background=dark

  if (&background == 'light')
    silent! colorscheme base16-google
  else
    silent! colorscheme base16-tomorrow
  endif
endif

" }}}


" Shortcuts {{{

let mapleader=','
set pastetoggle=<F2>
nnoremap / /\v
vnoremap / /\v
map <leader>c :%y*<CR>      " Copy file to system clipboard
nmap <silent> <leader>m :Make!<CR>
nmap <silent> <leader>f :QFix<CR>
nmap <silent> <leader>/ :nohlsearch<CR>

" }}}


" Plugin options {{{

let g:ctrlp_map='<leader>p'
let g:netrw_list_hide='\.DS_Store$'
let g:syntastic_mode_map = {'passive_filetypes': ['html']}

" }}}


" Autocmds {{{

if has("autocmd")
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

  autocmd BufReadPost fugitive://* set bufhidden=delete

  " Open the file from the last cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

  autocmd BufNewFile,BufRead */README setf markdown
endif

" }}}
