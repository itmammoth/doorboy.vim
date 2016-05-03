" TODO: Vim global plugin for correcting typing mistakes
" Last Change: 04-May-2016 22:51.
" Maintainer: itmammoth <itmammoth@gmail.com>
" License:	This file is placed in the public domain.

if exists("g:loaded_doorboy")
  finish
endif
let g:loaded_doorboy = 1

let s:save_cpo = &cpo
set cpo&vim


call doorboy#initialize()


let &cpo = s:save_cpo
unlet s:save_cpo
