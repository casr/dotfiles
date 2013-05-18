set nocompatible

execute pathogen#infect()

filetype plugin indent on


" Mostly taken from Vincent Driessen's vimrc (inc comments).
" https://github.com/nvie/vimrc/blob/master/vimrc

let g:netrw_list_hide='\.DS_Store$'

" Change the mapleader from \ to ,
let mapleader=","

" Editing behaviour {{{
set showmode                    " always show what mode we're currently
                                "   editing in
set nowrap                      " don't wrap lines
set tabstop=8                   " a tab is x spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is
                                "   removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per
                                "   file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting
                                "   with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert
                                "   mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on
                                "   autoindenting
"set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all
                                "   lowercase, case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line
                                "   according to shiftwidth, not tabstop
set scrolloff=7                 " keep x lines off the edges of the screen
                                "   when scrolling
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

set nolist                      " don't show invisible characters by default,
                                "   but it is enabled for some file types
                                "   (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "   paste mode, where you can paste mass
                                "   data that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "   supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "   with 1-letter words (looks stupid)
set colorcolumn=80              " Show right margin

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
" Use more perl-like regexes when searching.
nnoremap / /\v
vnoremap / /\v

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" }}}

" Editor layout {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing
                                "   macros
set laststatus=2                " tell VIM to always put a status line in,
                                "   even if there is only one window
"set cmdheight=2                 " use a status bar that is 2 rows high
" }}}

" Vim behaviour {{{
set hidden                      " hide buffers instead of closing them this
                                "   means that the current buffer can be put
                                "   to background without being written; and
                                "   that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                "   quickfix window instead of opening new
                                "   buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set nobackup                    " do not keep backup files, it's 70's style
                                "   cluttering
set noswapfile                  " do not write annoying intermediate swap
                                "   files, who did ever restore from swap
                                "   files anyway?
set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "   (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "   than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act
                                "   like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "   first full match
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
"set visualbell                  " don't beep
"set noerrorbells                " don't beep
set ruler                       " show the col, line info
set showcmd                     " show (partial) command in the last line of
                                "   the screen this also shows visual
                                "   selection info
set nomodeline                  " disable mode lines (security measure)

" Set a new ctrlp shortcut.
let g:ctrlp_map = '<leader>p'

" Copy everything to the * register (clipboard)
map <leader>c :%y*<CR>

" Quick make.
nmap <silent> <leader>m :make<CR>

" Tame the quickfix window (open/close using ,f)
nmap <silent> <leader>f :QFix<CR>

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

" Highlighting {{{

if &t_Co > 2 || has("gui_running")
    syntax on                    " switch syntax highlighting on, when the
                                 "   terminal has colors
    set t_Co=16
    set background=dark
    colorscheme desert
endif

" if &t_Co >= 256 || has("gui_running")
"     colorscheme github
" endif

if has("gui_running")
    set guioptions-=T
endif

set shortmess+=I

" }}}

" Shortcut mappings {{{

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" }}}

if has("autocmd")
    autocmd User fugitive
        \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
        \   nnoremap <buffer> .. :edit %:h<CR> |
        \ endif

    autocmd BufReadPost fugitive://* set bufhidden=delete

    " open the file from the last cursor position.
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
endif
