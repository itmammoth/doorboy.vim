" vim: set iskeyword-=#:

let s:FALSE = 0
let s:TRUE = !s:FALSE

function! doorboy#setup()
  call s:reset()

  for q in doorboy#var#get_quotations(&filetype)
    if s:validate_quotation(q)
      call s:define_quotation_map(q)
    endif
  endfor

  for a_pair_of_brackets in doorboy#var#get_brackets(&filetype)
    call s:define_bracket_map(a_pair_of_brackets)
  endfor

  call s:imap_unless_taken('<BS>', 'doorboy#map_backspace()')
  call s:imap_unless_taken('<SPACE>', 'doorboy#map_space()')

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

"""""""""" Script local functions

function! s:reset()
  redir => mappings | silent! imap | redir END
  for m in split(mappings, '\n')
    if stridx(m, '@doorboy') > -1
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
        \ 'doorboy#mapping#put_quotation("' . s:to_param(a:quotation) . '")'
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
        \ 'doorboy#mapping#put_opening_bracket("' . s:to_param(op) . '","' . s:to_param(cl) . '")'
  execute 'inoremap' '<buffer>' '<expr>' s:to_map_key(cl)
        \ 'doorboy#mapping#put_closing_bracket("' . s:to_param(cl) . '")'
endfunction

function! s:to_map_key(char)
  return escape(a:char, '|')
endfunction

function! s:to_param(char)
  return escape(s:to_map_key(a:char), '"')
endfunction

function! s:imap_unless_taken(key, funcname)
  if maparg(a:key, 'i') ==# ''
    execute 'inoremap' '<buffer>' '<expr>' a:key a:funcname
  endif
endfunction

function! s:call_ft_setup(filetype)
  "
  " cannot get autoload function's references like below
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
