" Disable compatibility with old-time vi
set nocompatible

" Sets \ as the leader for vim
let mapleader="\<space>"

" Resets autocmd
autocmd!

" Show matching brackets.
set showmatch

" middle-click paste with mouse
set mouse=v

" Tabs
" number of colums occupied by a tab char
set tabstop=2
" Sets the nubmer of columns for a TAB
set softtabstop=2
" number of space characters inserted for auto-indentation
set shiftwidth=2
" Converts tabs to whitespace
set expandtab

" autoindent
" set ai

" Filetype detection
filetype plugin indent on

" Incremental Search
set incsearch
" Ignore case while searching unless uppercase characters are used
set ignorecase
set smartcase
" Search Highlighting
set hlsearch
nmap <C-l> :nohlsearch<CR>

" Line Numbering
" add line numbers
set number
" Line number relative to cursor positon
set relativenumber

set cursorline

" get bash-like tab completions
set wildmode=longest,list,full

" codeRiot comands
" toggle spelling
nnoremap <leader>sp :set invspell<CR>

" scroll is offset so that the curser is always in the center of the screen
set scrolloff=999

" opens new pane on right of current pane
set splitright splitbelow

" Show the command being typed
set showcmd

" Keep indentation after wrapping and don't break words
set breakindent linebreak

" Allow hidden buffers
set hidden
" Set soft maximum line length
" set tw=80

" Don't redraw during macros/register usage
set lazyredraw

" write a buff when switching off to it
set autowrite

" Correctly set localrmdir so as to delete non empty directories
let g:netrw_localrmdir="rm -r"

" keybindings
"
nmap <leader>v :vsp<CR>
nmap <leader>s :sp<CR>
nmap <leader>z :sp<CR>:term<CR>

" enter newline before or after current line
nmap <C-o> O<Esc>j
nmap <CR> o<Esc>k
nmap <leader>j i<CR><Esc>k

" enter ; at end of line
inoremap ;<cr> <end>;
" enter , at end of line
inoremap ,<cr> <end>,
"
" << SCHEME AESTHETICS >> {{{
highlight Comment cterm=italic
highlight Comment gui=italic
highlight clear SignColumn
" }}}



" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall

endif

" install golang if not found
if !executable('go')
" need to set this up for later
endif

" Install python2 if it does not exist
if !executable('python2')
	!sudo apt install python2
	!sudo pip2 install pynvim
endif

" Install python3 if it does not exist
if !executable('python3')
	!sudo apt install python3
	!sudo pip3 install pynvim
endif

" Set the runtime path to include vim plug
call plug#begin()

set completeopt=longest,noinsert,menuone,noselect

" Git
" fugative
Plug 'tpope/vim-fugitive'
autocmd QuickFixCmdPost *grep* cwindow
" Git gutter
Plug 'airblade/vim-gitgutter'

" Go integration
" Vim-go
Plug 'fatih/vim-go', { 'for': ['go'], 'do': ':GoInstallBinaries' }
" Highlights parts of go code
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_term_mode='split'
let g:go_term_height=20
let g:go_term_enabled=1
" let g:go_def_mapping_enabled = 0

" Shortcuts to build, test and run Go programs
autocmd FileType go nmap <leader>bl <Plug>(go-build)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
autocmd FileType go nmap <leader>r <Plug>(go-run)
" Toggle GoCoverage
autocmd FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
" Alternating between gofiles
autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd FileType go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd FileType go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" Revert to godef as def tool
let g:go_def_mode = 'gopls'
let g:go_info_mode='gopls'
" Identifies what a function accepts and recieves
" Identifies a function signature
autocmd FileType go nmap <leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
" Automaticly highlights matching identifiers
let g:go_auto_sameids = 1
" All lists will be type quick
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>gde  call go#alternate#Switch(<bang>0, 'GoDecals')

" vim-go end

" Fuzzy file loader
Plug 'ctrlpvim/ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
" fuzzy function search
Plug 'tacahiroy/ctrlp-funky'
nnoremap <leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" " file browser
Plug 'scrooloose/nerdtree'
nmap <leader>n :NERDTreeToggle<CR>

" Adds prens and brackts etc
Plug 'raimondi/delimitmate'

" Linting
" Ale
Plug 'w0rp/ale'
" Set this. Airline will handle the rest.
" let g:stylelint#extensions#ale#enabled = 1
" let g:airline#extensions#ale#enabled = 1
" Enable completion where available.
" let g:ale_completion_enabled = 1

" Write this in your vimrc file
" let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0

" echo msg format
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" sets quickfix as output
let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
" navigation between erros
nmap <silent> <C-S-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-S-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
			\ 'sh':['bash-language_server'],
			\ 'php': ['intelephense'],
			\ 'dockerfile': ['docker-langserver'],
			\ 'go':['gopls'],
			\}


" Display
" Provides Awesome Start Screen for vim
" Plug 'mhinz/vim-startify'

" TODO configure properly
" gofmt like autoformater
Plug 'chiel92/vim-autoformat'
" auto formats on save
au BufWrite json,sh :Autoformat
" file types for which autoindent shall not work
" autocmd FileType dockerfile,yaml,yml,csv let b:autoformat_autoindent=0

" Auto resizing of vim windows
Plug 'roman/golden-ratio'

" color scheme
Plug 'mhinz/vim-janah'
autocmd ColorScheme janah highlight Normal ctermbg=235
autocmd VimEnter * colorscheme janah

" Css color pieview
Plug 'gorodinskiy/vim-coloresque'

" statusbar vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set ttimeoutlen=50
let g:airline_theme = 'powerlineish'
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled=1

" if you want to disable auto detect, comment out those two lines
let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = ['branch', 'hunks', 'coc']

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
" sets airline with nerd fonts
let g:airline_powerline_fonts = 1

" VimL completions
Plug 'Shougo/neco-vim'
" Provides completion bases on language syntax
Plug 'Shougo/neco-syntax'

" go debugging
Plug 'sebdah/vim-delve'
" Set the Delve backend.
let g:delve_new_command = "enew"
let g:delve_backend = "default"
autocmd FileType go nmap <leader>t :DlvTest<CR>
autocmd FileType go nmap <leader>d :sp<CR>:e main.go<CR>:DlvDebug<CR>
autocmd FileType go nmap <leader>m :DlvDebug<CR>
autocmd FileType go nmap <leader>b :DlvToggleBreakpoint<CR>
autocmd FileType go nmap <leader>c :DlvClearAll<CR>

Plug 'go-delve/delve'

" Provides motions for camel case or underscored words, leader w, leader b,
" leader e. Seems super slow for some reason?
" Plug 'bkad/CamelCaseMotion'

" jsonnet syntax highlight
Plug 'google/vim-jsonnet'
" toml syntax highlight
Plug 'toml-lang/toml'
" yaml syntax highlight and indent
Plug 'mrk21/yaml-vim'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" icons for vim
Plug 'ryanoasis/vim-devicons'
set encoding=utf8

" docker syntax
Plug 'ekalinin/dockerfile.vim'

" i3 syntax highlighting
Plug 'potatoesmaster/i3-vim-syntax'

" markdown syntax
Plug 'plasticboy/vim-markdown'
" set g:vim_markdown_folding_disabled = 1

" completion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
set cmdheight=2 " better display for messages
set updatetime=300 " smaller updatetime for cursorhold and cursorholdi
set shortmess+=c "dont give \|ins-completion-menu\| messages
set signcolumn=yes " always show sign columns

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<CR>" :
			\ coc#refresh()
inoremap <expr><S-CR> pumvisible() ? "\<C-p>" : "\<C-h>"<Paste>
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[c` and `]c` to navigate diagnostics
" interfeares while in vim diff
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd :sp<CR>:coc-definition<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>sr  :<C-u>CocList -I symbols<cr>

" Initialize plugin system
call plug#end()
