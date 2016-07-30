if exists('b:did_ftplugin_doorboy_eruby')
  finish
endif
let b:did_ftplugin_doorboy_eruby = 1

function! s:put_ruby_quotation(quotation)
  if doorboy#util#current_synIDattr_name() =~? 'eruby'
    return doorboy#mapping#put_quotation(a:quotation)
  endif
  return a:quotation
endfunction

call doorboy#add_quotations('eruby', ['|', '/'])
" Override key mappings defined by calling doorboy#add_quotations
inoremap <buffer> <expr> \| <SID>put_ruby_quotation('\|')
inoremap <buffer> <expr> / <SID>put_ruby_quotation('/')
