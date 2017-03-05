Typescript source for asyncomplete.vim via tscompletejob
========================================================

Provide [TypeScript](https://www.typescriptlang.org/) autocompletion source for [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim)
via [tscompletejob](https://github.com/runoshun/tscompletejob). Internally tscompletejob uses [tsserver](https://github.com/Microsoft/TypeScript/wiki/Standalone-Server-(tsserver))

### Requirements

asyncomplete-tscompletejob works on Vim8+ and Neovim.

### Installing

```vim
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'runoshun/tscompletejob'
Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'
```

#### Registration

```vim
call asyncomplete#register_source(asyncomplete#sources#tscompletejob#get_source_options({
    \ 'name': 'tscompletejob',
    \ 'whitelist': ['typescript'],
    \ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
    \ }))
```

### Credits
* [https://github.com/runoshun/tscompletejob](https://github.com/runoshun/tscompletejob)
