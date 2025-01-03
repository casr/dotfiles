if executable('pyright-langserver')
	autocmd User lsp_setup call lsp#register_server({
		\ 'name': 'pyright-langserver',
		\ 'cmd': {server_info->['pyright-langserver', '--stdio']},
		\ 'allowlist': ['python'],
		\ 'workspace_config': {
		\   'python': {
		\     'analysis': {
		\       'useLibraryCodeForTypes': v:true
		\     },
		\   },
		\ }
	\ })
endif

if executable('vtsls')
	autocmd User lsp_setup call lsp#register_server({
		\ 'name': 'vtsls',
		\ 'cmd': {server_info->['vtsls', '--stdio']},
		\ 'allowlist': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue'],
		\ 'workspace_config':  {
		\   'typescript': {
		\     'inlayHints': {
		\       'parameterNames': {
		\         'enabled': 'all',
		\       },
		\       'parameterTypes': {
		\         'enabled': v:true,
		\       },
		\       'variableTypes': {
		\         'enabled': v:true,
		\       },
		\       'propertyDeclarationTypes': {
		\         'enabled': v:true,
		\       },
		\       'functionLikeReturnTypes': {
		\         'enabled': v:true,
		\       },
		\       'enumMemberValues': {
		\         'enabled': v:true,
		\       },
		\     },
		\   },
		\   'javascript': {
		\     'inlayHints': {
		\       'parameterNames': {
		\         'enabled': 'all',
		\       },
		\       'parameterTypes': {
		\         'enabled': v:true,
		\       },
		\       'variableTypes': {
		\         'enabled': v:true,
		\       },
		\       'propertyDeclarationTypes': {
		\         'enabled': v:true,
		\       },
		\       'functionLikeReturnTypes': {
		\         'enabled': v:true,
		\       },
		\       'enumMemberValues': {
		\         'enabled': v:true,
		\       },
		\     },
		\   },
		\ },
	\ })
endif
