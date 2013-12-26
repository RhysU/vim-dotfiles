set nocompatible
colorscheme candy " ir_black?

" Use pathogen to include all plugins under the ~/.vim/bundle directory
" This must occur prior to all other loading.  Note resetting filetype.
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
syntax on

" General VIM options
set cmdheight=2   " Avoids annoying ENTER press on :wn-like commands
set completeopt=menuone,menu,longest,preview
set copyindent
set expandtab
set grepprg=grep\ -nH\ $*
set guioptions+=a
set guioptions-=b " One per line necessary
set guioptions-=l " One per line necessary
set guioptions-=r " One per line necessary
set hidden
set hlsearch
set incsearch
set laststatus=2
set matchpairs+=<:>
set nowrap
set ofu=syntaxcomplete#Complete
set previewheight=10
set ruler
set scrolloff=20
set shellslash
set shiftround
set shiftwidth=4
set shortmess=atI
set showmatch
set smarttab
set softtabstop=4
set spell
set tabstop=4
set title
set updatetime=2000
set visualbell
set wildmenu
set wildmode=list:longest

" Modified from http://www.linux.com/archive/feature/120126
set statusline=%f%m%r%h%w\ %y\ %((%4l:%02v)%)[%p%%]

" Unfold all folds when loading a file
" http://vim.wikia.com/wiki/All_folds_open_when_open_a_file
autocmd Syntax * normal zR

" Add a few custom typedef keywords for the C and C++ languages
" TODO Not entirely working yet.  Need an autocmd?
syntax keyword cType   complex_float complex_double complex_long_double
syntax keyword cppType complex_float complex_double complex_long_double

" Version 7+ VIM options
if v:version >= 700
    set diffopt+=iwhite,horizontal,context:2
    set foldmethod=syntax
endif

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

" Prefer backward-kill-word over backspace
map <bs> bdw

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

" Update differences anytime the buffer is saved
autocmd BufWritePost diffupdate

" From http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
" Highlight all instances of word under cursor, when idle.
" Type Leader-Leader-z to toggle highlighting on/off.
nnoremap <Leader><Leader>z :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

" Python and Sage development settings
" Modified from http://wiki.sagemath.org/Tips
autocmd Filetype python set tabstop=4|set shiftwidth=4|set expandtab
function! s:sagedev_settings()
    set filetype=python
    set makeprg=sage\ -b\ &&\ sage\ -t\ %
endfunction
autocmd BufRead,BufNewFile *.sage,*.pyx,*.spyx call s:sagedev_settings()

" Augment the tags we know about, see ~/.vim/tags/
set tags+=~/.vim/tags/cpp     " C++ standard library
"set tags+=~/.vim/tags/eigen3  " Eigen3 matrix library
"set tags+=~/.vim/tags/fftw3   " FFTW3 library
"set tags+=~/.vim/tags/gsl     " GNU Scientific Library
"set tags+=~/.vim/tags/mpi     " MPI standard headers
"set tags+=~/.vim/tags/boost   " Portions of Boost (LAST!)
"set tags+=~/.vim/tags/apr     " Apache Portable Runtime
"set tags+=~/.vim/tags/aprutil " APR Util
"set tags+=~/.vim/tags/grvy    " GRVY Toolkit
"set tags+=~/.vim/tags/hdf5    " HDF5
"set tags+=~/.vim/tags/log4cxx " Apache log4cxx library
"set tags+=~/.vim/tags/mkl     " Intel MKL library

" Settings for Fortran
" https://www.cca-forum.org/bugs/help/issue48
" http://www.unb.ca/fredericton/science/chem/ajit/syntax/fort60.htm
" http://www.unb.ca/fredericton/science/chem/ajit/indent/fort60.htm
" Note that some of these interact poorly with the DoxygenToolkit
let fortran_dialect='f95'
let fortran_free_source=1
"let fortran_do_enddo=1
"let fortran_fold=0
"let fortran_fold_conditionals=1
"let fortran_fold_multilinecomments=1
"let fortran_have_tabs=0
"let fortran_more_precise=0

" emacs follow: scroll bind two windows one screenful apart
" http://lists.gnu.org/archive/html/screen-users/2012-01/msg00009.html
" http://tech.groups.yahoo.com/group/vim/message/54915
nmap <silent> <Leader>ef :vsplit<bar>wincmd l<bar>exe "norm!  Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr>:set scb<cr>

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
noremap <silent> <Leader><Leader>c :set cursorcolumn!<CR>:set cursorcolumn?<CR>
noremap <silent> <Leader><Leader>C :set cursorline!  <CR>:set cursorline?  <CR>
noremap <silent> <Leader><Leader>w :set wrap!        <CR>:set wrap?        <CR>
noremap <silent> <Leader><Leader>p :set paste!       <CR>:set paste?       <CR>
noremap <silent> <Leader><Leader># :set number!      <CR>:set number?      <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist: http://vim-taglist.sourceforge.net/
" http://vim-taglist.sourceforge.net/manual.html#taglist-options
" http://vim-taglist.sourceforge.net/extend.html
" http://vim.wikia.com/wiki/Use_Taglist_with_LaTeX_files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <Leader><Leader>t :TlistToggle<CR>
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
" NERDTree: http://www.vim.org/scripts/script.php?script_id=1658
" https://github.com/scrooloose/nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <Leader><Leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.a$', '\.la$', '\.lo$', '\.o$', '\.so$']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" spacehi: http://www.vim.org/scripts/script.php?script_id=443
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * SpaceHi
au FileType help NoSpaceHi


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DetectIndent: http://www.vim.org/scripts/script.php?script_id=1171
" http://github.com/ciaranm/detectindent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
autocmd BufReadPost * :DetectIndent


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EnhancedCommentify: http://www.vim.org/scripts/script.php?script_id=23
" http://kotka.de/projects/enhancedcommentify/index.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EnhCommentifyBindInInsert='No'
let g:EnhCommentifyPretty='Yes'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OmniCppComplete: http://www.vim.org/scripts/script.php?script_id=1520
" http://vim.wikia.com/wiki/C++_code_completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let OmniCpp_NamespaceSearch   = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess        = 1
let OmniCpp_MayCompleteDot    = 1
let OmniCpp_MayCompleteArrow  = 1
let OmniCpp_MayCompleteScope  = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "boost"]
" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tSkeleton: http://www.vim.org/scripts/script.php?script_id=1160
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tskelUserName='Rhys Ulerich'
let g:tskelUserEmail='rhys.ulerich@gmail.com'
autocmd BufNewFile *.awk    TSkeletonSetup template.awk
autocmd BufNewFile *.cc     TSkeletonSetup template.cpp
autocmd BufNewFile *.cpp    TSkeletonSetup template.cpp
autocmd BufNewFile *.c      TSkeletonSetup template.c
autocmd BufNewFile *.f90    TSkeletonSetup template.f90
autocmd BufNewFile *.F90    TSkeletonSetup template.f90
autocmd BufNewFile *.f      TSkeletonSetup template.f90
autocmd BufNewFile *.gp     TSkeletonSetup template.gp
autocmd BufNewFile *.html   TSkeletonSetup template.html
autocmd BufNewFile *.py     TSkeletonSetup template.py
autocmd BufNewFile *.sage   TSkeletonSetup template.sage
autocmd BufNewFile *.sh     TSkeletonSetup template.sh

" Make script-like files executable whenever we write them to disk
" TODO Causes buffer to jump on screen whenever file is saved
" function! WritePostChmodX()
"     silent !test -O % && chmod +x %
"     silent bufdo :edit
" endfunction
" autocmd BufWritePost *.awk  call WritePostChmodX()
" autocmd BufWritePost *.gp   call WritePostChmodX()
" autocmd BufWritePost *.py   call WritePostChmodX()
" autocmd BufWritePost *.sage call WritePostChmodX()
" autocmd BufWritePost *.sh   call WritePostChmodX()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab: http://www.vim.org/scripts/script.php?script_id=1643
" http://github.com/ervandew/supertab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "context"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LaTeX-suite: http://vim-latex.sourceforge.net/
" http://vim-latex.sourceforge.net/documentation/latex-suite.html
" http://www.hataewon.com/?p=11
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:Tex_CompileRule_dvi='latex -src-specials -interaction=nonstopmode $*'
let g:Tex_ViewRule_dvi='kdvi $*'
"" http://vim.wikia.com/wiki/Automatic_LaTeX_compile_and_XDVI_refresh
"" Automatically compile LaTeX source on buffer save
" au BufWritePost *.tex silent call Tex_CompileLatex()
"" Automatically refresh XDVI after compiling LaTeX source
" au BufWritePost *.tex silent !pkill -USR1 xdvi.bin
"" Hook xdvi and gvim together for inverse searching
" let s:xdvi_servername = "xdvi_server"
" if v:servername != ""
"     let s:xdvi_servername = v:servername
" endif
" let g:Tex_ViewRule_dvi='xdvi -editor "gvim --servername '.s:xdvi_servername.' --remote +\%l \%f"'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DoxygenToolkit: http://www.vim.org/scripts/script.php?script_id=987
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:DoxygenToolkit_commentType  = "C"
let g:DoxygenToolkit_authorName   = "Rhys Ulerich"
let g:DoxygenToolkit_briefTag_pre = ""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STALE STALE STALE STALE STALE STALE STALE STALE STALE STALE STALE STALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Append modeline after last line in buffer.
"" http://vim.wikia.com/wiki/Modeline_magic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files
"function! AppendModeline()
"  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
"        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
"  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
"  call append(line("$"), l:modeline)
"endfunction
"nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

""Save and restore fold positions automatically
""http://tuxtraining.com/2009/04/10/how-to-use-folds-in-vim
" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

""" Disabled per content at http://vim.wikia.com/wiki/Omni_completion
"" Enable omnicomplete for a collection of file types
"" http://amix.dk/blog/viewEntry/19021
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete
"" Enable syntax-based omnicompletion if nothing else available
"" From help ft-syntax-omni
"if has("autocmd") && exists("+omnifunc")
"    autocmd Filetype *
"    \   if &omnifunc == "" |
"    \       setlocal omnifunc=syntaxcomplete#Complete |
"    \   endif
"endif


" Change behavior of the popup menu, which seems to break in the terminal
" http://vim.wikia.com/wiki/VimTip1228
" inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
" inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
" inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"


"" Pulled from help preview-window
" autocmd! CursorHold *.[ch]   nested call PreviewWord()
" autocmd! CursorHold *.[ch]pp nested call PreviewWord()
" autocmd! CursorHold *.cc     nested call PreviewWord()
" autocmd! CursorHold *.hh     nested call PreviewWord()
" func! PreviewWord()
"   if &previewwindow          " don't do this in the preview window
"     return
"   endif
"   let w = expand("<cword>")  " get the word under cursor
"   if w =~ '\a'               " if the word contains a letter
"
"     " Delete any existing highlight before showing another tag
"     silent! wincmd P         " jump to preview window
"     if &previewwindow        " if we really get there...
"       match none             " delete existing highlight
"       wincmd p               " back to old window
"     endif
"
"     " Try displaying a matching tag for the word under the cursor
"     try
"        silent! exe "ptag " . w
"     catch
"       return
"     endtry
"
"     silent! wincmd P         " jump to preview window
"     if &previewwindow        " if we really get there...
"   if has("folding")
"     silent! .foldopen        " don't want a closed fold
"   endif
"   call search("$", "b")      " to end of previous line
"   let w = substitute(w, '\\', '\\\\', "")
"   call search('\<\V' . w . '\>') " position cursor on match
"   " Add a match highlight to the word at this position
"       hi previewWord term=bold ctermbg=green guibg=green
"   exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
"       wincmd p           " back to old window
"     endif
"   endif
" endfun
