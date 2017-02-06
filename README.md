Typescript source for asyncomplete.vim via tscompletejob
========================================================

Provide [TypeScript](https://www.typescriptlang.org/) autocompletion source for [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim)
via [tscompletejob](https://github.com/runoshun/tscompletejob). Internally tscompletejob uses [tsserver](https://github.com/Microsoft/TypeScript/wiki/Standalone-Server-(tsserver))

### Installing

```vim
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'runoshun/tscompletejob'
if !has('nvim')
    Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'
endif
```

Neovim not supported yet since asyncomplete-tscompletejob depends on `lambda` which is not available yet in Neovim even though tscompletejob works on Vim8+ and Neovim.

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
