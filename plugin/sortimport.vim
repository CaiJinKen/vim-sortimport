function! s:SortImport() 
    let cmd = [
        \ '!sortimport',
        \]
    let cmd = add(cmd, '-file' . ' ' . expand('%'))

    execute join(cmd)
endfunction

augroup sortimport
    autocmd!
    autocmd FileType go
        \ command! -bar -nargs=0 -buffer -range=% SortImport call s:SortImport()
augroup end
