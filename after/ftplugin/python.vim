if exists('b:did_ftplugin_doorboy_python')
  finish
endif
let b:did_ftplugin_doorboy_python = 1

" for string flags like u"multibyte", r"\d\m"
let b:separator_l_exp = '\v%([\({\[>,\.=ur]|\s|^)$'
