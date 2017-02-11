let s:request_id = 0
let s:requests = {}

function! asyncomplete#sources#tscompletejob#completor(opt, ctx) abort
    let l:col = a:ctx['col']
    let l:typed = a:ctx['typed']

    let l:kw = matchstr(l:typed, '\v\S+$')
    let l:kwlen = len(l:kw)
    if l:kwlen < 1
        return
    endif

    let s:request_id = s:request_id + 1
    let s:requests[s:request_id] = { "opt": a:opt, "ctx": a:ctx }
    call tscompletejob#complete_with_handler(0, '', {
                \ "callback" : function('s:on_complete'),
                \ "request_id" : s:request_id,
                \ })
endfunction

function! s:on_complete(request_id, success, response) abort
    if !a:success || !has_key(s:requests, a:request_id)
        return
    endif

    let l:ctx = s:requests[a:request_id].ctx
    let l:opt = s:requests[a:request_id].opt
    unlet s:requests[a:request_id]

    let l:start_col = tscompletejob#complete_with_handler(1, l:ctx['typed'], 0)
    call asyncomplete#complete(l:opt['name'], l:ctx, l:start_col, a:response)
endfunction
