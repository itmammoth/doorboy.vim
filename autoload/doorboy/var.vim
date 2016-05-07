let s:QUOTATIONS = ['"', "'", "`"]
let s:BRACKETS = ['()', '{}', '[]']

function! doorboy#var#get_quotations()
  return s:QUOTATIONS
endfunction

function! doorboy#var#get_brackets()
  return s:BRACKETS
endfunction
