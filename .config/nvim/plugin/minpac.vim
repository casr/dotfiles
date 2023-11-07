let s:minpac_bootstrap = v:null
let s:install_path = stdpath('data') .. '/site/pack/minpac/opt/minpac'
if !isdirectory(s:install_path)
	echo 'installing minpac...'
	let s:minpac_bootstrap = system(['git', 'clone', 'https://github.com/k-takata/minpac.git', s:install_path])
endif

function! PackInit() abort
	packadd minpac
	call minpac#init({
		\ 'dir': stdpath('data') .. '/site',
	\ })

	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('AndrewRadev/splitjoin.vim')
	call minpac#add('JoosepAlviste/nvim-ts-context-commentstring')
	call minpac#add('b0o/schemastore.nvim')
	call minpac#add('casr/vim-colors-chromatine')
	call minpac#add('dcampos/cmp-snippy')
	call minpac#add('dcampos/nvim-snippy')
	call minpac#add('hrsh7th/cmp-buffer')
	call minpac#add('hrsh7th/cmp-emoji')
	call minpac#add('hrsh7th/cmp-nvim-lsp')
	call minpac#add('hrsh7th/nvim-cmp')
	call minpac#add('ledger/vim-ledger')
	call minpac#add('mhinz/vim-signify')
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('nvim-treesitter/nvim-treesitter')
	call minpac#add('reedes/vim-pencil')
	call minpac#add('srstevenson/vim-picker')
	call minpac#add('tpope/vim-apathy')
	call minpac#add('tpope/vim-commentary')
	call minpac#add('tpope/vim-eunuch')
	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-repeat')
	call minpac#add('tpope/vim-rhubarb')
	call minpac#add('tpope/vim-rsi')
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-unimpaired')
	call minpac#add('tpope/vim-vinegar')
endfunction

let s:minpac_manifest = stdpath('config') .. '/plugin/minpac.vim'

execute 'command! PackUpdate source ' .. s:minpac_manifest .. ' | call PackInit() | call minpac#update()'
execute 'command! PackClean source ' .. s:minpac_manifest .. ' | call PackInit() | call minpac#clean()'
command! PackStatus packadd minpac | call minpac#status()

if s:minpac_bootstrap isnot v:null
	call PackInit()
	call minpac#update()
endif
