let s:QUOTATIONS = doorboy#var#get_quotations()
let s:BRACKETS = doorboy#var#get_brackets()

"""""""""" Autoload functions

function! doorboy#initialize()
  for quotation in s:QUOTATIONS
    call s:define_quotation_map(quotation)
  endfor

  for a_pair_of_brackets in s:BRACKETS
    call s:define_bracket_map(a_pair_of_brackets)
  endfor

  call s:imap_unless_taken('<BS>', 'doorboy#map_backspace()')
  call s:imap_unless_taken('<SPACE>', 'doorboy#map_space()')
endfunction

function! doorboy#map_backspace()
  return doorboy#mapping#backspace()
endfunction

function! doorboy#map_space()
  return doorboy#mapping#space()
endfunction

function! doorboy#add_quotation(quotation)
  call doorboy#var#add_quotation(a:quotation)
  call s:define_quotation_map(a:quotation)
endfunction

function! doorboy#disable_quotation(quotation)
  let i = index(s:QUOTATIONS, a:quotation)
  if i == -1
    call s:show_error('Not found such a quotation ' . a:quotation)
    return
  endif
  call remove(s:QUOTATIONS, i)
  execute 'iunmap' s:to_map_key(a:quotation)
endfunction

"""""""""" Script local functions

function! s:define_quotation_map(quotation)
  if len(a:quotation) != 1
    call s:show_error('Unacceptable quotation ' . a:quotation)
    call s:show_error('A quotation must consist of 1 character')
    return
  endif
  execute 'inoremap' '<expr>' s:to_map_key(a:quotation)
        \ 'doorboy#mapping#put_quotation("' . s:to_param(a:quotation) . '")'
endfunction

function! s:define_bracket_map(a_pair_of_brackets)
  if len(a:a_pair_of_brackets) != 2
    call s:show_error('Unacceptable bracket ' . a:a_pair_of_brackets)
    call s:show_error('A pair of brackets must consist of 2 characters')
    continue
  endif
  let op = a:a_pair_of_brackets[0]
  let cl = a:a_pair_of_brackets[1]
  execute 'inoremap' '<expr>' s:to_map_key(op)
        \ 'doorboy#mapping#put_opening_bracket("' . s:to_param(op) . '","' . s:to_param(cl) . '")'
  execute 'inoremap' '<expr>' s:to_map_key(cl)
        \ 'doorboy#mapping#put_closing_bracket("' . s:to_param(cl) . '")'
endfunction

function! s:to_map_key(char)
  return escape(a:char, '|')
endfunction

function! s:to_param(char)
  return escape(s:to_map_key(a:char), '"')
endfunction

function! s:imap_unless_taken(key, funcname)
  if !hasmapto(a:key, 'i')
    execute 'inoremap' '<expr>' a:key a:funcname
  endif
endfunction

function! s:show_error(message)
  echohl ErrorMsg | echo '[doorboy] ' . a:message | echohl None
endfunction
