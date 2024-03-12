function! http_protocol#edit() abort
  if expand('%') !=# expand('<amatch>')
    " Do nothing when the buffer name has changed from <amatch>
    return
  endif
  let l:url = expand('<amatch>')
  let l:content = s:request(l:url)
  setlocal modifiable
  0,$delete _
  call setline(1, l:content)
  setlocal nomodifiable nomodified
  filetype detect
endfunction

function! http_protocol#read() abort
  let l:url = expand('<amatch>')
  let l:content = s:request(l:url)
  call append('.', l:content)
endfunction

function! s:request(url) abort
  let l:cmd = s:build_cmd(a:url)
  if &verbose
    echohl Comment
    echomsg printf('[http-protocol] %s', l:cmd)
    echohl None
  endif
  let l:output = systemlist(l:cmd)
  if v:shell_error != 0
    throw printf('[http-protocol] %s', join(l:output, "\n"))
  endif
  return l:output
endfunction

if executable('curl') && !get(g:, 'http_protocol#disable_curl', 0)
  function! s:build_cmd(url) abort
    return printf('curl -sSfL %s', shellescape(a:url))
  endfunction
elseif executable('wget') && !get(g:, 'http_protocol#disable_wget', 0)
  function! s:build_cmd(url) abort
    return printf('wget -q -O- %s', shellescape(a:url))
  endfunction
elseif executable('pwsh') && !get(g:, 'http_protocol#disable_pwsh', 0)
  function! s:build_cmd(url) abort
    return printf(
          \ "pwsh -Command '&{(Invoke-WebRequest -Uri %s -UseBasicParsing).Content}'",
          \ shellescape(a:url),
          \)
  endfunction
elseif executable('powershell') && !get(g:, 'http_protocol#disable_powershell', 0)
  function! s:build_cmd(url) abort
    return printf(
          \ "powershell -Command '&{(Invoke-WebRequest -Uri %s -UseBasicParsing).Content}'",
          \ shellescape(a:url),
          \)
  endfunction
else
  function! s:build_cmd(_url) abort
    throw '[http-protocol] No available requirement is found'
  endfunction
endif
