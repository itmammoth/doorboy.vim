" vim: set iskeyword-=#:

let s:FALSE = 0
let s:TRUE = !s:FALSE

let s:SKIP = "\<RIGHT>"
let s:BACK = "\<LEFT>"
let s:BS = "\<BS>"
let s:DEL = "\<DEL>"
let s:SPACE = " "
let s:CR = "\<CR>"
let s:UP = "\<UP>"
let s:TAB = "\<TAB>"

"""""""""" Mapped functions

function! doorboy#mapping#put_quotation(quotation)
  if doorboy#util#get_next_char() ==# a:quotation
    return s:SKIP
  endif
  if doorboy#util#in_regular_expression()
    return a:quotation
  endif
  if doorboy#util#get_left_str() !~ s:get_separator_l_exp()
    return a:quotation
  endif
  if doorboy#util#get_right_str() !~ s:get_separator_r_exp()
    return a:quotation
  endif
  return a:quotation . a:quotation . s:BACK
endfunction

function! doorboy#mapping#put_opening_bracket(opening_bracket, closing_bracket)
  let next_char = doorboy#util#get_next_char()
  if next_char ==# a:opening_bracket
    return s:SKIP
  endif
  if s:is_present(next_char) && next_char !~ s:get_separator_r_exp()
    return a:opening_bracket
  endif
  return a:opening_bracket . a:closing_bracket . s:BACK
endfunction

function! doorboy#mapping#put_closing_bracket(closing_bracket)
  if doorboy#util#get_next_char() ==# a:closing_bracket
    return s:SKIP
  endif
  return a:closing_bracket
endfunction

function! doorboy#mapping#backspace()
  if         doorboy#util#is_between_quoations()
        \ || doorboy#util#is_between_brackets()
        \ || doorboy#util#is_between_brackets_with_spacing()
    return s:BS . s:DEL
  endif
  return s:BS
endfunction

function! doorboy#mapping#space()
  if doorboy#util#is_between_brackets()
    return s:SPACE . s:SPACE . s:BACK
  endif
  return s:SPACE
endfunction

function! doorboy#mapping#cr()
  if doorboy#util#is_between_brackets()
    return s:CR . s:CR . s:UP . s:TAB
  endif
  return s:CR
endfunction

function! s:is_present(char)
  return len(a:char) > 0 && a:char !~ '\s'
endfunction

"
" Return word separator regular expression for left of the cursor.
"
" You can override this by defining buffer local variable.
" e.x.)
" " For perl string flags
" let b:separator_l_exp = '\v%([\({\[>,\.=ur]|\s|^)$'
"
function! s:get_separator_l_exp()
  if exists('b:separator_l_exp')
    return b:separator_l_exp
  endif
  return '\v%([\({\[>,\.=/]|\s|^)$'
endfunction

"
" Return word separator regular expression for right of the cursor.
"
function! s:get_separator_r_exp()
  if exists('b:separator_r_exp')
    return b:separator_r_exp
  endif
  return '\v^%([\)}\]>,\.=/]|\s|$)'
endfunction
