Typescript source for asyncomplete.vim via tscompletejob
========================================================

Provide [TypeScript](https://www.typescriptlang.org/) autocompletion source for [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim)
via [tscompletejob](https://github.com/runoshun/tscompletejob). Internally tscompletejob uses [tsserver](https://github.com/Microsoft/TypeScript/wiki/Standalone-Server-(tsserver))

### Installing

```vim
Plug 'prabirshrestha/asyncomplete.vim'
if !has('nvim')
    Plug 'runoshun/tscompletejob'
    Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'
endif
```

Vim8 with timers and lambda required since tscompletejob depends on it.
Neovim not supported since it depends on vim8 job apis and lambda which is not available yet in neovim.

#### Registration

```vim
if !has('nvim')
    call asyncomplete#register_source({
      \ 'name': 'tscompletejob',
      \ 'whitelist': ['typescript'],
      \ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
      \ })
endif
```

### Credits
* [https://github.com/runoshun/tscompletejob](https://github.com/runoshun/tscompletejob)
