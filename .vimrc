""
"" tubbo's vimrc
""


"" Vundle is used for dependency management
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/vimwiki'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'scrooloose/syntastic'
"Plugin 'skalnik/vim-vroom'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'leshill/vim-json'
Plugin 'kchmck/vim-coffee-script'
Plugin 'nono/vim-handlebars'
Plugin 'plasticboy/vim-markdown'
Plugin 'jnwhiteh/vim-golang'
Plugin 'toyamarinyon/vim-swift'

Plugin 'hsitz/VimOrganizer'
Plugin 'vim-scripts/utl.vim'
Plugin 'chrisbra/NrrwRgn'
Plugin 'itchyny/calendar.vim'

call vundle#end()     " required
filetype on
filetype plugin on
filetype indent on

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org            call org#SetOrgFileType()

let ruby_no_expensive=1
set re=1

"" Application

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
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,*~,._*
" Ignore Rails 2.x files
set wildignore+=vendor/rails**,vendor/plugins**

" Backup and swap files
set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.

" Easy saving of files
nnoremap Z :w<cr>
nnoremap ZZ :wq<cr>

" Easy command editing
nnoremap  ;  :

"" Configuration Editing

" Open Vim configuration in a new tab
map <leader>c :tabnew ~/.vimrc<cr>

" ,b to install the Bundle from within Vim
map <leader>b :PluginInstall<cr>:q<cr>

" Auto-load Vim configuration after a change
"autocmd BufWritePost *.vimrc nested source ~/.vimrc


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

let g:ctrlp_map = '<c-t>'
let g:ctrlp_custom_ignore = '\v(coverage|doc|tmp|node_modules|vendor\/bundle|vendor\/gems|[\/]\.(git|hg|svn)|tags)$'

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
map <leader>p :filetype plugin on<cr>
map <leader>/ <leader>p<leader>wt
" Vimwiki should use files in ~/Documents/Wiki
let g:vimwiki_list = [{ 'path': '~/Documents/Wiki', 'path_html': '~/Library/Application Support/Dash/DocSets/Wiki/Contents/Resources/Documents/' }]

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

"" Ruby

" Alternative Ruby extensions
autocmd BufEnter *.thor,*.rake,*file set filetype=ruby

" Alternative YAML extensions
"autocmd BufEnter *.gemrc set filetype=yaml
"autocmd BufEnter gemrc.erb set filetype=yaml
"autocmd BufEnter *.fdoc*,*.pv,Procfile set filetype=yaml

" Syntax highlighting for Rails & testing

" Disable wrapping in Rails view files
autocmd FileType erb,html,haml,emblem set nowrap
autocmd FileType erb,html,haml,emblem set tw=999
autocmd FileType markdown set ai formatoptions=tcroqn2 comments=n:&gt

" Use RSpec syntax for spec files and spec_helper
"autocmd BufEnter *_spec.rb,spec_*.rb set filetype=rspec

" Ignore 3rd-party Ruby files in searches
set wildignore+=vendor/gems/**

" Enforce Ruby 1.9 syntax on the line this command was called upon
map <leader>h :s/:\([a-z0-9_]\+\)\s*=>/\1: /g<cr>

" Run tests with Vim

" Configure Vroom to use RSpec and M as test runners.
let g:vroom_use_binstubs = 0
let g:vroom_use_colors = 1
let g:vroom_map_keys = 0
let g:vroom_spec_command = 'rspec --format=progress '
let g:vroom_test_unit_command = 'm'

" Run tests in a connected Tmux pane
let g:vroom_use_vimux = 1

" ,r runs the nearest test
nnoremap <leader>t :VroomRunNearestTest<cr>

" ,R runs the whole test file from inside Vim
nnoremap <leader>T :VroomRunTestFile<cr>

" ,. switches to the test alternate
nnoremap <leader>. :A<cr>

"" Javascript

" Alternative extensions for JS
autocmd BufEnter *.bowerrc set filetype=json
autocmd BufEnter Cakefile set filetype=coffee

" Ensure we're running on a 256-color terminal with UTF-8 encoding
set term=xterm-256color
set termencoding=utf-8

" Use the same font on the GUI that we use in the shell
set guifont=Monaco\ for\ Powerline:h14


"" Display

" Airline uses Powerline symbols
let g:airline_solarized_bg = 'dark'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {
      \'branch': '',
      \'readonly': '',
      \'linenr': ''}

"" Shell

" Alternative shell extensions
autocmd BufEnter *.bats set filetype=zsh

" When editing Makefiles, use tab characters instead of spaces
" while indenting the file.
autocmd BufEnter Makefile set filetype=make
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
