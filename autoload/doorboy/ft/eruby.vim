" vim: set iskeyword-=#:

function! doorboy#ft#eruby#setup()
  if doorboy#var#is_quotation('eruby', '|')
    inoremap <buffer> <expr> \| doorboy#ft#eruby#put_ruby_quotation('\|')
  endif
  if doorboy#var#is_quotation('eruby', '/')
    inoremap <buffer> <expr> / doorboy#ft#eruby#put_ruby_quotation('/')
  endif
  if !doorboy#var#is_nomap_quotation('eruby', '#')
    inoremap <buffer> <expr> # doorboy#ft#eruby#put_interpolation_in_string('#')
  endif
endfunction

function! doorboy#ft#eruby#put_ruby_quotation(quotation)
  if doorboy#util#current_synIDattr_name() =~? 'eruby'
    return doorboy#mapping#put_quotation(a:quotation)
  endif
  return a:quotation
endfunction

function! doorboy#ft#eruby#put_interpolation_in_string(char)
  if doorboy#util#current_synIDattr_name() =~? 'rubyString'
    return doorboy#ft#ruby#put_interpolation_in_string(a:char)
  endif
  return a:char
endfunction
