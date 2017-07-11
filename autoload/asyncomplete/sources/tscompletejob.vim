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

    if s:status == s:status_unknown
        let s:status = s:status_loading
    endif

    call tscompletejob#complete_with_handler(0, '', function('s:on_complete', [a:opt, a:ctx]))
endfunction

function! s:on_complete(opt, ctx, request_id, success, response) abort
    if !a:success
        let s:status = s:status_unknown
        return
    endif

    let s:status = s:status_loaded

    let l:start_col = tscompletejob#complete_with_handler(1, a:ctx['typed'], 0)
    call asyncomplete#complete(a:opt['name'], a:ctx, l:start_col, a:response)
endfunction
