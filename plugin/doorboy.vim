"
" doorboy.vim is a vim plugin for auto closing quotations/brackets and more.
" TODO
"
" Version: 0.0.1
" Maintainer: itmammoth <itmammoth@gmail.com>
" License:	This file is placed in the public domain.
"

if exists("g:loaded_doorboy")
  finish
endif
let g:loaded_doorboy = 1

let s:save_cpo = &cpo
set cpo&vim


call doorboy#initialize()


let &cpo = s:save_cpo
unlet s:save_cpo
