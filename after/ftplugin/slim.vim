"
" This ftplugin requires vim-slim.
" https://github.com/slim-template/vim-slim
"

if exists('b:did_ftplugin_doorboy_slim')
  finish
endif
let b:did_ftplugin_doorboy_slim = 1

function! s:put_ruby_quotation(quotation)
  if doorboy#util#current_synIDattr_name() =~? 'ruby'
    return doorboy#mapping#put_quotation(a:quotation)
  endif
  return a:quotation
endfunction

call doorboy#add_quotations('slim', ['|', '/'])
" Override key mappings defined by calling doorboy#add_quotations
inoremap <buffer> <expr> \| <SID>put_ruby_quotation('\|')
inoremap <buffer> <expr> / <SID>put_ruby_quotation('/')
