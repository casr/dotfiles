function! s:git_merge_base() abort
  return FugitiveExecute(['merge-base', 'origin', 'HEAD']).stdout[0]
endfunction

nmap <leader>gs <Cmd>Git<CR>
nmap <leader>gb <Cmd>Git blame<CR>
nmap <leader>gd :<C-u>Gvdiffsplit!<Space>
nmap <leader>gD :<C-u>Gvdiffsplit! <C-r>=<SID>git_merge_base()<CR><CR>
nmap <leader>gr :<C-u>Git difftool -y <C-r>=<SID>git_merge_base()<CR><CR>
nmap <leader>gf :<C-u>Git difftool --name-only <C-r>=<SID>git_merge_base()<CR><CR>

nmap <leader>q <Plug>(qf_qf_toggle)
nmap <leader>l <Plug>(qf_loc_toggle)

nmap <leader>yf <Cmd>let @+=fnamemodify(resolve(expand('%:p')), ':.')<CR>
nmap <leader>yF <Cmd>let @+=resolve(expand('%:p'))<CR>
nmap <leader>yy mm0"+y$`m
xmap <leader>yy "+ygv
nmap <leader>yG mmgg"+yG`m

" continue for vim-specific keymaps
" nvim-specific ones in keymap.lua
if has('nvim')
  finish
endif
