setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

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
