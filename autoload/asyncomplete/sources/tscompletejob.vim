function! asyncomplete#sources#tscompletejob#completor(opt, ctx) abort
    let l:col = a:ctx['col']
    let l:typed = a:ctx['typed']

    let l:kw = matchstr(l:typed, '\v\S+$')
    let l:kwlen = len(l:kw)
    if l:kwlen < 1
        return
    endif

    call tscompletejob#complete_with_handler(0, '', {success, response->s:on_complete(success, response, a:opt, a:ctx)})
endfunction

function! s:on_complete(success, response, opt, ctx) abort
    if !a:success
        return
    endif

    let l:col = a:ctx['col']
    let l:kw = matchstr(a:ctx['typed'], '\w\+$')
    let l:kwlen = len(l:kw)

    call asyncomplete#complete(a:opt['name'], a:ctx, l:col - l:kwlen, a:response)
endfunction
