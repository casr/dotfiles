" Vim color file
" Maintainer: Chris Rawnsley <chris@puny.agency>
" Version: 1.0.0
" Last change: 2020 May 3
" Website: https://www.example.com/
"
" A monochrome theme that sets no colours and resets all of Vim’s defaults

hi clear
if exists('syntax_on')
	syntax reset
endif

let g:colors_name = 'normalize'

hi Normal ctermfg=NONE ctermbg=NONE

hi Directory term=NONE ctermfg=NONE guifg=NONE
" hi link EndOfBuffer NonText
hi ErrorMsg term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
" hi VertSplit
" hi IncSearch
hi LineNr term=NONE ctermfg=NONE guifg=NONE
hi CursorLineNr cterm=bold ctermfg=NONE guifg=NONE
hi MatchParen term=bold cterm=bold ctermbg=NONE guibg=NONE
hi ModeMsg term=NONE cterm=NONE gui=NONE
hi MoreMsg term=NONE ctermfg=NONE gui=NONE guifg=NONE
hi NonText term=NONE ctermfg=NONE gui=NONE guifg=NONE
hi Pmenu term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guibg=NONE
" TODO PmenuSel there looks to be a bug with Vim not clearing escape codes?
hi PmenuSel ctermfg=NONE ctermbg=NONE guibg=NONE
hi PmenuSbar ctermbg=NONE guibg=NONE
hi PmenuThumb ctermbg=NONE guibg=NONE
hi Question term=NONE ctermfg=NONE gui=NONE guifg=NONE
" hi link QuickFixLine Search
hi Search cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
hi SpecialKey term=NONE ctermfg=NONE guifg=NONE
hi StatusLine term=reverse cterm=reverse gui=reverse
hi StatusLineNC term=NONE cterm=NONE gui=NONE
hi TabLine term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guibg=NONE
" hi TabLineFill
hi TabLineSel term=NONE cterm=NONE gui=NONE
hi Title cterm=bold ctermfg=NONE gui=bold guifg=NONE
hi Visual term=reverse cterm=reverse ctermbg=NONE gui=reverse guibg=NONE
hi WarningMsg term=reverse cterm=reverse ctermfg=NONE gui=reverse guifg=NONE

if has('clipboard')
	hi VisualNOS term=reverse cterm=reverse gui=reverse
endif

if has('diff')
	hi DiffAdd cterm=bold ctermbg=NONE gui=bold guibg=NONE
	hi DiffChange cterm=bold ctermbg=NONE gui=bold guibg=NONE
	hi DiffDelete cterm=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
	hi DiffText cterm=reverse ctermbg=NONE gui=reverse guibg=NONE
endif

if has('folding')
	hi Folded term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
	hi FoldColumn term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

" TODO Do any of the GUIs actually care about these settings? (only tried in
" GTK+, admittedly...)
" if has('menu')
" 	hi ToolbarLine term=underline ctermbg=LightGrey guibg=Blue
" 	hi ToolbarButton cterm=bold ctermfg=White ctermbg=DarkGrey gui=bold guifg=White guibg=Grey40
" endif

if has('spell')
	hi SpellBad term=underline cterm=underline ctermbg=NONE guisp=NONE
	hi SpellCap term=underline cterm=underline ctermbg=NONE guisp=NONE
	hi SpellLocal term=underline cterm=underline ctermbg=NONE guisp=NONE
	hi SpellRare term=NONE ctermbg=NONE guisp=NONE
endif

if has('syntax')
	hi ColorColumn cterm=reverse ctermbg=NONE gui=reverse guibg=NONE
	hi CursorColumn term=NONE ctermbg=NONE guibg=NONE
	hi CursorLine term=NONE cterm=NONE guibg=NONE

	hi Comment term=NONE ctermfg=NONE guifg=NONE
	hi Constant term=NONE ctermfg=NONE guifg=NONE
	hi Special term=NONE ctermfg=NONE guifg=NONE
	hi Identifier term=NONE cterm=NONE ctermfg=NONE guifg=NONE
	hi Statement term=NONE ctermfg=NONE gui=NONE guifg=NONE
	hi PreProc term=NONE ctermfg=NONE guifg=NONE
	hi Type term=NONE ctermfg=NONE gui=NONE guifg=NONE
	hi Underlined ctermfg=NONE guifg=NONE
	hi Ignore ctermfg=NONE guifg=NONE
	hi Error cterm=reverse ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
	hi Todo term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

if has('wildmenu')
	hi WildMenu term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

if has('conceal')
	hi Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
endif

if has('signs')
	hi SignColumn term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

if has('terminal')
	hi StatusLineTerm term=reverse cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
	hi StatusLineTermNC term=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
endif

finish

" How to trigger various highlight groups
" =======================================
"
" Normal - main background and text colour
"
" Directory - :Ex /
" EndOfBuffer - the tildes at the end of the buffer
" ErrorMsg - :echoerr 'My error'
" VertSplit - open a vertical split and see the bar
" IncSearch - set incsearch and then :%s/mysearch it will highlight as you type
" LineNr - the numbers after :set number
" CursorLineNr - same as above but specific to the line the cursor is on
" MatchParen - a matching pair of brackets
" ModeMsg - enter insert mode to see the style
" MoreMsg - view the output of a long command like :hi or :map
" NonText - :set nowrap, write a long line and the character that shows at the end of the screen
" Pmenu - enter insert mode, type a letter and then press C-n
" PmenuSel - as above, selected item
" PmenuSbar - as above, scroll bar
" PmenuThumb - as above, scroll bar position
" Question term=NONE ctermfg=NONE gui=NONE guifg=NONE
" QuickFixLine - :vimgrep 'a' %:h/**, :copen, <CR>. Highlights line
" Search - /Search
" SpecialKey - :set list or :map
" StatusLine - :set laststatus=2, active status bar
" StatusLineNC - :sp, inactive status bar
" TabLine - :tabnew, inactive tab colour and close button
" TabLineFill - the space between tabs and the right-hand side
" TabLineSel - selected tab
" Title - the number in a tab when it has more than one window
" Visual - V
" WarningMsg - perform a search then let it wrap
"
" VisualNOS - when Vim loses the X selection but is still in visual mode
"
" DiffAdd - vim -d /tmp/a /tmp/b
" DiffChange - as above
" DiffDelete - as above
" DiffText - as above, this is the text that changed in DiffChange line
"
" Folded - how a fold looks
" FoldColumn - how fold areas are displayed in the fold column
"
" ToolbarLine - ???
" ToolbarButton - ???
"
" SpellBad - :set spell spelllang=en_gb, teh
" SpellCap - as above, start sentence without a capital
" SpellLocal - as above, color vs colour
" SpellRare - ?
"
" ColorColumn - :set colorcolumn=80
" CursorColumn - :set cursorcolumn
" CursorLine - :set cursorline
"
" Comment - based on a language's syntax file
" Constant - based on a language's syntax file
" Special - based on a language's syntax file
" Identifier - based on a language's syntax file
" Statement - based on a language's syntax file
" PreProc - based on a language's syntax file
" Type - based on a language's syntax file
" Underlined - based on a language's syntax file
" Ignore - based on a language's syntax file
" Error - based on a language's syntax file
" Todo - based on a language's syntax file
"
" WildMenu - :e /<Tab>
"
" Conceal - :set conceallevel=1, write out a link in Markdown
"
" SignColumn - :set signcolumn=yes
"
" StatusLineTerm - :terminal
" StatusLineTermNC - as above but not the current window, <Esc><C-w><C-w>
