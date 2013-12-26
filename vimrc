set nocompatible
"colorscheme candy

" Vundle
""""""""""""""
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'ciaranm/detectindent'
Bundle 'corntrace/bufexplorer'
Bundle 'flazz/vim-colorschemes'
Bundle 'gerw/vim-latex-suite'
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplete.vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-abolish.git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/VisIncr'
filetype plugin indent on
syntax on

set background=dark
if has ('x') && has ('gui')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif
set autoindent
set backspace=indent,eol,start
set cmdheight=2
set copyindent
set diffopt+=iwhite,horizontal,context:2
set expandtab
set foldmethod=syntax
set guioptions+=a
set guioptions-=b " One per line necessary
set guioptions-=l " One per line necessary
set guioptions-=r " One per line necessary
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linespace=0
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set matchpairs+=<:>
set nobackup
set noerrorbells
set nojoinspaces
set nowrap
set previewheight=10
set ruler
set scrolljump=5
set scrolloff=3
set shiftwidth=4
set shortmess+=filmnrxoOtT
set showmatch
set smartcase
set softtabstop=4
set spell
set splitbelow
set splitright
set tabstop=4
set title
set undolevels=1000
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=onemore
set visualbell
set whichwrap=b,s,h,l,<,>,[,]
set wildignore+=*.aux,*.out,*.toc,.bbl
set wildignore+=**.class
set wildignore+=*.DS_Store
set wildignore+=.hg,.git,.svn,.hg,.bzr
set wildignore+=*.luac
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*.pyc
set wildignore+=*.spl
set wildignore+=*.sw?
set wildmenu
set wildmode=list:longest
set winminheight=0

" Miscellaneous settings
let fortran_dialect='f95'
let fortran_free_source=1

" Some useful personal macros
noremap =1 /\<\([wW]e\\|[Oo]urs?\\|[Uu]s\\|I\)\>
noremap =8 :set textwidth=80
noremap =b :%s/\s\+$//g
noremap =c :set ft=c
noremap =C :set ft=cpp
noremap =d :set bg=dark
noremap =D :set bg=light
noremap =e :retab
noremap =f !}fmt
noremap == i 
noremap =s !}sort
noremap =v :new $MYVIMRC
noremap =V :source $MYVIMRC

" Toggle folds on space
nnoremap <space> za
vnoremap <space> zf

" Automatically quit if quickfix buffer is last
au BufEnter * call MyLastWindow()
function! MyLastWindow()
    " if the window is quickfix go on
    if &buftype=="quickfix"
        " if this window is last on screen quit without warning
        if winbufnr(2) == -1
            quit!
        endif
    endif
endfunction

" http://thisblog.runsfreesoftware.com/?q=2009/04/20/indent-gnu-style-vim
function! GnuIndent()
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=2
    setlocal tabstop=8
endfunction

" Toggle highlighting long lines (modified)
" http://vim.wikia.com/wiki/Highlight_text_beyond_80_columns
nnoremap <silent> <Leader>L
\   :if exists('w:long_line_match') <Bar>
\       silent! call matchdelete(w:long_line_match) <Bar>
\       unlet w:long_line_match <Bar>
\   else <Bar>
\       let w:long_line_match = matchadd('ErrorMsg', '\%>79v.\+', -1) <Bar>
\   endif<CR>

" Toggle several useful settings at a few keystrokes
" https://jeffdaly.wordpress.com/2008/05/06/vim-easily-toggle-cursorcolumn-and-cursorline/
" http://vim.wikia.com/wiki/Highlight_current_line
noremap <silent> <Leader>c :set cursorcolumn!<CR>:set cursorcolumn?<CR>
noremap <silent> <Leader>C :set cursorline!  <CR>:set cursorline?  <CR>
noremap <silent> <Leader>w :set wrap!        <CR>:set wrap?        <CR>
noremap <silent> <Leader>p :set paste!       <CR>:set paste?       <CR>
noremap <silent> <Leader># :set number!      <CR>:set number?      <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist
noremap <silent> <Leader>t :TlistToggle<CR>
let Tlist_Auto_Open=0
let Tlist_Close_On_Select=0
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Inc_Winwidth=0
let Tlist_Process_File_Always=1
let Tlist_Show_Menu=1
let Tlist_Sort_Type="order"
let Tlist_Use_Right_Window=1
let tlist_def_tex_settings='tex;s:sections;c:chapter;g:graphics;l:label;r:ref'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
noremap <silent> <Leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.a$', '\.la$', '\.lo$', '\.o$', '\.so$']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-e> neocomplete#cancel_popup()
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" Miscellaneous plugin configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:syntastic_auto_jump = 0
let g:syntastic_enable_signs = 1
let g:Tex_CompileRule_dvi='latex -src-specials -interaction=nonstopmode $*'
let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi='kdvi $*'
