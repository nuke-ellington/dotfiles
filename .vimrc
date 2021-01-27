set nocompatible

" Define the spacebar as <Leader> modifier key used in key mappings.
" map <Leader>xy vim-cmd
let mapleader = "\<Space>"

" Vundle packet manager
filetype off

let win_shell = (has("win32") || has("win64")) && &shellcmdflag =~ '/'
let vimDir = win_shell ? '$USERPROFILE/vimfiles' : '$HOME/.vim'
let &runtimepath .= ',' . expand(vimDir . '/bundle/Vundle.vim')
call vundle#rc(expand(vimDir . '/bundle'))
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Enable the '.' command for plugin maps.
Plugin 'tpope/vim-repeat'

Plugin 'tpope/vim-surround'

Plugin 'scrooloose/nerdtree' "{{{
    let g:NERDTreeMapOpenSplit = 's'
    let g:NERDTreeMapOpenVSplit = 'v'
    let g:NERDTreeChDirMode = 2
    let g:NERDTreeIgnore = ['\~$', '\.git', '\.vim$', '\.sw[mnpcod]', '\.DS_Store', 'node_modules[[dir]]']
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeShowHidden = 1
    let g:NERDTreeShowLineNumbers = 1
    let g:NERDTreeWinPos = 'left'
    nnoremap <Leader>nt :NERDTreeToggle<CR>
    nnoremap <Leader>nf :NERDTreeFind<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"}}}

" Git related plugins
if v:version > 703
    Plugin 'airblade/vim-gitgutter'
endif
"Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'

Plugin 'leafgarland/typescript-vim'
Plugin 'vim-syntastic/syntastic' "{{{
    if !exists('g:syntastic_html_tidy_ignore_errors')
        let g:syntastic_html_tidy_ignore_errors = []
    endif

    let g:syntastic_html_tidy_ignore_errors += ["proprietary attribute \"ng-"]

    " check on load and save
    let g:syntastic_check_on_open = 1
    " omit checks when quitting
    let g:syntastic_check_on_wq = 0
    let g:syntastic_javascript_jshint_conf = "$HOME/.jshintrc"
    let g:syntastic_typescript_checkers = ['tslint']
    " CSS Lint and stylelint both seem to slow down Vim considerably.
    "let g:syntastic_css_checkers = ['stylelint']

    nnoremap <Leader>E :Errors<CR>
"}}}

" Required for SnipMate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets' "{{{
    let g:snips_author = $USER
    let g:snipMate = get(g:, 'snipMate', {})
    let g:snipMate.snippet_version = 1
    let g:snipMate.scope_aliases = get(g:snipMate, 'scope_aliases', {})
    " Load XML snippets when editing snippets
    let g:snipMate.scope_aliases['snippets'] = 'snippets,xml'
"}}}

Plugin 'vim-airline/vim-airline' "{{{
  let g:airline_section_c = '%t'
"}}}
Plugin 'vim-airline/vim-airline-themes' "{{{
    let g:airline_theme = 'badcat'
"}}}
Plugin 'bling/vim-bufferline'

" Toggle marks using mx where x is the mark
Plugin 'kshenoy/vim-signature'

" <Leader>ig to toggle indent guides
Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'mhinz/vim-startify' "{{{
    let g:startify_custom_header = []
"}}}

Plugin 'othree/javascript-libraries-syntax.vim' "{{{
    let g:used_javascript_libs = 'angularjs,jquery'
"}}}

Plugin 'altercation/vim-colors-solarized'

" Extended matching with %
Plugin 'vim-scripts/matchit.zip'

" Persistent folding
Plugin 'vim-scripts/restore_view.vim' "{{{
    set viewoptions=cursor,folds,slash,unix
    let g:skipview_files = ['*\.vim']
"}}}

"Plugin 'valloric/youcompleteme' "{{{
"    let g:ycm_autoclose_preview_window_after_completion = 1
"    let g:ycm_autoclose_preview_window_after_insertion = 1
"}}}

" Zen Coding (trigger via <C-y>,)
Plugin 'mattn/emmet-vim' "{{{
    "let g:user_emmet_leader_key='<C-y>'
"}}}

Plugin 'majutsushi/tagbar'

Plugin 'ryanoasis/vim-devicons' "{{{
    let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
    let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
"}}}
Plugin 'vwxyutarooo/nerdtree-devicons-syntax'

call vundle#end()
filetype plugin indent on

set encoding=utf-8

set noexpandtab
set softtabstop=4
set shiftwidth=4

" Allow local .vimrc files
set exrc

" Incremental search
set incsearch

" This is questionable since you have to clean up these file every now and then.
"set undofile

" Show line numbers
set number
set relativenumber

" Highlight tabs and trailing whitespace
set listchars=tab:.\ ,trail:.
set list

if has("gui_running")
    colorscheme solarized
    set background=dark
    set cursorline
    set guifont=Hack\ Nerd\ Font:h11
endif

set lazyredraw
set linebreak
set nowrap
set foldcolumn=2
set hlsearch
set showmatch
set mousehide
" Preview next two lines when scrolling vertically
set scrolloff=2
set smarttab
set autoindent
set smartindent

set showcmd
set wildmenu
set wildignore=*.o,*~,.git\*,.hg\*,.svn\*

set hidden

set clipboard=unnamed

" Use mouse on terminals too
if has("mouse")
    set mouse=a
endif

" Shortcuts for ex cmds
noremap <Leader>e :e#<CR>
noremap <Leader>> :next<CR>
noremap <Leader>< :previous<CR>
noremap <Leader>q :q<CR>
noremap <Leader>Q :wq<CR>
noremap <Leader>w :w<CR>

function! OpenQuickfixWindow()
    let l:active_win = winnr()

    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if (getbufvar(bnum, '&buftype') == 'quickfix')
            let l:qf_open = 1
        endif
    endfor

    if !exists("l:qf_open")
        silent execute 'botright copen'
        silent execute 'wincmd w'
    endif
endfunction

" Grep map
if has("unix")
    let s:excluded_dirs = '.git,bower_components,node_modules,vendor'

    " TODO Find out why invoking this map moves the cursor position
    execute "noremap <Leader>g :call OpenQuickfixWindow() <bar> :silent grep! -IR --exclude-dir={" . s:excluded_dirs . "} --exclude *.vim "
else
    noremap <Leader>g :vimgrep 
endif

" Window movement
nnoremap <Leader>j :wincmd w<CR>
nnoremap <Leader>k :wincmd W<CR>

" Fast access to vimrc
nnoremap <Leader>ve :edit $MYVIMRC<CR>
nnoremap <Leader>vh :split $MYVIMRC<CR>
nnoremap <Leader>vv :vsplit $MYVIMRC<CR>
nnoremap <Leader>vs :source $MYVIMRC<CR>

" If lines wrap j and k can navigate on one line
nnoremap j gj
nnoremap k gk

nnoremap Y y$

" Save current editing session
nnoremap <Leader>ms :mksession<CR>

" Remove current search highlights
nnoremap <silent> ö :nohlsearch<CR>

" Fold code block surrounded by curly braces that starts or ends on current
" line. Also this closes Vim marker folds in manual mode.
" TODO This map could be deprecated since the matchit plugin allows zf% to
" achive the same.
nnoremap <silent> zff :exe 'normal 0f{' <Bar> exe 'normal f}' <Bar> exe 'normal! zf%'<CR>

" Prevent unnecessary hand movement to reach ESC
" aka Smash Escape
inoremap jk <Esc>
inoremap kj <Esc>/
cnoremap jk <C-c>
cnoremap kj <C-c>/

" Enable syntax highlighting
syntax enable

function! IsNerdTreeEnabled() "{{{
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction"}}}

function! OpenNerdTree() "{{{
    if !IsNerdTreeEnabled()
        NERDTree
        wincmd p
    endif
endfunction "}}}

au BufRead,BufNewFile *.xaml set filetype=xml
au BufRead,BufNewFile *.ts set filetype=typescript

if has("gui_running")
    let b:code_file_exts = 'css,html,javascript,typescript,java,json,groovy'

    execute 'au Syntax ' . b:code_file_exts . ' :call OpenNerdTree()'
endif

set modelines=1
" vim:foldmethod=marker:foldlevel=0
