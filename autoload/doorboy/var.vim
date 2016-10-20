" vim: set iskeyword-=#:

let s:QUOTATIONS = {}
let s:DEFAULT_QUOTATIONS = {
      \ '*': ['"', "'", '`'],
      \ 'eruby': ['|', '/'],
      \ 'javascript': ['/'],
      \ 'perl': ['/'],
      \ 'ruby': ['|', '/'],
      \ 'slim': ['|', '/']
      \ }

let s:BASE_BRACKETS = ['()', '{}', '[]']
let s:ADDITIONAL_BRACKETS = {}

let s:FALSE = 0
let s:TRUE = !s:FALSE

function! doorboy#var#get_quotations(filetype)
  let ft_key = s:get_ft_key(a:filetype)
  if has_key(s:QUOTATIONS, ft_key)
    return s:QUOTATIONS[ft_key]
  endif

  let quotations = copy(s:DEFAULT_QUOTATIONS['*'])
  call extend(quotations, get(s:DEFAULT_QUOTATIONS, a:filetype, []))

  if exists('g:doorboy_additional_quotations')
    call extend(quotations, get(g:doorboy_additional_quotations, '*', []))
    call extend(quotations, get(g:doorboy_additional_quotations, a:filetype, []))
  endif

  let nomap_quotations = []
  if exists('g:doorboy_nomap_quotations')
    call extend(nomap_quotations, get(g:doorboy_nomap_quotations, '*', []))
    call extend(nomap_quotations, get(g:doorboy_nomap_quotations, a:filetype, []))
  endif
  for q in nomap_quotations
    let i = index(quotations, q)
    if i > -1
      call remove(quotations, i)
    endif
  endfor

  let quotations = s:uniq(quotations)
  let s:QUOTATIONS[ft_key] = quotations
  return quotations
endfunction

function! doorboy#var#get_base_brackets()
  return s:BASE_BRACKETS
endfunction

function! doorboy#var#get_brackets(filetype)
  return s:BASE_BRACKETS + get(s:ADDITIONAL_BRACKETS, a:filetype, [])
endfunction

function! doorboy#var#get_closing_bracktes(filetype)
  return map(deepcopy(doorboy#var#get_brackets(a:filetype)), 'v:val[1]')
endfunction


function! s:get_ft_key(filetype)
  return a:filetype == '' ? '*' : a:filetype
endfunction

function! s:uniq(list)
  let hash = {}
  for v in a:list
    let hash[v] = 1
  endfor
  return keys(hash)
endfunction
