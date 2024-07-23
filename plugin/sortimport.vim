function! s:SortImport()
    let lines = getline(1,'$')

    let s:startLine = 0
    let s:lastLine = 0

    " 遍历列表
    for i in range(len(lines))
      if match(lines[i],'import \zs[",(]')!=-1
        let lineNum = i+1
        if s:startLine==0
          let s:startLine = lineNum
        endif

        if s:lastLine<lineNum
          let s:lastLine = lineNum
        endif
      endif
    endfor

    let cmd = [
        \ '!sortimport',
        \]
    let cmd = add(cmd, '-only-changed' . ' ' . '-file' . ' ' . expand('%'))
                                                             
    execute s:startLine . ',' . s:lastLine . join(cmd)


endfunction

augroup sortimport
    autocmd!
    autocmd FileType go
        \ command! -bar -nargs=0 -buffer -range=% SortImport call s:SortImport()
augroup end
