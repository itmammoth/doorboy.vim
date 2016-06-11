if exists('b:did_ftplugin_doorboy_perl')
  finish
endif
let b:did_ftplugin_doorboy_perl = 1

call doorboy#add_quotations('perl', ['/'])
