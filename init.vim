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

" Set the runtime path to include vim plug
call plug#begin()

set completeopt=longest,noinsert,menuone,noselect

" Git
" fugative
Plug 'tpope/vim-fugitive'
autocmd QuickFixCmdPost *grep* cwindow
" Git gutter
Plug 'airblade/vim-gitgutter'

" Plug 'shemerey/vim-project'

" Go integration
" Vim-go
Plug 'fatih/vim-go', { 'for': ['go'], 'do': ':GoInstallBinaries' }
" let g:go_fmt_command = 'goimports'
"
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" " Attempt at speeding up save timing
" " let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" let g:go_metalinter_autosave = 1

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
autocmd FileType go nmap <leader>bl <Plug>(go-build)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
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
let g:go_def_mode = 'gopls'
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

" Some refactoring tools
Plug 'godoctor/godoctor.vim'

" Fuzzy file loader
Plug 'ctrlpvim/ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" " file browser
" Plug 'scrooloose/nerdtree'
" nmap <leader>n :NERDTreeToggle<CR>

" Adds prens and brackts etc
Plug 'raimondi/delimitmate'

" fuzzy function search
Plug 'tacahiroy/ctrlp-funky'
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"  " database connection via Vim
"  " dbext
"  Plug 'vim-scripts/dbext.vim'
"  " Each profile has the form:
"  " g:dbext_default_profile_'profilename' = 'var=value:var=value:...'
"  " let g:dbext_default_profile_psql = 'type=PGSQL:host=localhost:port=5433:dbname=dvdtest:user=postgres'
"  :function ConnectSQLDb()
"  : let g:dbext_default_profile = 'psql'
"  : let g:dbext_default_profile_psql = 'type=PGSQL:host=localhost:port=5432:dbname=somedb:user=coderiot'
"  : let g:dbext_default_profile_psql = 'type=PGSQL:host=localhost:port=5432:dbname=dvdtest:user=postgres'
"  : let g:dbext_default_profile_dvdtest = 'type=PGSQL:host=localhost:port=5432:dbname=dvdtest:user=postgres'
"  : let g:dbext_default_profile_insol = 'type=PGSQL:host=localhost:port=5432:dbname=industrialSolutions:user=coderiot'
"  : autocmd VimEnter * DBCompleteTables
"  :endfunction
"  nnoremap <C-S-q> :call ConnectSQLDb()<cr>

" Emmet snippets
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','

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

" let g:ale_linters = {
"       \ 'sh':['language_server'],
"       \ 'go':['language_server'],
"       \}


" Display
" Provides Awesome Start Screen for vim
Plug 'mhinz/vim-startify'

" TODO configure properly
" gofmt like autoformater
Plug 'chiel92/vim-autoformat'
" auto formats on save
au BufWrite * :Autoformat
" file types for which autoindent shall not work
autocmd FileType dockerfile,yaml,yml,csv let b:autoformat_autoindent=0

" Css autoPrefixer
Plug 'ai/autoprefixer'
Plug 'ioannis-kapoulas/vim-autoprefixer'

" Auto resizing of vim windows
Plug 'roman/golden-ratio'

" color scheme
Plug 'mhinz/vim-janah'
autocmd ColorScheme janah highlight Normal ctermbg=235
autocmd VimEnter * colorscheme janah
" Plug 'sickill/vim-monokai'
" Plug 'tomasr/molokai'
" Plug 'rickharris/vim-monokai'
" " syntax enable
" autocmd VimEnter * colorscheme monokai
" let g:materialmonokai_italic=1
" let g:materialmonokai_subtle_spell=1
" set background=dark
" set termguicolors
" let g:airline_theme='materialmonokai'

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
let g:delve_backend = "native"
autocmd FileType go nmap <leader>t :DlvTest<CR>
autocmd FileType go nmap <leader>d :sp<CR>:e main.go<CR>:DlvDebug<CR>
autocmd FileType go nmap <leader>m :DlvDebug<CR>
autocmd FileType go nmap <leader>b :DlvToggleBreakpoint<CR>
autocmd FileType go nmap <leader>c :DlvClearAll<CR>

Plug 'go-delve/delve'

" Provides motions for camel case or underscored words, leader w, leader b,
" leader e. Seems super slow for some reason?
Plug 'bkad/CamelCaseMotion'


" coc completion interacts with langserver
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Use <Tab> and <S-Tab> for navigate completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <enter> to confirm complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
      \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" " based on ultisnips
" Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
"

" Typescript syntax Highlighting
Plug 'leafgarland/typescript-vim'

" icons for vim
Plug 'ryanoasis/vim-devicons'
set encoding=utf8

" docker syntax
Plug 'ekalinin/dockerfile.vim'

" i3 syntax highlighting
Plug 'potatoesmaster/i3-vim-syntax'

" markdown syntax
Plug 'plasticboy/vim-markdown'

" Plug 'shougo/echodoc'
" set cmdheight=2


" Initialize plugin system
call plug#end()
