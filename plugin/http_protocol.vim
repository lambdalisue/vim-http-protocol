if exists('g:loaded_http_protocol')
  finish
endif
let g:loaded_http_protocol = 1

augroup http_protocol_plugin
  autocmd!
  autocmd BufReadCmd http://* ++nested call http_protocol#edit()
  autocmd BufReadCmd https://* ++nested call http_protocol#edit()
  autocmd FileReadCmd http://* ++nested call http_protocol#read()
  autocmd FileReadCmd https://* ++nested call http_protocol#read()
augroup END
