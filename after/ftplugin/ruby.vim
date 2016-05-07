"
" doorboy.vim
" after/ftplugin for ruby files
"
if exists('b:did_ftplugin_doorboy_ruby')
  finish
endif
let b:did_ftplugin_doorboy_ruby = 1

call doorboy#add_quotation('|')
