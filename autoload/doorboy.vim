let s:FALSE = 0
let s:TRUE = !s:FALSE

"
" Initializing process
" - Map base quotations ('"`) and base brackets ((){}[])
" - BS and Space also will be mapped unless they are already taken.
"
function! doorboy#initialize()
  for quotation in doorboy#var#get_base_quotations()
    call s:define_quotation_map(quotation, '')
  endfor

  for a_pair_of_brackets in doorboy#var#get_base_brackets()
    call s:define_bracket_map(a_pair_of_brackets)
  endfor

  call s:imap_unless_taken('<BS>', 'doorboy#map_backspace()')
  call s:imap_unless_taken('<SPACE>', 'doorboy#map_space()')
endfunction

"
" Map Backspace on the dooyboy backspace function.
" You can call this as mapped function like below
" e.x.)
" inoremap <expr> <BS> doorboy#map_backspace()
"
function! doorboy#map_backspace()
  return doorboy#mapping#backspace()
endfunction

"
" Map Space on the dooyboy space function.
" You can call this as mapped function like below
" e.x.)
" inoremap <expr> <Space> doorboy#map_space()
"
function! doorboy#map_space()
  return doorboy#mapping#space()
endfunction

"
" Add special quotations in a particular filetype.
" The given quotations will be mapped as buffer local mappings.
" e.x.)
" call doorboy#add_quotations('perl', ['/'])
"
function! doorboy#add_quotations(filetype, quotations)
  for quotation in a:quotations
    if s:validate_quotation(quotation)
      call doorboy#var#add_additional_quotation(a:filetype, quotation)
      call s:define_quotation_map(quotation, '<buffer>')
    endif
  endfor
endfunction

"""""""""" Script local functions

function! s:validate_quotation(quotation)
  if len(a:quotation) != 1
    call s:show_error('Unacceptable quotation ' . a:quotation)
    call s:show_error('A quotation must consist of 1 character')
    return s:FALSE
  endif
  return s:TRUE
endfunction

function! s:define_quotation_map(quotation, lhs_opt)
  execute 'inoremap' a:lhs_opt '<expr>' s:to_map_key(a:quotation)
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
  if maparg(a:key, 'i') ==# ''
    execute 'inoremap' '<expr>' a:key a:funcname
  endif
endfunction

function! s:show_error(message)
  echohl ErrorMsg | echo '[doorboy] ' . a:message | echohl None
endfunction
