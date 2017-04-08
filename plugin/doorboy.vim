if exists('g:loaded_doorboy')
  finish
endif
let g:loaded_doorboy = 1

let s:save_cpo = &cpo
set cpo&vim


call doorboy#setup()
augroup doorboy_setup
  autocmd!
  autocmd FileType,BufNew,BufNewFile * call doorboy#setup()
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo
