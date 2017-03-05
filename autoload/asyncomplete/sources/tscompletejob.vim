let s:request_id = 0
let s:requests = {}
let s:status_unknown = 0
let s:status_loading = 1
let s:status_loaded = 2
let s:status = s:status_unknown

function! asyncomplete#sources#tscompletejob#get_source_options(opts)
    return extend(extend({}, a:opts), {
            \ 'refresh_pattern': '\(\k\+$\|\.$\)',
            \ })
endfunction

function! asyncomplete#sources#tscompletejob#completor(opt, ctx) abort
    if s:status == s:status_loading
        return
    endif

    let l:col = a:ctx['col']

    let l:typed = a:ctx['typed']

    let l:kw = matchstr(l:typed, '\v\S+$')
    let l:kwlen = len(l:kw)

    if s:status == s:status_unknown
        let s:status = s:status_loading
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
        let s:status = s:status_unknown
        return
    endif

    let s:status = s:status_loaded

    let l:ctx = s:requests[a:request_id].ctx
    let l:opt = s:requests[a:request_id].opt
    unlet s:requests[a:request_id]

    let l:start_col = tscompletejob#complete_with_handler(1, l:ctx['typed'], 0)
    call asyncomplete#complete(l:opt['name'], l:ctx, l:start_col, a:response)
endfunction
