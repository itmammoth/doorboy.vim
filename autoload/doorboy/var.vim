let s:QUOTATIONS = ['"', "'", "`"]
let s:BRACKETS = ['()', '{}', '[]']

function! doorboy#var#get_quotations()
  return s:QUOTATIONS
endfunction

function! doorboy#var#get_brackets()
  return s:BRACKETS
endfunction

function! doorboy#var#add_quotation(quotation)
  if index(s:QUOTATIONS, a:quotation) == -1
    call add(s:QUOTATIONS, a:quotation)
  endif
endfunction
