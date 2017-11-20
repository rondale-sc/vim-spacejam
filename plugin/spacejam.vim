" spacejam.vim - Smart whitespace trimming
" Author: Jonathan Jackson
" Version: 1.0

if exists('g:loaded_spacejam') || &cp
  finish
endif
let g:loaded_spacejam = 1

if !exists('g:spacejam_filetypes')
  let g:spacejam_filetypes = 'ruby,javascript,vim,perl,sass,scss,css,coffee,haml,elixir,eelixir,python'
endif

command! -range=% Trim <line1>,<line2>call s:Trim()

if has('autocmd')
  augroup spacejam
    if !exists('g:spacejam_autocmd')
      let g:spacejam_autocmd = 'autocmd FileType ' . g:spacejam_filetypes . ' :autocmd! BufWritePre <buffer> call s:AutoTrim()'
    endif

    exec g:spacejam_autocmd
  augroup END
endif

function! s:Trim() range
  let _s=@/
  let l = line('.')
  let c = col('.')

  for lineno in range(a:firstline, a:lastline)
    let line = getline(lineno)
    let cleanLine = substitute(line, '\(\s\| \)\+$', '', 'e')
    call setline(lineno, cleanLine)
  endfor

  let @/=_s
  call cursor(l, c)
endfunction

function! s:AutoTrim()
  let _s=@/
  let l = line('.')
  let c = col('.')

  %s/\s\+$//e

  let @/=_s
  call cursor(l, c)
endfunction
