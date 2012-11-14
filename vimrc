""""""""""""""""System""""""""""""""""""""
"ebox or eric
let hostname = substitute(system('hostname'), '\n', '', '')

if hostname == "ebox"
   "macbook 
    let vimHome="/Users/eric/.vim"
    let tmpDir="/Users/eric/code/.tmpvim"
elseif hostname == "emachine"
   "linux at home
    let vimHome="/home/eric/.vim"
    let tmpDir="/home/eric/code/.tmpvim"
else
   "llabs unix
    let vimHome="/usr/local/code/dotvim"
    let tmpDir="/usr/local/code/.tmpvim"
endif

""""""Vundle INITIALIZATION"""""""""""""""""
set nocompatible
filetype off

" Set vundle in runtimepath.
exec 'set rtp+='.vimHome."/bundle/vundle/"

" Call vundle with path to bundles. Default, only check .vim dir.
call vundle#rc(vimHome . "/bundle") 

" add eclim
set rtp+=/usr/local/code/dotvim

" add local, non git, changes.
set rtp+=/usr/local/code/dotvim/local_config/after

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Bundles :
Bundle 'git@github.com:esiegel/snipmate-snippets.git'

" original repos on github
Bundle 'mileszs/ack.vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'msanders/cocoa.vim'
Bundle 'rosenfeld/conque-term'
Bundle 'chrisbra/NrrwRgn'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sorin-ionescu/python.vim'
Bundle 'riobard/scala.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'chrisbra/NrrwRgn'
Bundle 'godlygeek/tabular'
Bundle 'rosenfeld/conque-term'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-surround'

" vim-scripts repo
Bundle 'a.vim'
Bundle 'BusyBee'
Bundle 'cscope_macros.vim'
Bundle 'Color-Sampler-Pack'
Bundle 'L9'
Bundle 'VimClojure'
Bundle 'Jinja'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'git://repo.or.cz/vcscommand'

filetype plugin indent on     " required!off                                                                

"""""""""""""""""""""""""GENERAL"""""""""""""""""""""""""""""""
"read modeline at bottom of files
set modeline

"allow mouse control
set mouse=a

syntax on
set t_Co=256
"set background=dark
"let g:solarized_termcolors=16

"uses clipboard register +, instead of always :+y
set clipboard=unnamedplus

"colorscheme solarized 
colorscheme BusyBee 

"clipboard
set clipboard=unnamed

"matches previous indent level,
"intelligently guesses indent (code level)
set autoindent
set smartindent

"tab = 3 spaces "indent spaces = 3 and tab to spaces
set expandtab
set tabstop=3 
set softtabstop=3 
set shiftwidth=3

"allowing backspace to work after indent -> see :help i_backspacing
set backspace=indent,eol,start

"removes annoying beeps when bad command
"instead flashes screen
"first one helps with entering
autocmd VimEnter * set vb t_vb=
set vb t_vb=

"shows status of cursor position
set ruler

"sets search highlighting
"also...incremental search!
set hls
set incsearch

"specialized leader key
let mapleader=","

"removes highlighting from search after space
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

"no search wraps
set nowrapscan

"magic patterns - extended regular expresions
set magic

"colors for &hlsearch
hi Search ctermfg=white ctermbg=lightblue

set nowrap

"hides buffers instead of closing them
set hidden

"ignorecase when searching
set ignorecase

"set status line for powerline
set laststatus=2 
let g:Powerline_cache_file=tmpDir . "/PowerlineCache"

"Necessary to show unicode glyphs
set encoding=utf-8 " Necessary to show unicode glyphs

"Setup backup location and enable
let &backupdir=tmpDir . "/backup"
let &directory=tmpDir . "/swap"
let &undodir=tmpDir. "/undo"
set backup
set undolevels=1000
set undoreload=1000

"wildmode enables better file viewing when opeing new files, like bash
set wildmenu
set wildmode=longest,list:longest
set wildignore+=*.swp,*.pyc,*.class,*.idea*

"When in unclosed parens, ie args, have them line up.
"help cinoptions-values
set cino+=(0

"""""""""""""""""""""""""""CTAGS"""""""""""""""""""""""""""""

"Tags files
"autocmd FileType java set tags+=~/.vim/tags/java_tags
"autocmd FileType python set tags+=~/.vim/tags/python_tags

"regenerate cscope
nmap <F6> :!find . -iname "*.c" -o -iname "*.cpp" -o -iname "*.cc" -o -iname "*.c++" -o -iname "*.h" -o -iname "*.hpp" -o -iname "*.java" -o -iname "*.py" -o -iname "*.scala" > cscope.files<CR>:!cscope -b -q<CR>:cs reset<CR><CR>

"""""""""""""""""""""""""""TAGBAR"""""""""""""""""""""""""""""

let g:tagbar_autofocus=1

" scala
let g:tagbar_type_scala= {
    \ 'ctagstype' : 'scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values:0',
        \ 'v:variables:0',
        \ 'T:types:0',
        \ 't:traits:0',
        \ 'o:objects:0',
        \ 'a:abclasses:0',
        \ 'c:classes:0',
        \ 'r:caclasses:0',
        \ 'm:methods:0'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'T' : 'type',
        \ 't' : 'trait',
        \ 'o' : 'object',
        \ 'a' : 'abstract class',
        \ 'c' : 'class',
        \ 'r' : 'case class'
    \ },
    \ 'scope2kind' : {
        \ 'type' : 'T',
        \ 'trait' : 't',
        \ 'object' : 'o',
        \ 'abstract class' : 'a',
        \ 'class' : 'c',
        \ 'case class' : 'r'  
    \ },
    \ 'sort'    : 0
\ }

"""""""""""""""""""""""""""Clojure"""""""""""""""""""""""""""""
let vimclojure#WantNailgun=1


"""""""""""""""""""""""""""Syntastic"""""""""""""""""""""""""""""
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python'],
                           \ 'passive_filetypes': ['java'] }

" E221 - multiple spaces before operator.  Nice to lineup =.
" E241 - multiple spaces after :.  Nice to lineup dicts. 
" E272 - multiple spaces before keyword.  Nice to lineup import.
" W404 - import *, unable to detected undefined names.
" W801 - redefinition of unused import, try/except import fails.
let g:syntastic_python_checker_args = "--ignore=E221,E241,E272,W404,W801"

let g:syntastic_pyhton_checker="flake8"

"""""""""""""""""""""""""""SNIPMATE"""""""""""""""""""""""""""""
let g:snippets_dir=vimHome."/bundle/snipmate-snippets"

"""""""""""""""""""""""""""JAVA SPECIFIC"""""""""""""""""""""""""""""
"autocmd FileType java set foldmethod=syntax
function! ToggleComments()
    if &foldmethod == "marker"
        "need to add some way of undoing the folds
        let &foldmethod= "manual"
        let &foldmarker= "{{{,}}}"
    else
        let &foldmethod= "marker"
        let &foldmarker= "/*,*/"
    endif
endfunction

function! AlignArgs()
   execute 'normal vi(:s/, */,\r/gvi(=f('
endfunction

nmap <silent> <F7> :call ToggleComments()<CR>

"""""""""""""""""""""""""""C SPECIFIC"""""""""""""""""""""""""""""
"autocmd FileType c set foldmethod=syntax


"""""""""""""""""""""""""""CONQUETERM"""""""""""""""""""""""""""""
let g:ConqueTerm_EscKey = '<C-j>'
let g:ConqueTerm_ReadUnfocused = 1

"""""""""""""""""""""""""""gradle"""""""""""""""""""""""""""""

au BufNewFile,BufRead *.gradle set filetype=groovy

"""""""""""""""""""""""""""SUPERTAB"""""""""""""""""""""""""""

"set completion type to change based on context around it
let g:SuperTabDefaultCompletionType = 'context'

"Helps with completions not autofinishing first match
set completeopt=longest,menu,preview


"""""""""""""""""""""""""""PYTHON"""""""""""""""""""""""""""
au FileType python set omnifunc=pythoncomplete#Complete

"""""""""""""""""""""""""""TABULAR"""""""""""""""""""""""""""
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

"""""""""""""""""""""""""""YankRing"""""""""""""""""""""""""""
nmap <Leader>r :YRShow<CR>

"""""""""""""""""""""""""""ECLIM""""""""""""""""""""""""""""""

" disable logging import when log is typed
let g:EclimLoggingDisabled=1

" sort imports together when first two pacakges match
let g:EclimJavaImportPackageSeparationLevel=2

"eclim settings
"if has("PingEclim")  "PingEclim isn't loaded yet, so this always fails
if 1
    "disable eclim taglist
    let g:EclimTaglistEnabled=0

    "nnoremap <silent><buffer><Space> :JavaSearchContext<cr>
endif

"ImportMissing
nmap <silent><leader>m :JavaImportMissing<CR>

"import sort
nmap <silent><leader>s :JavaImportSort<CR>

"JavaCorrect
nmap <silent><leader><leader>c :JavaCorrect<CR>

"""""""""""""""""""""""""""MAPPINGS"""""""""""""""""""""""""""

"Do different things depending on context
function ContextAwareEnter()
   if &filetype=="qf"
      "Quickfix enter command
      :.cc
   else
      "tagbar shortcut
      :TagbarToggle
   endif
endfunction

"Taglist
"nnoremap <silent> <cr> :TlistToggle<CR>
"let Tlist_WinWidth=40
"nnoremap <silent> <cr> :call ContextAwareEnter()<CR> 
nnoremap <cr> :call ContextAwareEnter()<CR>

"change to next and previous buffers
noremap <silent> <C-h> :bp<CR>
noremap <silent> <C-l> :bn<CR>

"change to next quickfix error
noremap <silent><leader>h :cp<CR>
noremap <silent><leader>l :cn<CR>

"caps to escape
map! <C-j> <Esc>
map <C-j> <Esc>

"QuickFix List clear
noremap <C-q> :call setqflist([])

"Trick if forgot to sudo
cmap w!! %!sudo tee > /dev/null %

"VCSVimDiff
nmap <silent><leader>v :VCSVimDiff<CR>


""""""""""""""""""""""""""""""NERDTree""""""""""""""""""""""""""""""

"NERDTree Ctrl-n for nerdtree
nnoremap <silent><leader>n :NERDTreeToggle<CR>

"change nerdtree directory to directory containing current file Ctr-d goto dir
nnoremap <silent> <C-d> :NERDTree %:h<CR>

"ignore files
let NERDTreeIgnore=['\.pyc$', '\~$']

""""""""""""""""""""""""""""""Clang_complete""""""""""""""""""""""""""""""
let g:clang_auto_select=0
let g:clang_complete_auto=0
let g:clang_hl_errors=1
let g:clang_snippets_engine="snipmate"

if hostname == "ebox"
   let g:clang_use_library=1
   let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
   let g:clang_user_options='-stdlib=libc++ -std=c++11'
   let g:clang_auto_user_options = '.clang_complete'
elseif hostname == "eric"
   let g:clang_use_library=1
   let g:clang_library_path="/usr/local/downloads/clang+llvm-3.0-x86_64-linux-Ubuntu-11_04/lib"
endif


""""""""""""""""""""""""""""""AcK""""""""""""""""""""""""""""""
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
if !empty(matchstr(hostname(), "ebox"))
    let g:ackprg="ack -H --nocolor --nogroup --column"
endif

""""""""""""""""""""""""""""""AcK""""""""""""""""""""""""""""""
"narrow window vertical
let g:nrrw_rgn_vert = 1
let g:nrrw_rgn_wdth = 80 

"""""""""""""""""""""""""""""""PROJECT SPECFIC FUNCTIONS""""""""""""""""""""""""""""""

function! AntSingle()
    "change ant single to current file
    ! python ~/code/eric/scripts/change_ant_single.py %:p && ant single
endfunction

function! Markdownify()
    "markdown current file to html
    let l:urlSpacesRemoved = substitute(expand("%:p"), " ", "\\\\ ", "g")
    execute '!python ~/code/eric/scripts/markdown_to_html.py -i ' . l:urlSpacesRemoved . ' -g'
endfunction

function! SparkleSetup()
    "add cscope db also prepend source paths, cscope can't handle relative
    "paths

    cscope add /usr/local/code/sparkle/sparkle/cscope.out                         /usr/local/code/sparkle/sparkle
    cscope add /usr/local/code/sparkle/model/cscope.out                           /usr/local/code/sparkle/model
    cscope add /usr/local/code/sparkle/common/cscope.out                          /usr/local/code/sparkle/common
    cscope add /usr/local/code/sparkle/invitation_service/cscope.out              /usr/local/code/sparkle/invitation_service
    cscope add /usr/local/code/sparkle/smsrouter/cscope.out                       /usr/local/code/sparkle/smsrouter
    cscope add /usr/local/code/sparkle_demo/cscope.out                            /usr/local/code/sparkle_demo
    cscope add /usr/local/code/sparkle_client_java/sparkle_client_java/cscope.out /usr/local/code/sparkle_client_java/sparkle_client_java

    cscope add /usr/local/code/db_java/cscope.out                                 /usr/local/code/db_java/
    cscope add /usr/local/code/factory_java_1.7/cscope.out                        /usr/local/code/factory_java_1.7/
    cscope add /usr/local/code/logging_java/cscope.out                            /usr/local/code/logging_java/
    cscope add /usr/local/code/mobile_account/cscope.out                          /usr/local/code/mobile_account/
    cscope add /usr/local/code/rest_java/cscope.out                               /usr/local/code/rest_java/
    cscope add /usr/local/code/sms_java_1.9/cscope.out                            /usr/local/code/sms_java_1.9/
    cscope add /usr/local/code/web_java/cscope.out                                /usr/local/code/web_java/
    cscope add /usr/local/code/ws_java_1.4/cscope.out                             /usr/local/code/ws_java_1.4/
    cscope add /usr/local/code/c2dm/cscope.out                                    /usr/local/code/c2dm/
    cscope add /usr/local/code/cache_java/cscope.out                              /usr/local/code/cache_java/
    cscope add /usr/local/code/oauth_java/cscope.out                              /usr/local/code/oauth_java/
    cscope add /usr/local/code/redis_java/cscope.out                              /usr/local/code/redis_java/
    cscope add /usr/local/code/schedule_java/cscope.out                           /usr/local/code/schedule_java/
    cscope add /usr/local/code/http_java/cscope.out                               /usr/local/code/http_java/
    
    cscope add /usr/local/code/spring-framework-3.0.5.RELEASE/src/cscope.out      /usr/local/code/spring-framework-3.0.5.RELEASE/src/
endfunction

function! SparkleClientSetup()
    "add cscope db also prepend source paths, cscope can't handle relative
    "paths

    cscope add /usr/local/code/sparkle_client_java/cscope.out /usr/local/code/sparkle_client_java/
    cscope add /usr/local/code/web_java_1.16/cscope.out       /usr/local/code/web_java_1.16/
endfunction

" Sparkle call
if !empty(matchstr($PWD, "sparkle[^_]"))
    "load files if path contains sparkle_demo
    call SparkleSetup()
endif

" Sparkle_demo call
if !empty(matchstr($PWD, "sparkle_demo"))
    "load files if path contains sparkle_demo
    call SparkleSetup()
endif

" Sparkle_client_java 
if !empty(matchstr($PWD, "sparkle_client_java"))
    "load files if path contains sparkle_demo
    call SparkleClientSetup()
endif
