""""""""""""""""System"""""""""""""""""""" {{{
" Known machines
let UNKNOWN_MACHINE = 0
let HOME_LAPTOP     = 1
let HOME_DESKTOP    = 2
let WORK_LAPTOP     = 3

function! CurrentMachine()
   let hostname = hostname()

   if hostname == "etrans"
      return g:HOME_LAPTOP
   elseif hostname == "emachine"
      return g:HOME_DESKTOP
   elseif hostname == "fpx-l-US00953"
      return g:WORK_LAPTOP
   else
      return g:UNKNOWN_MACHINE
   endif
endfunction

let MACHINE = CurrentMachine()

if MACHINE == HOME_LAPTOP
    let vimHome="/Users/eric/.vim"
    let tmpDir=vimHome."/.tmpvim"
elseif MACHINE == HOME_DESKTOP
    let vimHome="/home/eric/.vim"
    let tmpDir="/home/eric/code/.tmpvim"
elseif MACHINE == WORK_LAPTOP
    let vimHome="/Users/eric.siegel/.vim"
    let tmpDir=vimHome."/.tmpvim"
else
    " Set home to directory of this vimrc file
    let vimHome=expand("$HOME/.vim")
    let tmpDir=vimHome."/.tmpvim"
endif

" make tmp directories
if !isdirectory(tmpDir)
  call mkdir(tmpDir)
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
exec 'source ' . vimHome . "/vim-plug/plug.vim"

" Call plug with path to bundles. Default, only check .vim dir.
call plug#begin(vimHome . "/bundle")

" Plugs :
" Plug 'git@github.com:esiegel/snipmate-snippets.git'

" Must come before tabular plugin
Plug 'plasticboy/vim-markdown'

" Add maktaba, glaive, and codefmt to the runtimepath.
" (Glaive must also be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
Plug 'google/vim-codefmt'

" Original repos on github
Plug 'AndrewRadev/linediff.vim'
Plug 'AndrewRadev/sideways.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'Olical/vim-enmasse'
Plug 'Shougo/vimproc.vim'
Plug 'SirVer/ultisnips'
Plug 'altercation/vim-colors-solarized'
Plug 'aserebryakov/vim-todo-lists'
Plug 'bling/vim-airline'
Plug 'chrisbra/Colorizer'
Plug 'coderifous/textobj-word-column.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'jonathanfilip/vim-lucius'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'kassio/neoterm'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-grepper'
Plug 'morhetz/gruvbox'
Plug 'pelodelfuego/vim-swoop'
Plug 'prabirshrestha/vim-lsp'
Plug 'romainl/Apprentice'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tomasr/molokai'
Plug 'tomtom/tlib_vim'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/timl'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'

" language based
Plug 'Keithbsmiley/swift.vim',         { 'for': 'swift' }
Plug 'Rip-Rip/clang_complete',         { 'for': ['c', 'c++', 'cpp'] }
Plug 'derekwyatt/vim-scala',           { 'for': 'scala' }
Plug 'eagletmt/ghcmod-vim',            { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc',              { 'for': 'haskell' }
Plug 'elixir-lang/vim-elixir',         { 'for': 'elixir' }
Plug 'fatih/vim-go',                   { 'for': 'go' }
Plug 'jparise/vim-graphql',            { 'for': 'graphql' }
Plug 'kchmck/vim-coffee-script',       { 'for': 'coffee' }
Plug 'leafgarland/typescript-vim',     { 'for': 'typescript' }
Plug 'lukaszkorecki/CoffeeTags',       { 'for': 'coffee' }
Plug 'msanders/cocoa.vim',             { 'for': 'swift' }
Plug 'mxw/vim-jsx',                    { 'for': 'javascript.jsx' }
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'pangloss/vim-javascript',        { 'for': ['javascript', 'javascript.jsx', 'jsx'] }
Plug 'rust-lang/rust.vim',             { 'for': 'rust' }
Plug 'sorin-ionescu/python.vim',       { 'for': 'python' }
Plug 'tikhomirov/vim-glsl',            { 'for': 'glsl' }

" for martian syntax highlighting
"   Add the plugin via Plug, but it isn't in a recognized vim structure
"   Add the filetype
"   Add the syntax highlighting
Plug 'martian-lang/martian', { 'rtp': 'tools/syntax' }
au BufRead,BufNewFile *.mro		setfiletype martian
au BufRead,BufNewFile *.mro		exec 'source ' . vimHome . "/bundle/martian/tools/syntax/vim/martian.vim"


" vim-scripts repo
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'vim-scripts/BusyBee'
Plug 'vim-scripts/Color-Sampler-Pack'
Plug 'vim-scripts/Jinja'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/a.vim'
"Plug 'vim-scripts/cscope_macros.vim'
Plug 'vim-scripts/summerfruit256.vim'

call plug#end()

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
if $TMUX == ''
  set clipboard+=unnamedplus,unnamed
endif

"colorscheme solarized
set background=dark
" colorscheme BusyBee
" colorscheme codedark 
colorscheme gruvbox

"inverse search
hi Search cterm=inverse ctermbg=NONE ctermfg=NONE gui=inverse guibg=NONE guifg=NONE

"matches previous indent level,
"intelligently guesses indent (code level)
set autoindent
set smartindent

" load files that have changed on disk
set autoread

" remember last N commands
set history=1000

"tab = 2 spaces "indent spaces = 2 and tab to spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"allowing backspace to work after indent -> see :help i_backspacing
set backspace=indent,eol,start

" Allows execution of local vimrc files, and enables project specific vimrc
" disallows the use of autocmd, shell, and write within the exrc files
set exrc
set secure

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
noremap <silent> <Space> :silent noh<Bar>echo<CR>

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
set undofile

if !isdirectory(&backupdir)
  call mkdir(&backupdir)
endif
if !isdirectory(&directory)
  call mkdir(&directory)
endif
if !isdirectory(&undodir)
  call mkdir(&undodir)
endif

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
set diffopt=filler,vertical,internal,algorithm:patience

" map gp to select recently pasted text
" fancier `[v`]
" http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" enable 24 bit colors
set termguicolors

" update formating options.
set formatoptions +=c " auto-wrap comments at textwidth
set formatoptions +=j " remove comment leader when joining lines
set formatoptions +=r " insert comment leader after <enter> in insert mode

if has('nvim')
else
  " save state on vim close
  set viminfo  ='100              " previously edited files marks, required.
  set viminfo +=/10              " search pattern items history
  set viminfo +=:10              " command line history
  set viminfo +=f1               " save file marks
  set viminfo +=h                " disable hlsearch
  set viminfo +=s10              " maximum number of KB to save from a register
  set viminfo +=n~/.vim/viminfo  " set viminfo file name
endif

" }}}

"""""""""""""""""""""""""""ABBREVIATIONS""""""""""""""""""""
iabbr :thumbs_up: ð
iabbr :thumbs_down: ð
iabbr :poo: ð©
iabbr :check: ✔

"""""""""""""""""""""""""TERMINAL""""""""""""""""""""""""""""""" {{{
" escape to terminal normal
tnoremap <C-j> <C-W>N

function! SendToTerm(what)
  call term_sendkeys('', a:what)
  return ''
endfunc

function! s:ToggleTerm()
  " find terminals zsh
  let shell_numbers = filter(term_list(), 'bufname(v:val) =~ "zsh"')

  " Either replace the default welcome buffer, or split the terminal
  if len(shell_numbers) == 0
    if bufnr('$') == 1 && bufname(1) == ""
      terminal ++curwin 
    else
      vsplit | terminal ++curwin 
    endif

    " early return
    return
  endif

  " Current buffer information
  let current_buffer_nr = bufnr("")

  " Take first shell
  let buffer_nr   = shell_numbers[0]
  let buffer_name = buffer_name(buffer_nr)
  let buffer_win  = bufwinnr(buffer_nr)

  if buffer_win == -1
    " open window
    vsplit | execute "buffer " .  buffer_nr
  else
    " close shell window
    if current_buffer_nr != buffer_nr
      execute buffer_win . "wincmd w"
      wincmd c
      execute bufwinnr(current_buffer_nr) . "wincmd w"
    else
      wincmd c
    endif
  endif
endfunction

nnoremap <Leader>z :call <SID>ToggleTerm()<CR>
" }}}


"""""""""""""""""""""""""""XIKI""""""""""""""""""""""""""""" {{{
let $XIKI_DIR = "/usr/local/rvm/gems/ruby-1.9.3-head@global/gems/xiki-0.6.5"
if filereadable($XIKI_DIR)
   source /usr/local/rvm/gems/ruby-1.9.3-head@global/gems/xiki-0.6.5/etc/vim/xiki.vim
endif

" }}}
"
"""""""""""""""""""""""""""INCSEARCH PLUGIN OVERRIDES""""""""""""""""""""""""""""" {{{
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)

" Add auto nohls, auto removes highlighting
":h g:incsearch#auto_nohlsearch
"set hlsearch
"let g:incsearch#auto_nohlsearch = 1
"map n  <Plug>(incsearch-nohl-n)
"map N  <Plug>(incsearch-nohl-N)
"map *  <Plug>(incsearch-nohl-*)
"map #  <Plug>(incsearch-nohl-#)
"map g* <Plug>(incsearch-nohl-g*)
"map g# <Plug>(incsearch-nohl-g#)

"}}}

"""""""""""""""""""""""""""React""""""""""""""""""""""""""""" {{{
function! ReactProps()
  " Gets the the uniq list of referenced propTypes of the current file
  let regex    = shellescape("@props\.[a-zA-Z_-]+")
  let filepath = shellescape(expand("%:p"))
  let command  = "rg -o " . regex  . " " .  filepath . " | sort | uniq"
  let @* = system(command)
endfunction

function! ReactState()
  " Gets the the uniq list of referenced propTypes of the current file
  let regex    = shellescape("@state\.[a-zA-Z_-]+")
  let filepath = shellescape(expand("%:p"))
  let command  = "rg -o " . regex  . " " .  filepath . " | sort | uniq"
  let @* = system(command)
endfunction

" "aY this to convert proptypes into static proptypes
"dt{istatic get PrkbkbpropTy	() oreturn {};jvi{ojjxkkpgp>,a:

" }}}
"
"""""""""""""""""""""""""""golang""""""""""""""""""""""""""""" {{{
" let g:go_debug = ["shell-commands", "lsp"]
let g:go_code_completion_enabled = 1
let g:go_gopls_enabled = 1
let g:go_doc_popup_window = 1

" disable function information when cycling through completions
let g:go_echo_go_info = 0

" hopefully now on save, and on GoFmt, this doesn't destroy the undo history
let g:go_fmt_experimental = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" }}}

"""""""""""""""""""""""""""rust""""""""""""""""""""""""""""" {{{

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'allowlist': ['rust'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
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

 "rust
 let g:tagbar_type_rust = {
   \ 'ctagstype' : 'rust',
   \ 'kinds' : [
     \'T:types',
     \'f:functions',
     \'g:enumerations',
     \'s:structures',
     \'m:modules',
     \'n:modules',
     \'c:constants',
     \'t:traits',
     \'i:trait implementations',
   \ ]
   \ }

let g:tagbar_type_martian= {
   \ 'ctagstype' : 'martian',
   \ 'kinds' : [
      \'p:pipelines',
      \'s:stages',
   \ ]
\ }

let g:tagbar_type_typescript= {
   \ 'ctagstype' : 'typescript',
   \ 'kinds' : [
      \'c:classes',
      \'n:modules',
      \'f:functions',
      \'v:variables',
      \'v:varlambdas',
      \'m:members',
      \'i:interfaces',
      \'e:enums',
      \'I:imports',
   \ ]
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
let g:ale_python_flake8_options = "--max-line-length=119 " .
                                  \"--ignore=E203,E221,E241,E272,W404,W801"

let g:ale_c_cc_executable = "clang"
let g:ale_c_cc_options = "-std=c11 -Wall -I/Library/Developer/CommandLineTools/usr/include"


"coffee
let g:syntastic_coffee_coffeelint_args = "--file=./.coffeelint.json"

" Show ale error map
nnoremap <leader>el :lopen<cr>

let g:ale_linters = {
\  'coffee': ['coffeelint'],
\  'javascript': ['eslint'],
\  'typescriptreact': ['eslint'],
\  'go': ['golangci_lint', 'gopls'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'typescriptreact': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'css': ['prettier'],
\}

let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_set_highlights = 0
let g:ale_fix_on_save = 1

" }}}

"""""""""""""""""""""""""""ULTISNIPS""""""""""""""""""""""""""""" {{{
" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-r><tab>"

" private snippets
let g:UltiSnipsSnippetsDir="~/.vim/private_snippets"

" update to allow searching for private directory.
let g:UltiSnipsSnippetDirectories=["private_snippets", "UltiSnips"]

" vertical split
let g:UltiSnipsEditSplit='vertical'

" use snipmate snippets as well.  Will exist in snippets directories.
let g:UltiSnipsEnableSnipMate=1
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

"""""""""""""""""""""""""""gradle""""""""""""""""""""""""""""" {{{

autocmd BufNewFile,BufRead *.gradle set filetype=groovy

" }}}

"""""""""""""""""""""""""""SUPERTAB""""""""""""""""""""""""""" {{{

"set completion type to change based on context around it
let g:SuperTabDefaultCompletionType = 'context'

"select first result.
"   Disabled until this is fixed.
"   https://github.com/ervandew/supertab/issues/162
let g:SuperTabLongestHighlight = 1

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
nnoremap <Leader>a<Space> :Tabularize / \zs/l0r1<CR>
vnoremap <Leader>a<Space> :Tabularize / \zs/l0r1<CR>

" Aligns es6 module 'from' and sorts
function! AlignJSFrom()
  " align from
  call Tabularize('/from')

  " select region and sort by from column
  " TODO: look for a better way.
  execute 'normal! vis:sort /from.*/ r'
endfunction

" expose method as Named Plug, so that we can use it with repeat.vim, which
" needs a function by name.
nmap <silent> <Plug>AlignJSFrom :call AlignJSFrom()<CR>
      \:call repeat#set("\<Plug>AlignJSFrom")<CR>

" And the mapping to the plug
nmap <Leader>afrom <Plug>AlignJSFrom

" }}}

"""""""""""""""""""""""""""FUGITIVE""""""""""""""""""""""""""""" {{{
"git diff main
nnoremap <leader>d :Gdiff main<CR>

"git diff files
nnoremap <silent><leader>v :Gdiff<CR>


function! MagicDiffStart()
  let original_bufnr = bufnr('%')
  exec 'diffthis'

  exec 'vsplit'
  exec '0Gclog'

  " Get the buffer numbers from the quick fix list.
  " Looks like:
  "   [{'lnum': 0, 'bufnr': 233, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1,
  "     'type': '', 'pattern': '', 'text': 'vim-repeat + a colortheme.'}]
  let g:magic_diff_buffer_numbers = [original_bufnr] + map(getqflist(), 'v:val["bufnr"]')
  let g:magic_diff_buffer_index1  = 0
  let g:magic_diff_buffer_index2  = 1

  exec 'diffthis'
endfunction

function! MagicDiffSwap()
  if g:magic_diff_buffer_index2 + 1 < len(g:magic_diff_buffer_numbers)
    let old_bufnr1 = g:magic_diff_buffer_numbers[g:magic_diff_buffer_index1]
    let old_bufnr2 = g:magic_diff_buffer_numbers[g:magic_diff_buffer_index2]
    let win1 = bufwinnr(old_bufnr1)
    let win2 = bufwinnr(old_bufnr2)

    " goto windows and turn off diffing
    exec win1 . 'wincmd w'
    diffoff
    exec win2 . 'wincmd w'
    diffoff

    " increment the indexes and get the new buffer numbers
    let g:magic_diff_buffer_index1 += 1
    let g:magic_diff_buffer_index2 += 1
    let bufnr1 = g:magic_diff_buffer_numbers[g:magic_diff_buffer_index1]
    let bufnr2 = g:magic_diff_buffer_numbers[g:magic_diff_buffer_index2]

    " goto win1
    exec win1 . 'wincmd w'
    exec bufnr1 . 'buffer'
    diffthis

    " goto win2
    exec win2 . 'wincmd w'
    exec bufnr2 . 'buffer'
    diffthis
  endif
endfunction

function! MagicDiffStop()
  let bufnr1 = g:magic_diff_buffer_numbers[g:magic_diff_buffer_index1]
  let bufnr2 = g:magic_diff_buffer_numbers[g:magic_diff_buffer_index2]

  " goto win2 and delete
  exec bufwinnr(bufnr2) . 'wincmd w'
  bdelete

  " goto win1 and open original file.
  exec bufwinnr(bufnr1) . 'wincmd w'
  if bufname('%') =~ '^fugitive:///'
    exec 'Gedit'
  endif

  unlet g:magic_diff_buffer_numbers
  unlet g:magic_diff_buffer_index1
  unlet g:magic_diff_buffer_index2
endfunction

" }}}

"""""""""""""""""""""""""""SURROUND""""""""""""""""""""""""""""" {{{
" indent after surrounding.
let g:surround_indent=1

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
" TODO, figure out better mapping
" nmap <silent><leader>s :JavaImportSort<CR>

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

" Helper methods to go to the first location/error or the next/prev.
function! <SID>LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  catch /^Vim\%((\a\+)\)\=:E42/
  endtry
endfunction

function! <SID>LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  catch /^Vim\%((\a\+)\)\=:E42/
  endtry
endfunction

function! <SID>QfixPrevious()
  try
    cprev
  catch /^Vim\%((\a\+)\)\=:E553/
    clast
  catch /^Vim\%((\a\+)\)\=:E42/
  endtry
endfunction

function! <SID>QfixNext()
  try
    cnext
  catch /^Vim\%((\a\+)\)\=:E553/
    cfirst
  catch /^Vim\%((\a\+)\)\=:E42/
  endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext     :<C-u>exe 'call <SID>LocationNext()'<CR>
nnoremap <silent> <Plug>QfixPrevious     :<C-u>exe 'call <SID>QfixPrevious()'<CR>
nnoremap <silent> <Plug>QfixNext         :<C-u>exe 'call <SID>QfixNext()'<CR>

"change to next quickfix error
nmap <silent><leader>h <Plug>QfixPrevious
nmap <silent><leader>l <Plug>QfixNext

" loads the quickfix filter plugin
packadd cfilter

"change to next locationlist error
nmap <silent><leader>H <Plug>LocationPrevious
nmap <silent><leader>L <Plug>LocationNext

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
autocmd FileType markdown setlocal nospell
autocmd FileType markdown setlocal nowrap

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

" This mapping calls the AgOperator with whatever text object we have pressed
" nnoremap <leader>g :set operatorfunc=<SID>AgOperator<cr>g@

" selects the current word at cursor
nnoremap <leader>g :<c-u>call <SID>AgOperator('char')<cr>
vnoremap <leader>g :<c-u>call <SID>AgOperator(visualmode())<cr>

" argument is the type of selection (characterwise, linewise, or block)
function! s:AgOperator(type)
   " Save the unamed register
   let saved_register = @@

   " Handle visual mode, operatorfunc, or else do nothing
   if a:type ==# 'v'
      normal! `<v`>y
   elseif a:type ==# 'char'
      " when this function is invoked via the operatorfunc
      " `[ will be set with the beginning of the selection and `] with the end
      " normal! `[v`]y

      " yank the word
      normal! viwy
   else
      return
   endif

   " Copy values from unnamed register
   execute "Ag " . "'" . @@ . "'"

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

""""""""""""""""""""""""""""""NERDTree"""""""""""""""""""""""""""""" {{{

" add and remove spaces at beginning of comments
let g:NERDSpaceDelims=1

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
elseif MACHINE == WORK_LAPTOP
   let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
endif

" }}}

""""""""""""""""""""""""""""""Grepper"""""""""""""""""""""""""""""" {{{

let g:grepper = {
    \ 'tools':     ['ag', 'git', 'grep'],
    \ 'open':      1,
    \ 'quickfix':  1,
    \ 'switch':    1,
    \ 'jump':      0,
    \ 'prompt':    0,
    \ 'highlight': 0,
    \ }

" search cword with with leader*
nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>

" search selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" }}}

""""""""""""""""""""""""""""""fzf"""""""""""""""""""""""""""""" {{{
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1


" maps for fzf
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :call <SID>FZFAllFiles()<CR>
nnoremap <leader>b :Buffers<CR>

set grepprg=ag\ --nogroup\ --nocolor

" overwrites FZF_DEFAULT_COMMAND and then resets it so that we search all files.
function! s:FZFAllFiles()
   let initial = $FZF_DEFAULT_COMMAND
   let $FZF_DEFAULT_COMMAND='ag -u -g ""'

   execute ':Files'

   let $FZF_DEFAULT_COMMAND=initial
endfunction

function! s:fzf_yank_results(lines)
  echom '*****'
  echom '*****'
  echom '*****'
  echom '*****'
  echom '*****'
  echom '*****'
  echo '*****'
  echo '*****'
  echo '*****'
  echo '*****'
  echo '*****'
  echo '*****'
  let joined_lines = join(a:lines, "\n")

  if len(a:lines) > 1
    let joined_lines .= "\n"
  endif

  echom '*****'
  echom joined_lines

  let @+ = joined_lines
endfunction

function! s:fzf_ag_raw(cmd, bang)
  let cmd = '--noheading --nobreak '. a:cmd

  " logic taken from fzf internals to pass <bang> operator which toggles full screen.
  call fzf#vim#ag_raw(cmd, a:bang)
endfunction

" Allow Ag to take arguments like --ruby or directory.
autocmd! VimEnter * command! -bang -nargs=* -complete=file Ag :call s:fzf_ag_raw(<q-args>, <bang>0)

" Add keybindings within fzf window
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-b': function('s:fzf_yank_results'),
  \ }

" }}}

"""""""""""""""""""""""""""""""MARKDOWN

" disable folding
let g:vim_markdown_folding_disabled=1

"""""""""""""""""""""""""""""""HTML, CSS (Emmet plugin)
let g:user_emmet_leader_key = '<c-y>'

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

"""""""""""""""""""""""""""""""JSON

"Clean json region using jq
function! JQ(minimize) range
  if a:minimize
    silent! execute a:firstline . "," . a:lastline . '! jq -c .'
  else
    silent! execute a:firstline . "," . a:lastline . '! jq .'
  endif
endfunction

"Convert within visual selection
vnoremap <leader>jq :call JQ(0)<cr>
"Convert entire file
nnoremap <leader>jq :0,$call JQ(0)<cr>

"Minimize within visual selection
vnoremap <leader>JQ :call JQ(1)<cr>
"Minimize entire file
nnoremap <leader>JQ :0,$call JQ(1)<cr>


"""""""""""""""""""""""""""""""FILETYPE MAPPINGS

" show all files that have hpp in extension as cpp
autocmd BufNewFile,BufRead *.hpp* set filetype=cpp
autocmd BufNewFile,BufRead *.tpp* set filetype=cpp

" markdown extension mappings
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.mkd set filetype=markdown
autocmd BufNewFile,BufRead *.markdown set filetype=markdown


"""""""""""""""""""""""""""""""SWOOP
let g:swoopUseDefaultKeyMap = 0
nmap <Leader>s :call Swoop()<CR>
vmap <Leader>s :call SwoopSelection()<CR>
nmap <Leader>ms :call SwoopMulti()<CR>
vmap <Leader>ms :call SwoopMultiSelection()<CR>

"""""""""""""""""""""""""""""""todo-lists
let g:VimTodoListsMoveItems = 0
let g:VimTodoListsDatesEnabled = 0
