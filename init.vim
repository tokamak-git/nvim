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

"
"set foldmethod=syntax
"set foldlevel=1
"set foldclose=all

set cursorline 

" get bash-like tab completions
set wildmode=longest,list,full

" codeRiot comands
" toggle spelling
nnoremap <leader>s :set invspell<CR>

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
set tw=80

" Don't redraw during macros/register usage
set lazyredraw

" Enable folds but open them by default
""set foldenable foldlevelstart=10

" write a buff when switching off to it
set autowrite

" Easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" enter newline before or after current line
nmap <S-Enter> O<Esc>j
nmap <CR> o<Esc>k

" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Set the runtime path to include vim plug
call plug#begin()


Plug 'shemerey/vim-project'

" Go integration
" Vim-go
Plug 'fatih/vim-go', { 'for': ['go'], 'do': ':GoInstallBinaries' }
let g:go_fmt_command = 'goimports'

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" Attempt at speeding up save timing
" let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_autosave = 1

" Highlights parts of go code
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

" Shortcuts to build, test and run Go programs
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>r <Plug>(go-run)

" run :GoBuild or :GoTestCompile based on the go file
"function! s:build_go_files()
" let l:file = expand('%')
"  if l:file =~# '^\f\+_test\.go$'
"    call go#test#Test(0,1)
"  elseif l:file =~# '^\f\+\.go$'
"    call go#cmd#Build(0)
"  endif
"endfunction
" map function build_go_files to shortcut
"autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" Toggle GoCoverage
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
" Alternating between gofiles
autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd FileType go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd FileType go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" Revert to godef as def tool
let g:go_def_mode = 'godef'
" Identifies what a function accepts and recieves
" Identifies a function signature
autocmd FileType go nmap <leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
" Automaticly highlights matching identifiers
let g:go_auto_sameids = 1
" All lists will be type quick
" let g:go_list_type = 'quickfix'

" Times out go test default 10s
" let g:go_test_timeout = '10s'

" Moving between errors found by vim-go and closing the error window
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
" vim-go end

" Snippets
Plug 'SirVer/ultisnips'

" Fuzzy file loader
Plug 'ctrlpvim/ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


" database connection via Vim
" dbext
Plug 'vim-scripts/dbext.vim'
" Each profile has the form:
" g:dbext_default_profile_'profilename' = 'var=value:var=value:...'
" let g:dbext_default_profile_psql = 'type=PGSQL:host=localhost:port=5433:dbname=dvdtest:user=postgres'
:function ConnectPsqlDb()
: let g:dbext_default_profile = 'psql'
: let g:dbext_default_profile_psql = 'type=PGSQL:host=localhost:port=5432:dbname=dvdtest:user=postgres'
: let g:dbext_default_profile_dvdtest = 'type=PGSQL:host=localhost:port=5432:dbname=dvdtest:user=postgres'
: let g:dbext_default_profile_insol = 'type=PGSQL:host=localhost:port=5432:dbname=industrialSolutions:user=coderiot'
: autocmd VimEnter * DBCompleteTables
:endfunction
nnoremap <C-S-q> :call ConnectPsqlDb()<cr>

" Emmet snippets
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','

" Linting	
" Ale
Plug 'w0rp/ale'
" Set this. Airline will handle the rest.
let g:stylelint#extensions#ale#enabled = 1
let g:airline#extensions#ale#enabled = 1
" Enable completion where available.
" let g:ale_completion_enabled = 1
" echo msg format
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" sets quickfix as output
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
" navigation between erros
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" js linting
let g:neomake_javascript_enabled_makers = ['eslint']
" HTML Linting
let g:neomake_html_enabled_makers = ['htmlhint']
" markdown linting
let g:neomake_markdown_enabled_makers = ['mdl']

" Display
" Provides Awesome Start Screen for vim
Plug 'mhinz/vim-startify'

" Css autoPrefixer
Plug 'ai/autoprefixer'
Plug 'ioannis-kapoulas/vim-autoprefixer'

" Auto resizing of vim windows
Plug 'roman/golden-ratio'

" adds git info to gutter
Plug 'airblade/vim-gitgutter'

" color scheme !!Not working correctly
Plug 'MaxSt/FlatColor'
" autocmd VimEnter * colorscheme flatcolor
" colorscheme flatcolor
Plug 'mhinz/vim-janah'
autocmd ColorScheme janah highlight Normal ctermbg=235
colorscheme janah
" autocmd VimEnter * colorscheme janah

" Css color preview
Plug 'gorodinskiy/vim-coloresque'

" automatic tag generation
Plug 'ludovicchabant/vim-gutentags'

" Tagbar Class ourliner
Plug 'majutsushi/tagbar'
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }
nmap <F8> :TagbarToggle<CR>

" adds liteline status bar to bottom 
" Plug 'itchyny/lightline.vim'
" let g:lightline = { 'colorscheme': 'flatcolor' }
" statusbar vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1

" Code Completion
" set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect
" close preview on exit of insert
autocmd InsertLeave * pclose

" Deocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
" function not found error
"call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])

"Javascript Plugins
Plug 'carlitux/deoplete-ternjs'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

"Typescript Plugins
" Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Plug 'Quramy/tsuquyomi', { 'do': 'npm install -g typescript' }
" Plug 'mhartington/deoplete-typescript'
" let g:deoplete#sources#tss#javascript_support = 1
" let g:tsuquyomi_javascript_support = 1
" let g:tsuquyomi_auto_open = 1
" let g:tsuquyomi_disable_quickfix = 1

Plug 'zchee/deoplete-go', { 'for': ['go'], 'do': 'make' }
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = [ 'package', 'func', 'type', 'var', 'const' ]
" Support go pointer match
let g:deoplete#sources#go#pointer = 1

" Flow enabled javascript autocomplete for deoplete
Plug 'wokalski/autocomplete-flow'

" VimL completions
Plug 'Shougo/neco-vim'
" Provides completion bases on language syntax
Plug 'Shougo/neco-syntax'

"debugging
Plug 'sebdah/vim-delve'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Provides motions for camel case or underscored words, leader w, leader b,
" leader e. Seems super slow for some reason?
Plug 'bkad/CamelCaseMotion'


" Vertical alignment
Plug 'godlygeek/tabular'

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Minimal LSP configuration for JavaScript
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'html': ['html-languageserver'],
    \ 'css': ['css-languageserver'],
    \ 'json': ['json-languageserver'],
    \ 'go': ['go-langserver'] }

noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
noremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
noremap <silent> R :call LanguageClient_textDocument_rename()<CR>

" Use LanguageServer for omnifunc completion
autocmd FileType go setlocal omnifunc=LanguageClient#complete
autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
autocmd FileType html setlocal omnifunc=LanguageClient#complete
autocmd FileType css setlocal omnifunc=LanguageClient#complete
autocmd FileType json setlocal omnifunc=LanguageClient#complete


" (Optional) Multi-entry selection UI.
Plug 'Shougo/denite.nvim'

" (Optional) Completion integration with nvim-completion-manager.
Plug 'roxma/nvim-completion-manager'

" (Optional) Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

" icons for vim
Plug 'ryanoasis/vim-devicons'
set encoding=utf8
" set guifont=DroidSansMono\ Nerd\ Font\ 11
" sets airline with nerd fonts
let g:airline_powerline_fonts = 1


" Initialize plugin system
call plug#end()

" << SCHEME AESTHETICS >> {{{

highlight Comment cterm=italic
highlight Comment gui=italic
highlight clear SignColumn
" }}}
