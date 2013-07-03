""""""""""""""""System"""""""""""""""""""" {{{
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

" }}}

""""""Vundle INITIALIZATION""""""""""""""""" {{{
set nocompatible
filetype off

" add vimhome to rtp
exec 'set rtp+='.vimHome

" add local, non git, changes.
exec 'set rtp+='.vimHome."/local_config/after"

" Set vundle in runtimepath.
exec 'set rtp+='.vimHome."/bundle/vundle/"

" Call vundle with path to bundles. Default, only check .vim dir.
call vundle#rc(vimHome . "/bundle") 

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Bundles :
Bundle 'git@github.com:esiegel/snipmate-snippets.git'

" original repos on github
Bundle 'Lokaltog/vim-powerline'
Bundle 'Rip-Rip/clang_complete'
Bundle 'altercation/vim-colors-solarized'
Bundle 'chrisbra/NrrwRgn'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'jnwhiteh/vim-golang'
Bundle 'kchmck/vim-coffee-script'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim'
Bundle 'msanders/cocoa.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'nsf/gocode', {'rtp': 'vim/'}
Bundle 'riobard/scala.vim'
Bundle 'rosenfeld/conque-term'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sorin-ionescu/python.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'

" vim-scripts repo
Bundle 'BusyBee'
Bundle 'Color-Sampler-Pack'
Bundle 'Jinja'
Bundle 'L9'
Bundle 'VimClojure'
Bundle 'a.vim'
Bundle 'cscope_macros.vim'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'git://repo.or.cz/vcscommand'

filetype plugin indent on " required!off                                                                

" }}}

"""""""""""""""""""""""""GENERAL""""""""""""""""""""""""""""""" {{{
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

"inverse search
hi Search cterm=inverse ctermbg=none ctermfg=none gui=inverse guibg=none guifg=none

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

set nowrap

"hides buffers instead of closing them
set hidden

"ignorecase
set ignorecase

"case only important if use caps
set ignorecase

"case only important if use caps
set smartcase 

"in <Ctrl-v> block visual select, not confined to end of chars.
set virtualedit=block

"set status line for powerline
set laststatus=2 
let g:Powerline_cache_file=tmpDir . "/PowerlineCache"
let g:Powerline_symbols="unicode"

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

"spell checking
set spell spelllang=en_us
set nospell

"Improve matching with '%', will match if/then/else, etc.
"runtime will source a file found in runtimepath/rtp.
runtime macros/matchit.vim

"Vertical/Horizontal Scroll offset.
"Minimal number of screen lines to keep above and below the cursor
set scrolloff=3
set sidescrolloff=3

" }}}

"""""""""""""""""""""""""""XIKI""""""""""""""""""""""""""""" {{{
let $XIKI_DIR = "/usr/local/rvm/gems/ruby-1.9.3-head@global/gems/xiki-0.6.5"
if filereadable($XIKI_DIR)
   source /usr/local/rvm/gems/ruby-1.9.3-head@global/gems/xiki-0.6.5/etc/vim/xiki.vim
endif

" }}}

"""""""""""""""""""""""""""CTAGS""""""""""""""""""""""""""""" {{{

"Tags files
"autocmd FileType java set tags+=~/.vim/tags/java_tags
"autocmd FileType python set tags+=~/.vim/tags/python_tags

" file extensions to search for when regenerating cscope index
let s:cscope_file_extensions = ["c", "cpp", "cc",
                               \"c++", "h", "hpp",
                               \"java", "py", "scala"]

function! s:GenerateCscopeIndex()
   let exts = deepcopy(s:cscope_file_extensions)

   " surround with quotes and add .* to beginning
   call map(exts, '"\"*." . v:val . "\""')

   " prepend the string -iname
   call map(exts, '"-iname " . v:val')

   " find uses -o flag to separate flags.
   let join_str = join(exts, ' -o ')

   " finda command
   let find_command = 'find . ' . join_str

   execute 'silent !' . find_command . ' > cscope.files'
   silent !cscope -b -q
   cs reset
   redraw!
endfunction

"regenerate cscope
nmap <F6> :call <SID>GenerateCscopeIndex()<cr>

" }}}

"""""""""""""""""""""""""""TAGBAR""""""""""""""""""""""""""""" {{{

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

if executable('lushtags')
    let g:tagbar_type_haskell = {
            \ 'ctagsbin' : 'lushtags',
            \ 'ctagsargs' : '--ignore-parse-error --',
            \ 'kinds' : [
                \ 'm:module:0',
                \ 'e:exports:1',
                \ 'i:imports:1',
                \ 't:declarations:0',
                \ 'd:declarations:1',
                \ 'n:declarations:1',
                \ 'f:functions:0',
                \ 'c:constructors:0'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
                \ 'd' : 'data',
                \ 'n' : 'newtype',
                \ 'c' : 'constructor',
                \ 't' : 'type'
            \ },
            \ 'scope2kind' : {
                \ 'data' : 'd',
                \ 'newtype' : 'n',
                \ 'constructor' : 'c',
                \ 'type' : 't'
            \ }
        \ }
 endif

" }}}
 
"""""""""""""""""""""""""""Clojure""""""""""""""""""""""""""""" {{{
let vimclojure#WantNailgun=1


" }}}

"""""""""""""""""""""""""""Syntastic""""""""""""""""""""""""""""" {{{
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python', 'javascript'],
                           \ 'passive_filetypes': ['java', 'scala'] }

" E221 - multiple spaces before operator.  Nice to lineup =.
" E241 - multiple spaces after :.  Nice to lineup dicts. 
" E272 - multiple spaces before keyword.  Nice to lineup import.
" W404 - import *, unable to detected undefined names.
" W801 - redefinition of unused import, try/except import fails.
let g:syntastic_python_flake8_args = "--ignore=E221,E241,E272,W404,W801"

" }}}

"""""""""""""""""""""""""""SNIPMATE""""""""""""""""""""""""""""" {{{
let g:snippets_dir=vimHome."/bundle/snipmate-snippets/snippets"

" }}}

"""""""""""""""""""""""""""JAVA SPECIFIC""""""""""""""""""""""""""""" {{{
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


" }}}

"""""""""""""""""""""""""""JAVA CHECKSTYLE""""""""""""""""""""""""""""" {{{
let java_checkstyle_dir = "/usr/local/code/other/checkstyle-5.6/"
let g:syntastic_java_checkstyle_classpath= java_checkstyle_dir . 'checkstyle-5.6-all.jar'
let g:syntastic_java_checkstyle_conf_file= java_checkstyle_dir . 'sun_checks.xml'

" }}}

"""""""""""""""""""""""""""C SPECIFIC""""""""""""""""""""""""""""" {{{
"autocmd FileType c set foldmethod=syntax


" }}}

"""""""""""""""""""""""""""CONQUETERM""""""""""""""""""""""""""""" {{{
let g:ConqueTerm_EscKey = '<C-j>'
let g:ConqueTerm_ReadUnfocused = 1

" }}}

"""""""""""""""""""""""""""gradle""""""""""""""""""""""""""""" {{{

au BufNewFile,BufRead *.gradle set filetype=groovy

" }}}

"""""""""""""""""""""""""""SUPERTAB""""""""""""""""""""""""""" {{{

"set completion type to change based on context around it
let g:SuperTabDefaultCompletionType = 'context'

"Helps with completions not autofinishing first match
set completeopt=longest,menu,preview


" }}}

"""""""""""""""""""""""""""PYTHON""""""""""""""""""""""""""" {{{
au FileType python set omnifunc=pythoncomplete#Complete

" }}}

"""""""""""""""""""""""""""TABULAR""""""""""""""""""""""""""" {{{
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" }}}

"""""""""""""""""""""""""""YankRing""""""""""""""""""""""""""" {{{
nmap <Leader>r :YRShow<CR>

" }}}

"""""""""""""""""""""""""""ECLIM"""""""""""""""""""""""""""""" {{{

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

" }}}

"""""""""""""""""""""""""""MAPPINGS""""""""""""""""""""""""""" {{{

"Taglist
"nnoremap <silent> <cr> :TlistToggle<CR>
"let Tlist_WinWidth=40
nnoremap <leader><CR> :TagbarToggle<CR>

"change to next and previous buffers
noremap <silent> <C-h> :bp<CR>
noremap <silent> <C-l> :bn<CR>

"change to next quickfix error
noremap <silent><leader>h :cp<CR>
noremap <silent><leader>l :cn<CR>

"caps to escape
map! <C-j> <Esc>
map <C-j> <Esc>

"Yank till end of line
"D deletes till end, C changes till end, Y should yank till end
"By default it yanks whole line
nnoremap Y y$

"QuickFix List clear
"Important that, stty -ixon, is set, to allow this sequence to pass through
nnoremap <C-q> :call setqflist([])<CR>

"Trick if forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

"VCSVimDiff
nnoremap <silent><leader>v :VCSVimDiff<CR>

"Use emacs bindings for command mode.
" start of line
:cnoremap <C-A> <Home>
" back one character
:cnoremap <C-B> <Left>
" delete character under cursor
:cnoremap <C-D> <Del>
" end of line
:cnoremap <C-E> <End>
" forward one character
:cnoremap <C-F> <Right>
" recall newer command-line
:cnoremap <C-N> <Down>
" recall previous (older) command-line
:cnoremap <C-P> <Up>
" back one word
:cnoremap <Esc><C-B>	<S-Left>
" forward one word
:cnoremap <Esc><C-F>	<S-Right>

"markdown spellcheck by default
autocmd FileType markdown setlocal spell

"Open vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"Redirect to selction register
funct! Redir(command)
  exec 'redir @*'
  exec a:command
  redir END
endfunct

"expose redirect as command
command! -nargs=+ R call call(function('Redir'), [<q-args>])

" Disable Ex mode shortcut key. Make Q repeate last macro
" http://vimbits.com/bits/263
nnoremap Q @@

" Make regexes better by making regex magic
" :help /\v
"nnoremap / /\v
"nnoremap ? /\v
"vnoremap / /\v
"vnoremap ? ?\v
"cnoremap s/ s/\v
"cnoremap %s/ %s/\v

" find closest ( [ {, and delete/change/visual select it.
" silent is required so that the normal command contiunes on error.
" This means that even if the character '(' is not found, the selection
" still occurs.
vnoremap in( :<c-u>silent normal! f(vi(<cr>
onoremap in( :<c-u>silent normal! f(vi(<cr>
onoremap in) :<c-u>silent normal! f)vi)<cr>
vnoremap in[ :<c-u>silent normal! f[vi[<cr>
onoremap in[ :<c-u>silent normal! f[vi[<cr>
onoremap in] :<c-u>silent normal! f]vi]<cr>
vnoremap in{ :<c-u>silent normal! f{vi{<cr>
onoremap in{ :<c-u>silent normal! f{vi{<cr>
onoremap in} :<c-u>silent normal! f}vi}<cr>

" remove trailing whitespace and remain at current position
nnoremap <leader>W mz:%s/\s\+$//g<cr>`z

" }}}

""""""""""""""""""""""""""""""Ack Operator"""""""""""""""""""""""""""""" {{{
"
"""""""""""" viw<leader>g , <leader>g4w, <leader>gt;, <leader>gi[

nnoremap <leader>g :set operatorfunc=<SID>AckOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>AckOperator(visualmode())<cr>

" argument is the type of selection (characterwise, linewise, or block)
function! s:AckOperator(type)
   " Save the unamed register
   let saved_register = @@

   " Handle visual mode, operatorfunc, or else do nothing
   if a:type ==# 'v'
      normal! `<v`>y
   elseif a:type ==# 'char'
      normal! `[v`]y
   else
      return
   endif

   " Copy shellescaped values from unnamed register
   silent execute "Ack! -a " . shellescape(@@)

   let @@ = saved_register
endfunction

" }}}

""""""""""""""""""""""""""""""NERDTree"""""""""""""""""""""""""""""" {{{

"NERDTree Ctrl-n for nerdtree
nnoremap <silent><leader>n :NERDTreeToggle<CR>

"change nerdtree directory to directory containing current file Ctr-d goto dir
nnoremap <silent> <C-d> :NERDTree %:h<CR>

"ignore files
let NERDTreeIgnore=['\.pyc$', '\~$']

" }}}

""""""""""""""""""""""""""""""Clang_complete"""""""""""""""""""""""""""""" {{{
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


" }}}

""""""""""""""""""""""""""""""AcK"""""""""""""""""""""""""""""" {{{
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
if !empty(matchstr(hostname(), "ebox"))
    let g:ackprg="ack -H --nocolor --nogroup --column"
endif

" }}}

""""""""""""""""""""""""""""""AcK"""""""""""""""""""""""""""""" {{{
"narrow window vertical
let g:nrrw_rgn_vert = 1
let g:nrrw_rgn_wdth = 80 

" }}}

"""""""""""""""""""""""""""""""PROJECT SPECFIC FUNCTIONS"""""""""""""""""""""""""""""" {{{

function! AntSingle()
    "change ant single to current file
    ! python ~/code/eric/scripts/change_ant_single.py %:p && ant single
endfunction

function! Markdownify()
    "markdown current file to html
    let l:urlSpacesRemoved = substitute(expand("%:p"), " ", "\\\\ ", "g")
    execute '!/usr/local/code/jesse/bin/markdown2html -i ' . l:urlSpacesRemoved . ' -g'
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

" }}}
