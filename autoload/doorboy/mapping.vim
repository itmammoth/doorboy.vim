let s:QUOTATIONS = doorboy#var#QUOTATIONS
let s:BRACKETS = doorboy#var#BRACKETS

let s:FALSE = 0
let s:TRUE = !s:FALSE

let s:SKIP = "\<RIGHT>"
let s:BACK = "\<LEFT>"
let s:BS = "\<BS>"
let s:DEL = "\<DEL>"

function! doorboy#mapping#put_quotation(quotation)
  if s:next_char_equals_to(a:quotation)
    return s:SKIP
  endif
  if s:is_prev_char_word_char() || s:is_next_char_word_char()
    return a:quotation
  endif
  return a:quotation . a:quotation . s:BACK
endfunction

function! doorboy#mapping#put_opening_bracket(a_pair_of_brackets)
  if s:next_char_equals_to(a:a_pair_of_brackets[0])
    return s:SKIP
  endif
  return a:a_pair_of_brackets . s:BACK
endfunction

function! doorboy#mapping#put_closing_bracket(closing_bracket)
  if s:next_char_equals_to(a:closing_bracket)
    return s:SKIP
  endif
  return a:closing_bracket
endfunction

function! doorboy#mapping#backspace()
  if s:is_between_quoations() || s:is_between_brackets()
    return s:BS . s:DEL
  endif
  return s:BS
endfunction

function! s:get_prev_char()
  return getline('.')[col('.')-2]
endfunction

function! s:get_next_char()
  return getline('.')[col('.')-1]
endfunction

function! s:next_char_equals_to(char)
  return s:get_next_char() ==# a:char
endfunction

function! s:is_prev_char_word_char()
  return s:get_prev_char() =~ '\w'
endfunction

function! s:is_next_char_word_char()
  return s:get_next_char() =~ '\w'
endfunction

function! s:is_between_quoations()
  let prev_char = s:get_prev_char()
  if !s:is_quotation(prev_char)
    return s:FALSE
  endif
  return s:next_char_equals_to(s:get_prev_char())
endfunction

function! s:is_quotation(char)
  return index(s:QUOTATIONS, a:char) > -1
endfunction

function! s:is_between_brackets()
  let prev_and_next_chars = s:get_prev_char() . s:get_next_char()
  return index(s:BRACKETS, prev_and_next_chars) > -1
endfunction
