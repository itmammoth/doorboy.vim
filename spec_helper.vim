set nocompatible
set backspace=indent,eol,start
filetype plugin indent on
syntax on

function! spec_helper#put_with_cursor(exp)
  let curpos = stridx(a:exp, '|')
  let str = substitute(substitute(a:exp, '|', '', ''), '"', "\"", 'g')
  execute "normal! i" . str
  call setpos('.', [0, 1, curpos + 1, 0])
endfunction

function! spec_helper#insert_chars(keys)
  execute 'normal' 'i' . a:keys
endfunction

function! spec_helper#append_chars(keys)
  execute 'normal' 'a' . a:keys
endfunction

function! spec_helper#insert_bs()
  execute "normal i\<BS>"
endfunction

function! spec_helper#insert_cr()
  execute "normal i\<CR>"
endfunction
