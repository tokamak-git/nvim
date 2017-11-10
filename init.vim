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
set foldmethod=syntax
set foldlevel=1
set foldclose=all

" get bash-like tab completions
set wildmode=longest,list

" codeRiot comands
" toggle spelling
nnoremap <leader>s :set invspell<CR>

" scroll is offset so that the curser is always in the center of the screen
set scrolloff=999

" Set the runtime path to include vim plug
call plug#begin()
" Go integration
" Vim-go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
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
" autowrite file when :make or :GoBuild is called
set autowrite

" Shortcuts to build, test and run Go programs
" autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>r <Plug>(go-run)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0,1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
" map function build_go_files to shortcut
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
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
" Syntactistic
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

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
Plug 'itchyny/lightline.vim'
" let g:lightline = { 'colorscheme': 'flatcolor' }


" Code Completion
" set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect
" close preview on exit of insert
autocmd InsertLeave * pclose

" Deocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'zchee/deoplete-go', { 'do': 'make' }
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

" Initialize plugin system
call plug#end()
