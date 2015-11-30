set nocompatible

" Allow local .vimrc files
set exrc

" Incremental search
set incsearch

" This is questionable since you have to clean up these file every now and then.
"set undofile

" Show line numbers
set number
set relativenumber

set linebreak
set nowrap
set foldcolumn=3
set hlsearch
set showmatch
set mousehide
" Preview next two lines when scrolling vertically
set scrolloff=2
set expandtab
set smarttab
set autoindent
set smartindent

set ruler
set tabstop=4

set showcmd
set wildmenu
set wildignore=*.o,*~,.git\*,.hg\*,.svn\*

" Use mouse on terminals too
if has('mouse')
	set mouse=a
endif

" Define the spacebar as <Leader> modifier key used in key mappings.
" map <Leader>xy vim-cmd
let mapleader = "\<Space>"
" Shortcuts for ex cmds
noremap <Leader>e :e#<CR>
noremap <Leader>n :n<CR>
noremap <Leader>q :q<CR>
noremap <Leader>Q :wq<CR>
noremap <Leader>w :w<CR>

" Fast access to vimrc
nnoremap <Leader>ve :split $MYVIMRC<CR>
nnoremap <Leader>vs :source $MYVIMRC<CR>

" If lines wrap j and k can navigate on one line
nnoremap j gj
nnoremap k gk

" Remove current search highlights
nnoremap ö :nohlsearch<CR>

" Fold code block surrounded by curly braces that starts or ends on current line
nnoremap <silent> zff :exe 'normal 0f{' <Bar> exe 'normal f}' <Bar> exe 'normal! zf%'<CR>

" Prevent unnecessary hand movement
inoremap jk <Esc>

" Enable syntax highlighting
syntax enable

colorscheme slate

