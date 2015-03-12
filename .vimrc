""
"" tubbo's vimrc
""


"" Plugins

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/vimwiki'
Plugin 'itchyny/calendar.vim'
Plugin 'scrooloose/syntastic'
Plugin 'skalnik/vim-vroom'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-fugitive'
Plugin 'cyphactor/vim-open-alternate'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'rizzatti/dash.vim'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'leshill/vim-json'
Plugin 'kchmck/vim-coffee-script'
Plugin 'plasticboy/vim-markdown'
Plugin 'nono/vim-handlebars'
Plugin 'jnwhiteh/vim-golang'
Plugin 'toyamarinyon/vim-swift'
Plugin 'briancollins/vim-jst'

call vundle#end()


"" File Type Handling

filetype on
filetype plugin on
filetype indent on


"" Basic Settings

" No need to be backwards-compatible with Vi
set nocompatible

" Show line numbers
set number

" Show line/column ruler
set ruler

" Use UTF-8 as our default charset
set encoding=utf-8

" Use the default login shell inside Vim
set shell=$SHELL

" Automatically reload files when a change occurs
set autoread

" Show partial command in the status line
set showcmd

" Use the system clipboard
set clipboard=unnamed

" Set leader key to ','
let mapleader = ","

" Turn backups off since we store everything in Git
set nobackup
set nowb
set noswapfile

" Keep undo persisted across sessions
set undodir=~/.vim/undo
set undofile

" Disable sounds and visual bells
set noerrorbells visualbell t_vb=
"autocmd GUIEnter * set visualbell t_vb=

" Whitespace settings
set wrap                          " turn word wrap on
set textwidth=72                  " attempt to enforce 72 chars
set linebreak                     " wait for word char to break lines
set tabstop=2                     " a tab is two spaces
set smartindent                   " automatic indentation
set autoindent
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

" View invisible characters
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen

" Ignore files that Vim can't edit
set wildignore=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,*~,._*
" Ignore Ruby deps
set wildignore+=vendor/rails**,vendor/plugins**,vendor/gems/**
" Ignore Mac & Git files
set wildignore+=.DS_Store,.gitkeep,.keep
" Ignore JS deps
set wildignore+=bower_components,node_modules

" Backup and swap files
set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.


"" Key Bindings

nnoremap Z :w<cr>
nnoremap ZZ :wq<cr>
nnoremap  ;  :

map <leader>c :e ~/.vimrc<cr>
map <leader>b :PluginInstall<cr>:q<cr>
map <leader>m :execute '! mkdir -p '.shellescape(expand("%:p:h"))<cr>

"" Search

" Search docs with Dash.app
map <leader>d :Dash!<cr>

" Highlight search terms by default
set nohlsearch
nnoremap <C-L> :set hlsearch!<cr>
nnoremap <C-l> :nohl<cr>

" In-file fulltext search options
set hlsearch!   " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

"" Search project files with CtrlP
let g:ctrlp_map = '<c-t>'
let g:ctrlp_custom_ignore = '\v(coverage|doc|tmp|bower_components|node_modules|vendor\/bundle|vendor\/gems|[\/]\.(git|hg|svn)|tags|dist|public\/articles|public\/pages)$'
let g:ctrlp_extensions = ['tag', 'mixed']
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 2
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
map <leader>f :CtrlPTag<cr>

map <c-x> :bd<cr>

"" Tab key

" Use <tab> for autocompletion in INSERT mode by checking for a space
" on the next column. If there is one, insert a 'tab'. Otherwise, try
" to autocomplete the word prior to the current column.
function! InsertTabWrapper()
let col = col('.') - 1
if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
else
    return "\<c-p>"
endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

"" Navigation

" Alternate through tabs
map <leader>m :tabn<cr>
map <C-w>t :tabn<cr>

" Remap :W => :w to avoid errors
command! W w
command! Q q
map ; :

" Disable code folding
set foldmethod=manual
set foldlevel=99

" For tmux, disable background clearing
set t_ut=

"" Git and GitHub

" Copy Gists to clipboard after creation
let g:gist_clip_command = 'pbcopy'

" Detect filetype by file extension (just like on gist.github.com)
let g:gist_detect_filetype = 1

" Post all Gists as private unless otherwise noted
let g:gist_post_private = 1

" Enable multi-file Gists
let g:gist_get_multiplefile = 1

" Use ,g to create a single-file Gist
map <leader>g :Gist<cr>

" Use ,G to create a multi-file Gist of all buffers
map <leader>G :Gist -m<cr>

"" Vimwiki

" Open Vimwiki
map <leader>/ :cd ~/Documents/Wiki<cr><leader>ww
map <leader>wc :VimwikiAll2HTML<cr>
" Vimwiki should use files in ~/Documents/Wiki
let vimwiki_path=$HOME.'/Documents/Wiki'
let vimwiki_html_path=$HOME.'/Code/dubya/public'
let g:vimwiki_use_calendar = 1
let g:vimwiki_list = [{  'path':vimwiki_path,
                       \ 'path_html':vimwiki_html_path,
                       \ 'template_path':vimwiki_html_path.'/assets/',
                       \ 'template_default': 'default',
                       \ 'template_ext': '.tpl',
                       \ 'auto_export': 0}]

" Disable modelines for security
set modelines=0

"" MacVim

" Special MacVim configuration (must be in vimrc for some reason)
if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

"" Cosmetics

" Use solarized-light as a color scheme
let g:solarized_italic=0
syntax on
colorscheme solarized
set background=light

" When opening a file, jump to the last cursor position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif


"" Markdown

autocmd BufEnter *.md.html set filetype=markdown
autocmd FileType markdown set ai formatoptions=tcroqn2 comments=n:&gt
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

"" Ruby

autocmd BufEnter *.thor,*.rake,*file,*.ru set filetype=ruby
autocmd BufEnter *.gemrc set filetype=yaml
autocmd BufEnter gemrc.erb set filetype=yaml
autocmd BufEnter *.fdoc*,*.pv,Procfile set filetype=yaml

let ruby_no_expensive=1


"" Javascript

autocmd BufEnter *.bowerrc set filetype=json
autocmd BufEnter Cakefile set filetype=coffee


"" User Interface

set guifont=Monaco\ for\ Powerline:h14
set term=xterm-256color
set termencoding=utf-8
set shell=/bin/zsh

"" Airline

let g:airline_solarized_bg = 'dark'
let g:airline_inactive_collapse=0
let g:airline_detect_paste=1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {
      \'branch': '',
      \'readonly': '',
      \'linenr': ''}

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#whitespace#enabled = 1

let g:airline#extensions#ctrlp#color_template = 'replace'
let g:airline#extensions#tabline#buffer_idx_mode = 1


"" Shell Script

" Alternative shell extensions
autocmd BufEnter *.bats set filetype=zsh


"" Make

autocmd BufEnter Makefile set filetype=make
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0


"" Syntastic

let g:syntastic_ruby_checkers = ["mri"]
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "$"
let g:syntastic_style_warning_symbol = "$"


"" Vroom

let g:vroom_clear_screen = 0
let g:vroom_use_spring = 0
let g:vroom_use_bundle_exec = 1
let g:vroom_use_binstubs = 0
let g:vroom_use_colors = 1
let g:vroom_map_keys = 0
let g:vroom_spec_command = 'rspec --format=documentation '
let g:vroom_use_vimux = 0

nnoremap <leader>t :VroomRunNearestTest<cr>
nnoremap <leader>T :VroomRunTestFile<cr>
nnoremap <leader>. :OpenAlternate<cr>


"" Help

map <c-h> :h 
autocmd FileType help wincmd L

