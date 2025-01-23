augroup plugin_colorscheme
	autocmd!
	autocmd ColorScheme chromatine
		\   hi link LspInformationText Comment
		\ | hi link LspInformationVirtualText LspInformationText
		\ | hi link LspInformationHighlight Comment
		\ | if &background ==# 'light'
		\ |     hi LspErrorText ctermfg=131
		\ |     hi LspWarningText ctermfg=172
		\ |     hi LspHintText ctermfg=243
		\ | else
		\ |     hi LspErrorText ctermfg=131
		\ |     hi LspWarningText ctermfg=222
		\ |     hi LspHintText ctermfg=245
		\ | end
		\ | hi link LspErrorHighlight LspErrorText
		\ | hi link LspWarningHighlight LspWarningText
		\ | hi link LspHintHighlight LspHintText
		\ | hi link LspErrorVirtualText LspErrorText
		\ | hi link LspWarningVirtualText LspWarningText
		\ | hi link LspHintVirtualText LspHintText
augroup END
