" vim: set iskeyword-=#:

function! doorboy#ft#ruby#setup()
  inoremap <buffer> <expr> # doorboy#ft#ruby#put_interpolation_in_string('#')
endfunction

function! doorboy#ft#ruby#put_interpolation_in_string(char)
  if doorboy#util#in_double_quotation_string()
    return a:char . "{}" . "\<LEFT>"
  endif
  return a:char
endfunction
