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
Bundle "arcticicestudio/nord-vim"
"Bundle "arecarn/crunch"
Bundle 'bling/vim-airline'
Bundle 'ciaranm/detectindent'
Bundle 'corntrace/bufexplorer'
"Bundle 'elzr/vim-json'
Bundle 'flazz/vim-colorschemes'
"Bundle 'gerw/vim-latex-suite'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
"Bundle 'gregsexton/VimCalc'
Bundle 'guns/vim-sexp'
Bundle 'jiangmiao/auto-pairs'
Bundle 'jpalardy/vim-slime'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
"Bundle 'klen/python-mode'
"Bundle 'Lokaltog/vim-easymotion'
Bundle 'ludovicchabant/vim-lawrencium'
Bundle 'majutsushi/tagbar'
Bundle 'mhinz/vim-signify'
Bundle 'mzlogin/vim-markdown-toc'
"Bundle 'mikewest/vimroom'
Bundle 'mileszs/ack.vim'
Bundle 'nathanaelkane/vim-indent-guides'
"Bundle 'powerman/vim-plugin-viewdoc'
"Bundle 'Raimondi/delimitMate'
Bundle 'rking/ag.vim'
Bundle 'rust-lang/rust.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
"Bundle 'Shougo/neocomplcache'
"Bundle 'terryma/vim-multiple-cursors'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-sexp-mappings-for-regular-people'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-vividchalk'
Bundle 'vim-erlang/vim-erlang-compiler'
Bundle 'vim-scripts/Align'
Bundle 'vim-scripts/a.vim'
"Bundle 'vim-scripts/DoxygenToolkit.vim'
Bundle 'vim-scripts/VisIncr'
Bundle 'vimwiki/vimwiki'

set t_Co=256
colorscheme nord " darkbone candy molokai vividchalk
set background=dark
highlight clear SpellBad
highlight SpellBad term=standout term=underline ctermfg=red cterm=underline

if has ('x') && has ('gui')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif
set copyindent
set diffopt+=iwhite,horizontal,context:2
set expandtab
set foldmethod=syntax
set foldlevelstart=99
set formatoptions=crqn
set guioptions+=a
set guioptions-=b " One per line necessary
set guioptions-=l " One per line necessary
set guioptions-=r " One per line necessary
set hidden
set history=1000
set hlsearch
set joinspaces
set lazyredraw
set list
set matchpairs+=<:>
set modeline
set mouse=a
set nobackup
set noerrorbells
set nowrap
set previewheight=10
set scrolljump=-10
set scrolloff=10
set shiftwidth=4
set shortmess+=filmnrxoOtT
set softtabstop=4
set spell
set splitbelow
set splitright
set textwidth=80
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
noremap =4 :set tabstop=4
noremap =8 :set tabstop=8
noremap =b :%s/\s\+$//g
noremap =c :set ft=c
noremap =C :set ft=cpp
noremap =d :set bg=dark
noremap =D :set bg=light
noremap =e :retab
noremap =f !}fmt
noremap == i 
noremap =s !}sort
noremap =u !}sort -u
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

" Suggested at https://news.ycombinator.com/item?id=13157497
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki'}]

" http://thisblog.runsfreesoftware.com/?q=2009/04/20/indent-gnu-style-vim
function! GnuIndent()
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=2
    setlocal tabstop=8
endfunction

" Toggle highlighting long lines on <Leader>L
if exists('+colorcolumn')
    " Post-7.3: http://www.vimbits.com/bits/317, modified to use textwidth
    function! g:ToggleColorColumn()
        if &colorcolumn != ''
            setlocal colorcolumn&
        else
            let &colorcolumn="+".join(range(1,127),",+")
        endif
    endfunction
    nnoremap <silent> <leader>L :call g:ToggleColorColumn()<CR>
    call g:ToggleColorColumn()
else
    " Pre-7.3: http://vim.wikia.com/wiki/Highlight_text_beyond_80_columns
    nnoremap <silent> <Leader>L
    \   :if exists('w:long_line_match') <Bar>
    \       silent! call matchdelete(w:long_line_match) <Bar>
    \       unlet w:long_line_match <Bar>
    \   else <Bar>
    \       let w:long_line_match = matchadd('ErrorMsg', '\%>79v.\+', -1) <Bar>
    \   endif<CR>
endif

" Toggle a portrait-monitor-friendly NERDTree and Tagbar setup
" http://unix.stackexchange.com/questions/92942/
function! NERDTreePortrait()
  let w:jumpbacktohere = 1
  " Detect which plugins are open
  if exists('t:NERDTreeBufName')
      let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
  else
      let nerdtree_open = 0
  endif
  let tagbar_open = bufwinnr('__Tagbar__') != -1
  " Perform the appropriate action
  if nerdtree_open && tagbar_open
      NERDTreeClose
      TagbarClose
  elseif nerdtree_open
      TagbarOpen
      wincmd J
      wincmd k
      wincmd L
  elseif tagbar_open
      NERDTree
      wincmd J
      wincmd k
      wincmd L
  else
      NERDTree
      TagbarOpen
      wincmd J
      wincmd k
      wincmd L
  endif
  " Jump back to the original window
  for window in range(1, winnr('$'))
      execute window . 'wincmd w'
      if exists('w:jumpbacktohere')
          unlet w:jumpbacktohere
          break
      endif
  endfor
endfunction

" Toggle several useful settings at a few keystrokes
" https://jeffdaly.wordpress.com/2008/05/06/vim-easily-toggle-cursorcolumn-and-cursorline/
" http://vim.wikia.com/wiki/Highlight_current_line
noremap <silent> <Leader>g  :GoldenRatioToggle       <CR>
noremap <silent> <Leader>N  :call NERDTreePortrait() <CR>
noremap <silent> <Leader>n  :NERDTreeToggle          <CR>
noremap <silent> <Leader>p  :set paste!              <CR>:set paste?       <CR>
noremap <silent> <Leader>\| :set cursorcolumn!       <CR>:set cursorcolumn?<CR>
noremap <silent> <Leader>-  :set cursorline!         <CR>:set cursorline?  <CR>
noremap <silent> <Leader>#  :set number!             <CR>:set number?      <CR>
noremap <silent> <Leader>S  :set spell!              <CR>:set spell?       <CR>
noremap <silent> <Leader>s  :SyntasticToggleMode     <CR>
noremap <silent> <Leader>t  :TagbarToggle            <CR>
noremap <silent> <Leader>w  :set wrap!               <CR>:set wrap?        <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" neocomplcache
"let g:acp_enableAtStartup = 0
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_dictionary_filetype_lists = {
"\   'default' : '',
"\   'vimshell' : $HOME.'/.vimshell_hist',
"\   'scheme' : $HOME.'/.gosh_completions'
"\   }
"if !exists('g:neocomplcache_keyword_patterns')
"    let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"   return neocomplcache#smart_close_popup() . "\<CR>"
"endfunction
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e> neocomplcache#cancel_popup()
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"if !exists('g:neocomplcache_omni_patterns')
"    let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"" Always On Rainbow Parenthesis (DISABLED! It interferes with spellchecking!)
"au VimEnter * RainbowParenthesesToggle
"au Syntax   * RainbowParenthesesLoadRound
"au Syntax   * RainbowParenthesesLoadSquare
"au Syntax   * RainbowParenthesesLoadBraces

" Tabularize mappings from
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
if exists(":Tabularize")
  nmap <Leader>a| :Tabularize /|<CR>
  vmap <Leader>a| :Tabularize /|<CR>
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a<Space> :Tabularize / \zs<CR>
  vmap <Leader>a<Space> :Tabularize / \zs<CR>
endif

" Miscellaneous plugin settings
autocmd FileType gitcommit set foldmethod=syntax
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:pymode_indent=0
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:syntastic_auto_jump = 0
let g:syntastic_enable_signs = 1
let g:syntastic_sh_checkers = ['sh', 'shellcheck']
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++14'
let g:Tex_CompileRule_dvi='latex -src-specials -interaction=nonstopmode $*'
let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi='kdvi $*'
let g:vimroom_ctermbackground=16
let g:vimroom_sidebar_height=0
let g:xml_syntax_folding=1
set iskeyword+=:

" Avoid seeing common build artifacts in NERDTree
let NERDTreeIgnore=[ '\.a$', 'autom4te.cache', '\.aux$', '\.bbl$', '\.blg$',
                   \ '\.dep$', '\.fdb_latexmk$', '\.fls$', '\.la$', '\.lo$',
                   \ '\.lof$', '\.log$', '\.lot$', '\.o$', '\.out$',
                   \ '\.so$', '\.tdo$', '\.toc$' ]
