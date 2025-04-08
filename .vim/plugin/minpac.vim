function! s:manifest() abort
  let l:shared = [
        \ 'AndrewRadev/splitjoin.vim',
        \ 'mhinz/vim-signify',
        \ 'ledger/vim-ledger',
        \ 'romainl/vim-cool',
        \ 'romainl/vim-qf',
        \ 'tpope/vim-fugitive',
        \ 'tpope/vim-rhubarb',
        \ 'reedes/vim-pencil',
        \ 'tpope/vim-abolish',
        \ 'tpope/vim-repeat',
        \ ]

  let l:vim = [
        \ 'habamax/vim-select',
        \ 'prabirshrestha/asyncomplete-buffer.vim',
        \ 'prabirshrestha/asyncomplete-lsp.vim',
        \ 'prabirshrestha/asyncomplete.vim',
        \ 'prabirshrestha/vim-lsp',
        \ 'vim-test/vim-test',
        \ ]

  let l:nvim = [
        \ 'JoosepAlviste/nvim-ts-context-commentstring',
        \ 'b0o/schemastore.nvim',
        \ 'dcampos/cmp-snippy',
        \ 'dcampos/nvim-snippy',
        \ 'hrsh7th/cmp-buffer',
        \ 'hrsh7th/cmp-emoji',
        \ 'hrsh7th/cmp-nvim-lsp',
        \ 'hrsh7th/nvim-cmp',
        \ 'mfussenegger/nvim-lint',
        \ 'neovim/nvim-lspconfig',
        \ 'nvim-treesitter/nvim-treesitter',
        \ 'srstevenson/vim-picker',
        \ 'stevearc/conform.nvim',
        \ 'yioneko/nvim-vtsls',
        \ ]

  let l:plugins = l:shared + (has('nvim') ? l:nvim : l:vim)
  for plugin in l:plugins
    call minpac#add(plugin)
  endfor
endfunction

function! s:pack_init() abort
  let l:package_dir = has('nvim')
        \ ? stdpath('data') . '/site'
        \ : split(&packpath, ',')[0]
  let l:install_path = l:package_dir . '/pack/minpac/opt/minpac'

  if !isdirectory(l:install_path)
    call system(join([
          \ 'git', 'clone', '--filter=blob:none', '--branch=master',
          \ 'https://github.com/k-takata/minpac.git', l:install_path
          \ ], ' '))
  endif

  packadd minpac
  call minpac#init({ 'dir': l:package_dir })

  call minpac#add('k-takata/minpac', { 'type': 'opt' })
  call s:manifest()
endfunction

command! PackUpdate call s:pack_init() | call minpac#update()
command! PackClean call s:pack_init() | call minpac#clean()
