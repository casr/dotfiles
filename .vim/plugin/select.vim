let g:select_info = get(g:, 'select_info', {})

function! s:exclude_find_paths(paths) abort
	let l:fuzzy_paths = join(map(copy(a:paths), "'-path \"' . v:val . '\"'"), ' -o ')

	return 'find -L . \( ' . l:fuzzy_paths . ' \) -prune -o -type f -print'
endfunction

let s:exclude_paths = [
			\ '*.pyc',
			\ '*/.DS_Store',
			\ '*/.git/*',
			\ '*/.idea/*',
			\ '*/.next/*',
			\ '*/.storybook/*',
			\ '*/.turbo/*',
			\ '*/.venv/*',
			\ '*/.vscode/*',
			\ '*/__pycache__/*',
			\ '*/node_modules/*',
			\ '*/venv/*',
			\ ]

let g:select_info.casr_file = {}
let g:select_info.casr_file.data = {'job': s:exclude_find_paths(s:exclude_paths)}
let g:select_info.casr_file.sink = {
	\ 'transform': {p, v -> fnameescape(resolve(p..v))},
	\ 'action': 'edit %s',
	\ 'action2': 'split %s',
	\ 'action3': 'vsplit %s',
	\ 'action4': 'tab split %s'
	\ }
let g:select_info.casr_file.highlight = {'DirectoryPrefix': ['\(\s*\d\+:\)\?\zs.*[/\\]\ze.*$', 'Comment']}
let g:select_info.casr_file.prompt = 'Select File> '
