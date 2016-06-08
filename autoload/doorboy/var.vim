let s:BASE_QUOTATIONS = ['"', "'", "`"]
let s:BASE_BRACKETS = ['()', '{}', '[]']

let s:ADDITIONAL_QUOTATIONS = {}
let s:ADDITIONAL_BRACKETS = {}

let s:FALSE = 0
let s:TRUE = !s:FALSE

function! doorboy#var#get_base_quotations()
  return s:BASE_QUOTATIONS
endfunction

function! doorboy#var#get_base_brackets()
  return s:BASE_BRACKETS
endfunction

"
" Add additional quotation in the specific filetype.
" Ex)
" call doorboy#var#add_additional_quotation('ruby', '|')
"
function! doorboy#var#add_additional_quotation(filetype, quotation)
  call s:add_additional(s:ADDITIONAL_QUOTATIONS, a:filetype, a:quotation)
endfunction

"
" Add additional brackets in the specific filetype.
" Ex)
" call doorboy#var#add_additional_brackets('xml', '<>')
"
function! doorboy#var#add_additional_brackets(filetype, a_pair_of_brackets)
  call s:add_additional(s:ADDITIONAL_BRACKETS, a:filetype, a:a_pair_of_brackets)
endfunction

function! doorboy#var#get_additional_brackets(filetype)
  return get(s:ADDITIONAL_BRACKETS, a:filetype, [])
endfunction

function! doorboy#var#get_quotations(filetype)
  return s:BASE_QUOTATIONS + get(s:ADDITIONAL_QUOTATIONS, a:filetype, [])
endfunction

function! doorboy#var#get_brackets(filetype)
  return s:BASE_BRACKETS + get(s:ADDITIONAL_BRACKETS, a:filetype, [])
endfunction

function! doorboy#var#get_closing_bracktes(filetype)
  return map(deepcopy(doorboy#var#get_brackets(a:filetype)), 'v:val[1]')
endfunction


function! s:add_additional(dict, filetype, value)
  let values = get(a:dict, a:filetype, [])
  if index(values, a:value) > -1
    return
  endif
  let a:dict[a:filetype] = values + [a:value]
endfunction
