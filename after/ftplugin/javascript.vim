if exists('b:did_ftplugin_doorboy_javascript')
  finish
endif
let b:did_ftplugin_doorboy_javascript = 1

call doorboy#add_quotations('javascript', ['/'])
