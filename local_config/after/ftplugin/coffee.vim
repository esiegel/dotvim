setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

if executable('coffeetags')
     let g:tagbar_type_coffee = {
             \ 'ctagsbin' : 'coffeetags',
             \ 'ctagsargs' : '',
             \ 'kinds' : [
             \ 'f:functions',
             \ 'o:object',
             \ ],
             \ 'sro' : ".",
             \ 'kind2scope' : {
             \ 'f' : 'object',
             \ 'o' : 'object',
             \ }
             \ }
endif
