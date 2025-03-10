augroup plugin_colorscheme
	autocmd!
	autocmd ColorScheme chromatine
		\   hi! link LspInformationText chromatineComment
		\ | hi! link LspInformationVirtualText LspInformationText
		\ | hi! link LspInformationHighlight chromatineUnderlined
		\ | hi! link LspErrorText chromatineErrorMsg
		\ | hi! link LspWarningText chromatineVisual
		\ | hi! link LspHintText chromatineLineNC
		\ | hi! link LspErrorHighlight chromatineUnderlined
		\ | hi! link LspWarningHighlight chromatineUnderlined
		\ | hi! link LspHintHighlight chromatineUnderlined
		\ | hi! link LspErrorVirtualText chromatineErrorMsg
		\ | hi! link LspWarningVirtualText chromatineVisual
		\ | hi! link LspHintVirtualText chromatineLineNC
augroup END
