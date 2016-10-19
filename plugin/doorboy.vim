if exists("g:loaded_doorboy")
  finish
endif
let g:loaded_doorboy = 1

let s:save_cpo = &cpo
set cpo&vim


call doorboy#setup()
augroup doorboy_setup
  autocmd!
  "TODO: not work in unnamed buffer
  autocmd FileType,BufNewFile * call doorboy#setup()
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo
