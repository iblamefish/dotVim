""""""""""
" Vundle
""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Bundle 'hallettj/jslint.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-surround'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'sjl/gundo.vim'
Bundle 'mattn/emmet-vim'
Bundle 'Raimondi/delimitMate'
Bundle 'bling/vim-airline'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'scrooloose/syntastic'
Bundle 'pangloss/vim-javascript'
if has("python")
  Bundle 'marijnh/tern_for_vim'
  Bundle 'Valloric/YouCompleteMe'
else
  Bundle 'Shougo/neocomplcache'
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_min_syntax_length = 3

endif
Bundle 'kien/rainbow_parentheses.vim'

Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'

let g:ctrlp_custom_ignore = '\v[\/](node_modules)|\.(git|hg|svn)$'

Bundle 'scrooloose/nerdtree'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

filetype on
filetype indent on
filetype plugin on


""""""""""""""
" housekeeping
""""""""""""""
set encoding=utf-8 nobomb
set ruler
set shiftwidth=2 softtabstop=2 tabstop=2 smartindent autoindent expandtab
set backspace=indent,eol,start
set visualbell
set title " append filename (dir) - VIM to terminal title
set spelllang=en_gb

au VimEnter * RainbowParenthesesToggleAll

""""""""""""""""""""""""""""""""
" see (or don't) what's going on
""""""""""""""""""""""""""""""""
set laststatus=2
set showcmd
set lazyredraw " don't redraw during macros
set number
set list
set listchars=tab:›\ ,eol:¬
" syntax highlighting loveliness
syntax on
syntax enable
" avoid 'hit enter' prompts after remote saves (etc)
set cmdheight=3
" take a peek at what's above/below the cursor when scrolling up/down
set scrolloff=5
" same for left/right
set sidescrolloff=5
let g:lisp_rainbow = 1
" color scheme settings
if has("gui_running")
	let g:solarized_contrast="high"    "default value is normal
	let g:solarized_visibility="high"    "default value is normal
	syntax enable
	set background=dark
	colorscheme solarized
else
	" dodgy build on a remote server complains about not being able
	" to find colour scheme - the 'silent!' will shut it up.
	silent! colorscheme desert
endif


" http://usevim.com/2012/09/21/vim101-virtualedit/
" better for working with blocks
set virtualedit=block


""""""""""""""""""
" Search / replace
""""""""""""""""""
" for easier searching
set ignorecase
set smartcase
set hlsearch
set incsearch
" for easier substition (assumme /g)
set gdefault


""""""""""""""""""""""""""""""""""""""""""""""""""
" centralise temporary files, history memorisation
""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("&undodir")
    set undodir=~/.vim/undo
    set undofile
    set undolevels=200 "maximum number of changes that can be undone
    set undoreload=100 "maximum number lines to save for undo on a buffer reload
endif

set history=50

"""""""""""""""""
" Syntax and lint
"""""""""""""""""
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_error_symbol="✗"
let g:syntastic_warning_symbol="⚠"
let g:syntastic_style_error_symbol="s✗"
let g:syntastic_style_warning_symbol="s⚠"
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=3
let g:syntastic_mode_map={'mode': 'active', 'active_filetypes': ['js'], 'passive_filetypes': ['html'] }


"""""""""""""""""""
" keystroke shizzle
"""""""""""""""""""
" filename completion to behave the same as bash
set wildmenu
set wildmode=list:longest
" more sensible motions
vnoremap j gj
vnoremap k gk
nnoremap j gj
nnoremap k gk
" move between splits with C-h, etc, rather than C-W h
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
" These keys are so annoying - BE GONE WITH THEM!
map § <Esc>
imap § <Esc>
map <F1> <Esc>
imap <F1> <Esc>

" better % matching (XML tags, if/endif, while/endwhile etc)
runtime macros/matchit.vim

" disable ex mode - we live in the 21st century these days
nnoremap Q <nop>

""""""""""""""""""
" leader key stuff
""""""""""""""""""
" set leader to <SPACE> - quicker to type than \
let mapleader=" "
" highlight searches
nmap <silent> <Leader>n :set invhls<CR>:set hls?<CR>
" select text which was just pasted.
nmap <Leader>v `[V`]
" quick comment/uncommenting with TComment
map <Leader>c <c-_><c-_>
nmap <silent> <Leader>s :set spell!<CR>
" more convenient save
nnoremap <Leader>ww :w<CR>
nnoremap <Leader>wa :wa<CR>


inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

""""""""""""""
" Autocommands
""""""""""""""
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType javascript,php autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" disable paste mode after leaving insert mode
au InsertLeave * set nopaste
