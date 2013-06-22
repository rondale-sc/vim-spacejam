" spacejam.vim - Smart whitespace trimming
" Author: Jonathan Jackson
" Version: 1.0

if exists("g:loaded_spacejam") || &cp
  finish
endif
let g:loaded_spacejam = 1

if has("autocmd")
  augroup spacejam
    autocmd BufWritePre .vimrc,*.rb,*.py,*.js call s:Trim()
  augroup END
endif

command! Trim call s:Trim()

function! Trim()
  call s:Trim()
endfunction

" Strip Trailing Whitespace Function (credit vimcasts)
function! s:Trim()
  " Preparation save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
