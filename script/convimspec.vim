" convert *.vimspec test file(s) to *.vim file

packadd vim-themis
let s:compiler = package#imports('themis#style#vimspec', 'compile_specfile')
let s:error = package#imports('package', 'error')

" convert: 
function! s:convert(file) abort "{{{
    if a:file !~? '\.vimspec'
        return s:error('not a vimspec file: ' . a:file)
    endif
    if !filereadable(a:file)
        return s:error('can not read file: ' . a:file)
    endif
    let l:pTarget = substitute(a:file, '\.vimspec$', '.vim', '')
    if filereadable(l:pTarget)
        return s:error('target file already exists: ' . l:pTarget)
    endif

    echo 'will convert file: ' . a:file
    call s:compiler(a:file, l:pTarget)
endfunction "}}}

function! s:main(...) abort "{{{
    if a:0 < 1
        throw 'usage: convimspec what?'
    endif

    let l:arg = a:1
    if l:arg =~? '\.vimspec'
        return s:convert(l:arg)
    endif

    if isdirectory(l:arg)
        let l:rGlob = l:arg . '/**/*.vimspec'
    else
        let l:rGlob = l:arg
    endif

    let l:lsAll = glob(l:rGlob, 1, 1)
    call filter(l:lsAll, 'v:val =~? "\.vimspec"')
    if empty(l:lsAll)
        return s:error('not find any vimspec file by: ' . l:arg)
    endif

    call map(l:lsAll, 's:convert(v:val)')

    echo 'convert nums: ' . len(l:lsAll)
endfunction "}}}

" run: 
function! s:run(file, ...) abort "{{{
    let l:file = fnamemodify(expand(a:file), ':p')
    let l:Main = package#imports(l:file, 'main')
    if empty(l:Main)
        return -1
    endif
    return call(l:Main, a:000)
endfunction "}}}

command! -nargs=+ -complete=file VimRun call s:run(<f-args>)

" eg. this command can convert all vimspec in test
" VimRun % /home/lymslive/.vim/pack/lymslive/opt/vimllib/test
