if exists("g:loaded_doorboy")
  finish
endif
let g:loaded_doorboy = 1

let s:save_cpo = &cpo
set cpo&vim


call doorboy#initialize()


let &cpo = s:save_cpo
unlet s:save_cpo
