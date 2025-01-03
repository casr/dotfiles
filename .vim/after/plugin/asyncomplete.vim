if !exists('g:asyncomplete_loaded')
	finish
endif

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
	\ 'name': 'buffer',
	\ 'allowlist': ['*'],
	\ 'completor': function('asyncomplete#sources#buffer#completor'),
	\ }))
