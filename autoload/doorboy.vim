let s:QUOTATIONS = doorboy#var#QUOTATIONS
let s:BRACKETS = doorboy#var#BRACKETS

function! doorboy#initialize()
  " Map for quotations
  for char in s:QUOTATIONS
    let escaped_char = escape(char, '"')
    execute 'inoremap' '<expr>' char
          \ 'doorboy#mapping#put_quotation("'.escaped_char.'")'
  endfor

  " Map for brackets
  for a_pair_of_brackets in s:BRACKETS
    if len(a_pair_of_brackets) != 2
      echo 'Found unacceptable bracket ' . a_pair_of_brackets
      echo 'A pair of brackets must consist of 2 characters'
      continue
    endif
    execute 'inoremap' '<expr>' a_pair_of_brackets[0]
          \ 'doorboy#mapping#put_opening_bracket("'.a_pair_of_brackets.'")'
    execute 'inoremap' '<expr>' a_pair_of_brackets[1]
          \ 'doorboy#mapping#put_closing_bracket("'.a_pair_of_brackets[1].'")'
  endfor

  inoremap <expr> <BS> doorboy#mapping#backspace()
  inoremap <expr> <SPACE> doorboy#mapping#space()
endfunction
