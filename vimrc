""""""""""""""""System"""""""""""""""""""" {{{
" Known machines
let UNKNOWN_MACHINE = 0
let HOME_LAPTOP     = 1
let HOME_DESKTOP    = 2
let WORK_LAPTOP     = 3

function! CurrentMachine()
   let hostname = hostname()

   if hostname == "ebox"
      return g:HOME_LAPTOP
   elseif hostname == "emachine"
      return g:HOME_DESKTOP
   elseif hostname == "etrans"
      return g:WORK_LAPTOP
   else
      return g:UNKNOWN_MACHINE
   endif
endfunction

let MACHINE = CurrentMachine()

if MACHINE == HOME_LAPTOP
    let vimHome="/Users/eric/.vim"
    let tmpDir="/Users/eric/code/.tmpvim"
elseif MACHINE == HOME_DESKTOP
    let vimHome="/home/eric/.vim"
    let tmpDir="/home/eric/code/.tmpvim"
elseif MACHINE == WORK_LAPTOP
    let vimHome="/Users/eric/.vim"
    let tmpDir=vimHome."/.tmpvim"
else
    " Set home to directory of this vimrc file
    let vimHome=expand("%:p:h")
    let tmpDir="/tmp"
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
" Bundle 'git@github.com:esiegel/snipmate-snippets.git'

" Must come before tabular plugin
Bundle 'plasticboy/vim-markdown'

" Original repos on github
Bundle 'AndrewRadev/linediff.vim'
Bundle 'Keithbsmiley/swift.vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'Rip-Rip/clang_complete'
Bundle 'Shougo/vimproc.vim'
Bundle 'SirVer/ultisnips'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'eagletmt/neco-ghc'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'honza/vim-snippets'
Bundle 'jnwhiteh/vim-golang'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'lukaszkorecki/CoffeeTags'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/emmet-vim'
Bundle 'mileszs/ack.vim'
Bundle 'msanders/cocoa.vim'
Bundle 'nsf/gocode', {'rtp': 'vim/'}
Bundle 'riobard/scala.vim'
Bundle 'rking/ag.vim'
Bundle 'rosenfeld/conque-term'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sorin-ionescu/python.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'tikhomirov/vim-glsl'
Bundle 'tomasr/molokai'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/timl'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-characterize'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-scriptease'
Bundle 'tpope/vim-surround'

" vim-scripts repo
Bundle 'AnsiEsc.vim'
Bundle 'BusyBee'
Bundle 'Color-Sampler-Pack'
Bundle 'Jinja'
Bundle 'L9'
Bundle 'a.vim'
Bundle 'cscope_macros.vim'
Bundle 'summerfruit256.vim'

" non github repos
Bundle 'git://repo.or.cz/vcscommand'

" split from vim to nvim
if has('nvim')
  Bundle 'benekastah/neomake'
else
  Bundle 'scrooloose/syntastic'
endif

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
hi Search cterm=inverse ctermbg=NONE ctermfg=NONE gui=inverse guibg=NONE guifg=NONE

"clipboard
set clipboard=unnamed

"matches previous indent level,
"intelligently guesses indent (code level)
set autoindent
set smartindent

"tab = 2 spaces "indent spaces = 2 and tab to spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

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

"don't wrap long lines
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

"set status line to always
set laststatus=2

"Necessary to show unicode glyphs
set encoding=utf-8 " necessary to show unicode glyphs

"Setup backup location and enable
let &backupdir=tmpDir . "/backup"
let &directory=tmpDir . "/swap"
let &undodir=tmpDir. "/undo"
set backup
set undolevels=1000
set undoreload=1000

"wildmode enables better file viewing when opeing new files, like bash
set wildmenu
set wildmode=longest,list,list:full
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

" new horizontal splits will be placed below
" new vertical splits will be placed to the right
set nosplitbelow
set splitright

" Options for diff mode
"   filler: show blank filler lines
"   vertical: split vertical
set diffopt=filler,vertical

" }}}

"""""""""""""""""""""""""""ABBREVIATIONS""""""""""""""""""""
iabbr :thumbs_up: 👍 
iabbr :thumbs_down: 👎 
iabbr :poo: 💩

"""""""""""""""""""""""""""XIKI""""""""""""""""""""""""""""" {{{
let $XIKI_DIR = "/usr/local/rvm/gems/ruby-1.9.3-head@global/gems/xiki-0.6.5"
if filereadable($XIKI_DIR)
   source /usr/local/rvm/gems/ruby-1.9.3-head@global/gems/xiki-0.6.5/etc/vim/xiki.vim
endif

" }}}

"""""""""""""""""""""""""""React""""""""""""""""""""""""""""" {{{
function! ReactProps()
  " Gets the the uniq list of referenced propTypes of the current file
  let regex    = shellescape("@props\.[a-zA-Z_-]+")
  let filepath = shellescape(expand("%:p"))
  let command  = "ag -o " . regex  . " " .  filepath . " | sort | uniq"
  let @* = system(command)
endfunction

function! ReactState()
  " Gets the the uniq list of referenced propTypes of the current file
  let regex    = shellescape("@state\.[a-zA-Z_-]+")
  let filepath = shellescape(expand("%:p"))
  let command  = "ag -o " . regex  . " " .  filepath . " | sort | uniq"
  let @* = system(command)
endfunction

" }}}

"""""""""""""""""""""""""""CTAGS""""""""""""""""""""""""""""" {{{

"Tags files
"autocmd FileType java set tags+=~/.vim/tags/java_tags
"autocmd FileType python set tags+=~/.vim/tags/python_tags

" file extensions to search for when regenerating cscope index
let s:cscope_file_extensions = ["c", "cpp", "cc",
                               \"c++", "h", "hpp",
                               \"java", "py", "scala"]

function! s:GenerateAndAddCscopeIndex()
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
   silent! !cscope -b -q
   silent! cscope add cscope.out
   silent! cscope reset

   redraw!
endfunction

"regenerate cscope
nmap <F6> :call <SID>GenerateAndAddCscopeIndex()<cr>

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

if executable('hasktags')
    let g:tagbar_type_haskell = {
            \ 'ctagsbin' : 'hasktags',
            \ 'ctagsargs' : '-c -x -o -',
            \ 'sro' : '.',
            \ 'kinds' : [
                \ 'c:class:0:0',
                \ 'cons:cons:1:0',
                \ 'c_a:consaccessor:1:0',
                \ 'c_gadt:consgadt:1:0',
                \ 'd:data:1:0',
                \ 'd_gadt:datagadt:1:0',
                \ 'fi:funcimpl:1:0',
                \ 'ft:function:0:0',
                \ 'm:module:1:0',
                \ 'nt:newtype:1:0',
                \ 'o:other:1:0',
                \ 't:type:1:0'
            \ ]
        \ }
 endif

 let g:tagbar_type_go = {
     \ 'ctagstype' : 'go',
     \ 'kinds'     : [
         \ 'p:package',
         \ 'i:imports:1',
         \ 'c:constants',
         \ 'v:variables',
         \ 't:types',
         \ 'n:interfaces',
         \ 'w:fields',
         \ 'e:embedded',
         \ 'm:methods',
         \ 'r:constructor',
         \ 'f:functions'
     \ ],
     \ 'sro' : '.',
     \ 'kind2scope' : {
         \ 't' : 'ctype',
         \ 'n' : 'ntype'
     \ },
     \ 'scope2kind' : {
         \ 'ctype' : 't',
         \ 'ntype' : 'n'
     \ },
     \ 'ctagsbin'  : 'gotags',
     \ 'ctagsargs' : '-sort -silent'
     \ }

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
" E203 - whitespace before ':'
let g:syntastic_python_flake8_args = "--max-line-length=119 " .
                                    \"--ignore=E203,E221,E241,E272,W404,W801"

"coffee
let g:syntastic_coffee_coffeelint_args = "--file=./.coffeelint.json"

"ruby
"let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_ruby_checkers = ['rubocop']

" Show syntastic error map
nnoremap <leader>e :Errors<cr>

" }}}

"""""""""""""""""""""""""""ULTISNIPS""""""""""""""""""""""""""""" {{{
" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-r><tab>"

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
function! s:ToggleConqueTerm()
   " There is a bug in conque_term#get_instance() when there isn't an instance
   " so we will use the global list of terminals instead.
   if !exists("g:ConqueTerm_Terminals") || len(g:ConqueTerm_Terminals) == 0

      " no conque split if only buffer is no name buffer.
      if bufnr('$') == 1 && bufname(1) == ""
         ConqueTerm zsh
      else
         ConqueTermVSplit zsh
      endif

      return
   endif

   " Current buffer information
   let current_buffer_nr = bufnr("")

   " conque term information
   let term_info   = conque_term#get_instance()
   let buffer_name = term_info['buffer_name']
   let buffer_nr   = bufnr(buffer_name)
   let buffer_win  = bufwinnr(buffer_nr)

   if buffer_win == -1
      " open window
      execute 'vs ' . buffer_name
   else
      " close conque window
      if current_buffer_nr != buffer_nr
         execute buffer_win . "wincmd w"
         wincmd c
         execute bufwinnr(current_buffer_nr) . "wincmd w"
      else
         wincmd c
      endif
   endif
endfunction

let g:ConqueTerm_EscKey = '<C-j>'
let g:ConqueTerm_ReadUnfocused = 1

" open all new files in the current window by default
let g:ctrlp_reuse_window = '.*'

nnoremap <Leader>z :call <SID>ToggleConqueTerm()<CR>

" }}}

"""""""""""""""""""""""""""gradle""""""""""""""""""""""""""""" {{{

autocmd BufNewFile,BufRead *.gradle set filetype=groovy

" }}}

"""""""""""""""""""""""""""SUPERTAB""""""""""""""""""""""""""" {{{

"set completion type to change based on context around it
let g:SuperTabDefaultCompletionType = 'context'

"select first result.
"   Disabled until this is fixed.
"   https://github.com/ervandew/supertab/issues/162
"let g:SuperTabLongestHighlight = 1

"tab again for next longest completion
let g:SuperTabLongestEnhanced = 1

let g:SuperTabContextTextOmniPrecedence = ['&completefunc', '&omnifunc']

"Helps with completions not autofinishing first match
set completeopt=longest,menu,preview


" }}}

"""""""""""""""""""""""""""PYTHON""""""""""""""""""""""""""" {{{
autocmd FileType python set omnifunc=pythoncomplete#Complete

" }}}

"""""""""""""""""""""""""""TABULAR""""""""""""""""""""""""""" {{{
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize /:\zs/l0r1<CR>
vnoremap <Leader>a: :Tabularize /:\zs/l0r1<CR>
nnoremap <Leader>a, :Tabularize /,\zs/l0r1<CR>
vnoremap <Leader>a, :Tabularize /,\zs/l0r1<CR>

" }}}

"""""""""""""""""""""""""""FUGITIVE""""""""""""""""""""""""""""" {{{
nnoremap <leader>d :Gdiff master<CR>

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
function! Redir(command)
  exec 'redir @*'
  exec a:command
  redir END
endfunction

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
" silent! is required so that the normal command contiunes on error.
" This means that even if the character '(' is not found, the selection
" still occurs.
vnoremap in" :<c-u>silent! normal! f"vi"<cr>
onoremap in" :<c-u>silent! normal! f"vi"<cr>
vnoremap in' :<c-u>silent! normal! f'vi'<cr>
onoremap in' :<c-u>silent! normal! f'vi'<cr>
vnoremap in( :<c-u>silent! normal! f(vi(<cr>
onoremap in( :<c-u>silent! normal! f(vi(<cr>
onoremap in) :<c-u>silent! normal! f)vi)<cr>
vnoremap in[ :<c-u>silent! normal! f[vi[<cr>
onoremap in[ :<c-u>silent! normal! f[vi[<cr>
onoremap in] :<c-u>silent! normal! f]vi]<cr>
vnoremap in{ :<c-u>silent! normal! f{vi{<cr>
onoremap in{ :<c-u>silent! normal! f{vi{<cr>
onoremap in} :<c-u>silent! normal! f}vi}<cr>

" remove trailing whitespace, save buffer, and remain at current position
nnoremap <leader>W mz:%s/\s\+$//g<cr>:w<cr>`z

" }}}

""""""""""""""""""""""""""""""Ack Operator"""""""""""""""""""""""""""""" {{{
"
"""""""""""" viw<leader>g , <leader>g4w, <leader>gt;, <leader>gi[

nnoremap <leader>g :set operatorfunc=<SID>AgOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>AgOperator(visualmode())<cr>

" argument is the type of selection (characterwise, linewise, or block)
function! s:AgOperator(type)
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
   silent execute "Ag! " . shellescape(@@)

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
let g:clang_snippets_engine="ultisnips"

" display errors on save
autocmd BufWritePost {*.c,*.cpp,*.cc,*.h,*.hpp} :call g:ClangUpdateQuickFix()

let g:clang_use_library=1
let g:clang_user_options='-stdlib=libc++ -std=c++11'
let g:clang_auto_user_options = '.clang_complete'

if MACHINE == HOME_LAPTOP
   let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
elseif MACHINE == HOME_DESKTOP
   let g:clang_library_path="/usr/lib/llvm-3.4/lib/libclang.so.1"
endif

" }}}

""""""""""""""""""""""""""""""AcK"""""""""""""""""""""""""""""" {{{
if MACHINE == HOME_LAPTOP
    let g:ackprg="ack"
elseif MACHINE == HOME_DESKTOP
   let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif

" }}}

""""""""""""""""""""""""""""""Ctrlp"""""""""""""""""""""""""""""" {{{
" searches for nearest ancestor with projext.xml .git .hg .svn .bzr _darcs
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_root_markers = ['project.xml']

" have match window at bottom and display results top to bottom
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:40'

" default normal map to open file search
let g:ctrlp_map = '<leader>f'

" ctrlp enabled extensions
let g:ctrlp_extensions = ['buffertag',
                         \'funky',
                         \'quickfix',
                         \'tag']
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

" map to open MRU mode
nnoremap <leader>b :CtrlPBuffer<CR>
" }}}

"""""""""""""""""""""""""""""""MARKDOWN

" disable folding
let g:vim_markdown_folding_disabled=1

"""""""""""""""""""""""""""""""HTML, CSS (Emmet plugin)
let g:user_emmet_leader_key = '<c-y>'

"""""""""""""""""""""""""""""""FILETYPE MAPPINGS

" show all files that have hpp in extension as cpp
autocmd BufNewFile,BufRead *.hpp* set filetype=cpp
autocmd BufNewFile,BufRead *.tpp* set filetype=cpp

" markdown extension mappings
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.mkd set filetype=markdown
autocmd BufNewFile,BufRead *.markdown set filetype=markdown
