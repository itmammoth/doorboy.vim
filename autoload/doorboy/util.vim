" vim: set iskeyword-=#:

let s:FALSE = 0
let s:TRUE = !s:FALSE

let s:SPACE = " "


function! doorboy#util#get_next_char()
  return getline('.')[s:next_char_index()]
endfunction

function! doorboy#util#get_left_str()
  return strpart(getline('.'), 0, s:next_char_index())
endfunction

function! doorboy#util#get_right_str()
  return getline('.')[ s:next_char_index() : -1 ]
endfunction

function! doorboy#util#is_between_quoations()
  let prev_char = s:get_prev_char()
  if !doorboy#var#is_quotation(&filetype, prev_char)
    return s:FALSE
  endif
  return doorboy#util#get_next_char() ==# prev_char
endfunction

function! doorboy#util#is_between_brackets()
  return index(doorboy#var#get_brackets(&filetype), s:get_prev_and_next_chars()) > -1
endfunction

function! doorboy#util#is_between_brackets_with_spacing()
  if s:get_prev_char() ==# s:SPACE && doorboy#util#get_next_char() ==# s:SPACE
    return index(doorboy#var#get_brackets(&filetype), s:get_before_prev_and_after_next_chars()) > -1
  endif
  return s:FALSE
endfunction

function! doorboy#util#current_synIDattr_name()
  return synIDattr(synID(line('.'), s:next_char_index(), 0), 'name')
endfunction

function! doorboy#util#in_regular_expression()
  return doorboy#util#current_synIDattr_name() =~? 'regexp'
endfunction

function! doorboy#util#in_double_quotation_string()
  if doorboy#util#current_synIDattr_name() !~? 'string'
    return s:FALSE
  endif
  let left_str = doorboy#util#get_left_str()
  let double_quotation_count = count(matchlist(left_str, '\("\)'), '"') - 1
  if double_quotation_count > 0 && fmod(double_quotation_count, 2) == 1
    return s:TRUE
  endif
  return s:FALSE
endfunction


function! s:prev_char_index()
  return col('.') - 2
endfunction

function! s:next_char_index()
  return col('.') - 1
endfunction

function! s:get_prev_char()
  return getline('.')[s:prev_char_index()]
endfunction

function! s:get_prev_and_next_chars()
  return s:get_prev_char() . doorboy#util#get_next_char()
endfunction

function! s:get_before_prev_and_after_next_chars()
  return getline('.')[s:prev_char_index() - 1] . getline('.')[s:next_char_index() + 1]
endfunction
