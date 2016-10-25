" vim: set iskeyword-=#:

function! doorboy#ft#python#setup()
  " for string flags like u"multibyte", r"\d\m"
  let b:separator_l_exp = '\v%([\({\[>,\.=/ur]|\s|^)$'
endfunction
