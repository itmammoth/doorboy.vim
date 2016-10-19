set nocompatible
set backspace=indent,eol,start

setlocal runtimepath+=.
setlocal runtimepath+=./after
setlocal runtimepath+=./vim-slim
filetype plugin indent on
syntax on

let g:doorboy_additional_quotations = {
      \ '*': ['@'],
      \ 'test': ['%']
      \ }

" let g:doorboy_additional_brackets = {
"       \ 'html': ['<>']
"       \ }
"
let g:doorboy_nomap_quotations = {
      \ '*': ['`'],
      \ 'test': ['"']
      \ }

" let g:doorboy_nomap_brackets = {
"       \ 'perl': ['[]']
"       \ }
