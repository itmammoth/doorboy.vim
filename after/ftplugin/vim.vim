"
" doorboy.vim
" after/ftplugin for vim files
"
if exists('b:did_ftplugin_doorboy_vim')
  finish
endif
let b:did_ftplugin_doorboy_vim = 1

function! s:put_double_quotation()
	if s:is_beginning_of_line()
		return '"'
	endif
	return doorboy#mapping#put_quotation('"')
endfunction

function! s:is_beginning_of_line()
  let right_from_cursor = strpart(getline('.'), 0, col('.')-1)
	return right_from_cursor =~ "^\\s\*$"
endfunction

inoremap <buffer> <expr> " <SID>put_double_quotation()
