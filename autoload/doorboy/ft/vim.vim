" vim: set iskeyword-=#:

function! doorboy#ft#vim#setup()
  inoremap <buffer> <expr> " doorboy#ft#vim#put_double_quotation()
endfunction

function! doorboy#ft#vim#put_double_quotation()
	if s:is_beginning_of_line()
		return '"'
	endif
	return doorboy#mapping#put_quotation('"')
endfunction

function! s:is_beginning_of_line()
	return doorboy#util#get_left_str() =~ "^\\s\*$"
endfunction
