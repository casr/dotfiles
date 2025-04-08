if has('nvim') | finish | endif

if executable('pyright-langserver')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyright-langserver',
        \ 'cmd': {server_info->['pyright-langserver', '--stdio']},
        \ 'allowlist': ['python'],
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(
        \     lsp#utils#find_nearest_parent_file_directory(
        \         lsp#utils#get_buffer_path(),
        \         ['pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git/..']
        \     )
        \ )},
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
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(
        \     lsp#utils#find_nearest_parent_file_directory(
        \         lsp#utils#get_buffer_path(),
        \         ['tsconfig.json', 'package.json', 'jsconfig.json', '.git/..']
        \     )
        \ )},
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
