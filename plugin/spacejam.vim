" spacejam.vim - Smart whitespace trimming
" Author: Jonathan Jackson
" Version: 1.0

if exists("g:loaded_spacejam") || &cp
  finish
endif
let g:loaded_spacejam = 1

command! -range=% Trim <line1>,<line2>call s:Trim()

if has("autocmd")
  augroup spacejam
    autocmd BufWritePre .vimrc,*.rb,*.py,*.js call AutoTrim()
  augroup END
endif

function! AutoTrim()
  :1,$call s:Trim()
endfunction

" Strip Trailing Whitespace Function (credit vimcasts)
function! s:Trim() range
  let _s=@/
  let l = line(".")
  let c = col(".")

  for lineno in range(a:firstline, a:lastline)
    " Do the business:
    let line = getline(lineno)
    let cleanLine = substitute(line, '\(\s\| \)\+$', '', 'e')
    call setline(lineno, cleanLine)
  endfor

  " Clean up restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
