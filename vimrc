set nocompatible

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
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'majutsushi/tagbar'
Bundle 'mikewest/vimroom'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'Shougo/vimshell'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-abolish.git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/VisIncr'

set background=dark
colorscheme candy
if has ('x') && has ('gui')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif
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
set list
set matchpairs+=<:>
set mouse=a
set nobackup
set noerrorbells
set nojoinspaces
set nowrap
set previewheight=10
set scrolljump=5
set scrolloff=3
set shiftwidth=4
set shortmess+=filmnrxoOtT
set smartcase
set softtabstop=4
set spell
set splitbelow
set splitright
set tabstop=4
set title
set ttyfast
set ttymouse=xterm
set undolevels=1000
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=block
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

" Tone down colors of misspelled words; modified from
" http://www.zabbo.net/post/spell-checking-and-vim-syntax-highlighting/
if v:version >= 700
    setlocal spell spelllang=en_us
    highlight clear SpellBad
    highlight SpellBad term=standout term=underline cterm=underline ctermfg=1 gui=undercurl guisp=Red
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline ctermbg=4 gui=undercurl guisp=Blue
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline ctermbg=5 gui=undercurl guisp=Magenta
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline ctermbg=6 gui=undercurl guisp=DarkCyan
endif

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
noremap <silent> <Leader>\| :set cursorcolumn!  <CR>:set cursorcolumn?<CR>
noremap <silent> <Leader>-  :set cursorline!    <CR>:set cursorline?  <CR>
noremap <silent> <Leader>n  :NERDTreeToggle     <CR>
noremap <silent> <Leader>p  :set paste!         <CR>:set paste?       <CR>
noremap <silent> <Leader>#  :set number!        <CR>:set number?      <CR>
noremap <silent> <Leader>s  :SyntasticToggleMode<CR>
noremap <silent> <Leader>g  :GoldenRatioToggle  <CR>
noremap <silent> <Leader>t  :TagbarToggle       <CR>
noremap <silent> <Leader>w  :set wrap!          <CR>:set wrap?        <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_dictionary_filetype_lists = {
\   'default' : '',
\   'vimshell' : $HOME.'/.vimshell_hist',
\   'scheme' : $HOME.'/.gosh_completions'
\   }
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
   return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Always On Rainbow Parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBraces

" Miscellaneous plugin configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:syntastic_auto_jump = 0
let g:syntastic_enable_signs = 1
let g:Tex_CompileRule_dvi='latex -src-specials -interaction=nonstopmode $*'
let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi='kdvi $*'
let g:vimroom_ctermbackground = 16
let g:vimroom_sidebar_height = 0
let NERDTreeIgnore=['\.a$', '\.la$', '\.lo$', '\.o$', '\.so$']
