" Plugin management via Vundle
" See https://github.com/VundleVim/Vundle.vim#quick-start
""""""""""""""
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
Plugin 'VundleVim/Vundle.vim'
"Plugin "arcticicestudio/nord-vim"
"Plugin "arecarn/crunch"
Plugin 'bling/vim-airline'
Plugin 'bhurlow/vim-parinfer'
Plugin 'ciaranm/detectindent'
Plugin 'corntrace/bufexplorer'
"Plugin 'elzr/vim-json'
Plugin 'flazz/vim-colorschemes'
"Plugin 'gerw/vim-latex-suite'
"Plugin 'godlygeek/tabular'
"Plugin 'gregsexton/VimCalc'
"Plugin 'guns/vim-sexp'
"Plugin 'jiangmiao/auto-pairs'
Plugin 'jpalardy/vim-slime'
Plugin 'kien/ctrlp.vim'
"Plugin 'kien/rainbow_parentheses.vim'
"Plugin 'klen/python-mode'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
"Plugin 'mzlogin/vim-markdown-toc'
"Plugin 'mileszs/ack.vim'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'powerman/vim-plugin-viewdoc'
"Plugin 'Raimondi/delimitMate'
Plugin 'rking/ag.vim'
"Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'Shougo/neocomplcache'
"Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-abolish'
"Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
"Plugin 'tpope/vim-sexp-mappings-for-regular-people'
"Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vividchalk'
"Plugin 'vim-erlang/vim-erlang-compiler'
"Plugin 'vim-scripts/Align'
"Plugin 'vim-scripts/a.vim'
"Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vim-scripts/VisIncr'
"Plugin 'vimwiki/vimwiki'
Plugin 'zxqfl/tabnine-vim'

call vundle#end()

set t_Co=256
colorscheme vividchalk " darkbone candy molokai nord vividchalk
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

" http://thisblog.runsfreesoftware.com/?q=2009/04/20/indent-gnu-style-vim
function! GnuIndent()
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=2
    setlocal tabstop=8
endfunction

" Toggle highlighting long lines on <Leader>L
function! g:ToggleColorColumn()
    if &colorcolumn != ''
        setlocal colorcolumn&
    else
        let &colorcolumn="+".join(range(1,127),",+")
    endif
endfunction
nnoremap <silent> <leader>L :call g:ToggleColorColumn()<CR>
"call g:ToggleColorColumn()

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
let g:xml_syntax_folding=1
set iskeyword+=:

" Avoid seeing common build artifacts in NERDTree
let NERDTreeIgnore=[ '\.a$', 'autom4te.cache', '\.aux$', '\.bbl$', '\.blg$',
                   \ '\.dep$', '\.fdb_latexmk$', '\.fls$', '\.la$', '\.lo$',
                   \ '\.lof$', '\.log$', '\.lot$', '\.o$', '\.out$',
                   \ '\.so$', '\.tdo$', '\.toc$' ]
