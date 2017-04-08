" vim: set iskeyword-=#:

let s:FALSE = 0
let s:TRUE = !s:FALSE


function! doorboy#setup()
  call s:reset_mappings()

  for q in doorboy#var#get_quotations(&filetype)
    if s:validate_quotation(q)
      call s:define_quotation_map(q)
    endif
  endfor

  for a_pair_of_brackets in doorboy#var#get_brackets(&filetype)
    call s:define_bracket_map(a_pair_of_brackets)
  endfor

  for key in ['bs', 'space', 'cr']
    call s:define_special_map(key)
  endfor

  call s:call_ft_setup(&filetype)
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
" Map CR on the dooyboy CR function.
" You can call this as mapped function like below
" e.x.)
" inoremap <expr> <CR> doorboy#map_cr()
"
function! doorboy#map_cr()
  return doorboy#mapping#cr()
endfunction


function! s:reset_mappings()
  redir => mappings | silent! imap | redir END
  for m in split(mappings, '\n')
    if stridx(m, 'doorboy_map') > -1
      let char = split(m, '\s\+')[1]
      execute 'iunmap' '<buffer>' s:to_map_key(char)
    endif
  endfor
endfunction

function! s:validate_quotation(quotation)
  if len(a:quotation) != 1
    call s:show_error('Unacceptable quotation ' . a:quotation)
    call s:show_error('A quotation must consist of 1 character')
    return s:FALSE
  endif
  return s:TRUE
endfunction

function! s:define_quotation_map(quotation)
  execute 'inoremap' '<buffer>' '<expr>' s:to_map_key(a:quotation)
        \ '<SID>doorboy_map_quotation("' . s:to_param(a:quotation) . '")'
endfunction

function! s:define_bracket_map(a_pair_of_brackets)
  if len(a:a_pair_of_brackets) != 2
    call s:show_error('Unacceptable bracket ' . a:a_pair_of_brackets)
    call s:show_error('A pair of brackets must consist of 2 characters')
    continue
  endif
  let op = a:a_pair_of_brackets[0]
  let cl = a:a_pair_of_brackets[1]
  execute 'inoremap' '<buffer>' '<expr>' s:to_map_key(op)
        \ '<SID>doorboy_map_opening_bracket("' . s:to_param(op) . '","' . s:to_param(cl) . '")'
  execute 'inoremap' '<buffer>' '<expr>' s:to_map_key(cl)
        \ '<SID>doorboy_map_closing_bracket("' . s:to_param(cl) . '")'
endfunction

function! s:define_special_map(key)
  let plug = '<Plug>doorboy_' . a:key
  let keyexp = '<' . a:key . '>'
  if maparg(keyexp, 'i') == ''
    execute 'imap' '<buffer>' keyexp plug
  endif
  execute 'imap' '<buffer>' '<script>' '<expr>' plug '<SID>doorboy_map_' . a:key . '()'
endfunction

""" <SID>functions must be started with 'doorboy_map_'

function! s:doorboy_map_quotation(quotation)
  return doorboy#mapping#put_quotation(a:quotation)
endfunction

function! s:doorboy_map_opening_bracket(op, cl)
  return doorboy#mapping#put_opening_bracket(a:op, a:cl)
endfunction

function! s:doorboy_map_closing_bracket(cl)
  return doorboy#mapping#put_closing_bracket(a:cl)
endfunction

function! s:doorboy_map_bs()
  return doorboy#mapping#backspace()
endfunction

function! s:doorboy_map_space()
  return doorboy#mapping#space()
endfunction

function! s:doorboy_map_cr()
  return doorboy#mapping#cr()
endfunction

"""

function! s:to_map_key(char)
  return escape(a:char, '|')
endfunction

function! s:to_param(char)
  return escape(s:to_map_key(a:char), '"')
endfunction

function! s:call_ft_setup(filetype)
  "
  " Cannot get autoload function's references like below
  " let Setup = function('doorboy#ft#ruby#setup')
  "
  if a:filetype ==# 'eruby'
    call doorboy#ft#eruby#setup()
  elseif a:filetype ==# 'python'
    call doorboy#ft#python#setup()
  elseif a:filetype ==# 'ruby'
    call doorboy#ft#ruby#setup()
  elseif a:filetype ==# 'slim'
    call doorboy#ft#slim#setup()
  elseif a:filetype ==# 'vim'
    call doorboy#ft#vim#setup()
  endif
endfunction

function! s:show_error(message)
  echohl ErrorMsg | echo '[doorboy] ' . a:message | echohl None
endfunction
