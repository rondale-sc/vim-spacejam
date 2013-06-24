" spacejam.vim - Smart whitespace trimming
" Author: Jonathan Jackson
" Version: 1.0

if exists("g:loaded_spacejam") || &cp
  finish
endif
let g:loaded_spacejam = 1

if !exists('g:spacejam_filetypes')
  let g:spacejam_filetypes = 'ruby,javascript,vim,perl'
endif

command! -range=% Trim <line1>,<line2>call s:Trim()

if has("autocmd")
  augroup spacejam
    let g:spacejam_autocmd = "autocmd FileType " . g:spacejam_filetypes . " :autocmd! BufWritePre <buffer> call AutoTrim()"

    exec g:spacejam_autocmd
  augroup END
endif

function! AutoTrim()
  call s:Trim()
endfunction

" Strip Trailing Whitespace Function (credit vimcasts)
function! s:Trim() range
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Do the business:
  %s/\s\+$//e

  " Clean up restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
