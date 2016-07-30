if exists('b:did_ftplugin_doorboy_ruby')
  finish
endif
let b:did_ftplugin_doorboy_ruby = 1

function! s:put_interpolation_in_string(char)
  if doorboy#util#in_double_quotation_string()
    return a:char . "{}" . "\<LEFT>"
  endif
  return a:char
endfunction

call doorboy#add_quotations('ruby', ['|', '/'])
inoremap <buffer> <expr> # <SID>put_interpolation_in_string('#')
