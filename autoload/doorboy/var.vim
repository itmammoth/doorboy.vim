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

let s:BRACKETS = {}
let s:DEFAULT_BRACKETS = {
      \ '*': ['()', '{}', '[]']
      \ }

let s:FALSE = 0
let s:TRUE = !s:FALSE

function! doorboy#var#get_quotations(filetype)
  let ft_key = s:get_ft_key(a:filetype)
  if has_key(s:QUOTATIONS, ft_key)
    return s:QUOTATIONS[ft_key]
  endif

  let quotations = copy(s:DEFAULT_QUOTATIONS['*'])
  call extend(quotations, get(s:DEFAULT_QUOTATIONS, a:filetype, []))

  call extend(quotations, s:get_additional_quotations(a:filetype))
  call s:remove(quotations, s:get_nomap_quotations(a:filetype))

  let quotations = s:uniq(quotations)
  let s:QUOTATIONS[ft_key] = quotations
  return quotations
endfunction

function! doorboy#var#get_brackets(filetype)
  let ft_key = s:get_ft_key(a:filetype)
  if has_key(s:BRACKETS, ft_key)
    return s:BRACKETS[ft_key]
  endif

  let brackets = copy(s:DEFAULT_BRACKETS['*'])
  call extend(brackets, get(s:DEFAULT_BRACKETS, a:filetype, []))

  call extend(brackets, s:get_additional_brackets(a:filetype))
  call s:remove(brackets, s:get_nomap_brackets(a:filetype))

  let s:BRACKETS[ft_key] = brackets
  return brackets
endfunction

function! doorboy#var#is_quotation(filetype, char)
  return index(doorboy#var#get_quotations(a:filetype), a:char) > -1
endfunction

function! doorboy#var#is_nomap_quotation(filetype, char)
  return index(s:get_nomap_quotations(a:filetype), a:char) > -1
endfunction


function! s:get_additional_quotations(filetype)
  let additional_quotations = []
  if exists('g:doorboy_additional_quotations')
    call extend(additional_quotations, get(g:doorboy_additional_quotations, '*', []))
    call extend(additional_quotations, get(g:doorboy_additional_quotations, a:filetype, []))
  endif
  return additional_quotations
endfunction

function! s:get_nomap_quotations(filetype)
  let nomap_quotations = []
  if exists('g:doorboy_nomap_quotations')
    call extend(nomap_quotations, get(g:doorboy_nomap_quotations, '*', []))
    call extend(nomap_quotations, get(g:doorboy_nomap_quotations, a:filetype, []))
  endif
  return nomap_quotations
endfunction

function! s:get_additional_brackets(filetype)
  let additional_brackets = []
  if exists('g:doorboy_additional_brackets')
    call extend(additional_brackets, get(g:doorboy_additional_brackets, '*', []))
    call extend(additional_brackets, get(g:doorboy_additional_brackets, a:filetype, []))
  endif
  return additional_brackets
endfunction

function! s:get_nomap_brackets(filetype)
  let nomap_brackets = []
  if exists('g:doorboy_nomap_brackets')
    call extend(nomap_brackets, get(g:doorboy_nomap_brackets, '*', []))
    call extend(nomap_brackets, get(g:doorboy_nomap_brackets, a:filetype, []))
  endif
  return nomap_brackets
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

function! s:remove(list, taken_away)
  for v in a:taken_away
    let i = index(a:list, v)
    if i > -1
      call remove(a:list, i)
    endif
  endfor
endfunction
