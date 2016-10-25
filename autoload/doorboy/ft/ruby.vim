" vim: set iskeyword-=#:

function! doorboy#ft#ruby#setup()
  if !doorboy#var#is_nomap_quotation('ruby', '#')
    inoremap <buffer> <expr> # doorboy#ft#ruby#put_interpolation_in_string('#')
  endif
endfunction

function! doorboy#ft#ruby#put_interpolation_in_string(char)
  if doorboy#util#in_double_quotation_string()
    return a:char . "{}" . "\<LEFT>"
  endif
  return a:char
endfunction
