let s:QUOTATIONS = doorboy#var#get_quotations()
let s:BRACKETS = doorboy#var#get_brackets()
let s:CLOSING_BRACKETS = map(deepcopy(s:BRACKETS), 'v:val[1]')

let s:FALSE = 0
let s:TRUE = !s:FALSE

let s:SKIP = "\<RIGHT>"
let s:BACK = "\<LEFT>"
let s:BS = "\<BS>"
let s:DEL = "\<DEL>"
let s:SPACE = " "

"""""""""" Mapped functions

function! doorboy#mapping#put_quotation(quotation)
  let next = s:get_next_char()
  if next ==# a:quotation
    return s:SKIP
  endif
  let prev = s:get_prev_char()
  if s:is_word(prev) || s:is_word(next)
    return a:quotation
  endif
  return a:quotation . a:quotation . s:BACK
endfunction

function! doorboy#mapping#put_opening_bracket(opening_bracket, closing_bracket)
  let next = s:get_next_char()
  if next ==# a:opening_bracket
    return s:SKIP
  endif
  if s:is_present(next) && !s:is_closing_bracket(next)
    return a:opening_bracket
  endif
  return a:opening_bracket . a:closing_bracket . s:BACK
endfunction

function! doorboy#mapping#put_closing_bracket(closing_bracket)
  if s:get_next_char() ==# a:closing_bracket
    return s:SKIP
  endif
  return a:closing_bracket
endfunction

function! doorboy#mapping#backspace()
  if         s:is_between_quoations()
        \ || s:is_between_brackets()
        \ || s:is_between_brackets_with_spacing()
    return s:BS . s:DEL
  endif
  return s:BS
endfunction

function! doorboy#mapping#space()
  if s:is_between_brackets()
    return s:SPACE . s:SPACE . s:BACK
  endif
  return s:SPACE
endfunction

"""""""""" Script local functions

function! s:get_prev_char()
  return getline('.')[col('.') - 2]
endfunction

function! s:get_next_char()
  return getline('.')[col('.') - 1]
endfunction

function! s:get_prev_and_next_chars()
  return s:get_prev_char() . s:get_next_char()
endfunction

function! s:get_before_prev_and_after_next_chars()
  return getline('.')[col('.') - 3] . getline('.')[col('.')]
endfunction

function! s:is_present(char)
  return len(a:char) > 0 && a:char !=# s:SPACE
endfunction

function! s:is_closing_bracket(char)
  return index(s:CLOSING_BRACKETS, a:char) > -1
endfunction

function! s:is_word(char)
  return a:char =~ '\w'
endfunction

function! s:is_between_quoations()
  let prev = s:get_prev_char()
  if !s:is_quotation(prev)
    return s:FALSE
  endif
  return s:get_next_char() ==# prev
endfunction

function! s:is_quotation(char)
  return index(s:QUOTATIONS, a:char) > -1
endfunction

function! s:is_between_brackets()
  return index(s:BRACKETS, s:get_prev_and_next_chars()) > -1
endfunction

function! s:is_between_brackets_with_spacing()
  let prev = s:get_prev_char()
  let next = s:get_next_char()
  if prev ==# s:SPACE && next ==# s:SPACE
    return index(s:BRACKETS, s:get_before_prev_and_after_next_chars()) > -1
  endif
  return s:FALSE
endfunction
