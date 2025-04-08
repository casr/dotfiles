function! StatuslineFormatDirectory() abort
  let l:fugitive_prefix = matchlist(
        \ expand('%:p'),
        \ '\vfugitive:///.{-}/\.git/(\d?)/(\x{40,})/(.*)/')

  if l:fugitive_prefix ==# []
    return fnamemodify(resolve(expand('%:p')), ':.:h')
  else
    return 'fugitive://'
          \ . l:fugitive_prefix[1] . '/'
          \ . strpart(l:fugitive_prefix[2], 0, 10) . '/'
          \ . l:fugitive_prefix[3]
  endif
endfunction

" Sample status line:
" vimrc[+] [Git(main)]                      .dotfiles/.vim | dos | vim |  32%
" statusline.vim    [Git:91b4ea5(combine)] <8/.vim/plugin | unix | vim | 100%
" options.txt                                          . | unix | help |   9%

set statusline=
" <filename>
set statusline+=\ %t
" save-state
set statusline+=%-3.(%{&modified?&readonly?'[-]':'[+]':''}%)
" git status
set statusline+=%(\ %{FugitiveStatusline()}%)
" separation point
set statusline+=%=
" <directory>, truncate from start
set statusline+=%(\ %<%{StatuslineFormatDirectory()}\ %)
" show line endings
set statusline+=%(\|\ %{&fileformat}\ %)
" filetype
set statusline+=%(\|\ %{&filetype==''?'no\ ft':&filetype}\ %)
" percent through the file
set statusline+=\|%6.(\ %p%%\ %)
