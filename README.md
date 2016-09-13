## Requirements
- Vim with required options:
  - [On Ubuntu 14.04](https://gist.github.com/akolosov/cedaac86b333a4ced95f)
  - [On Ubuntu 12.04](https://gist.github.com/jdewit/9818870)
  - On OS X:
  ```bash
  brew install macvim --with-cscope --with-lua --override-system-vim --HEAD
  brew linkapps macvim
  # --with-cscope --with-lua is for better vimfiler
  # --HEAD is for latest version
  ```

- *Inconsolata for Powerline* font, obtained from [here](https://github.com/powerline/fonts)
- Solarized pallete for terminal, from [here](http://ethanschoonover.com/solarized)
- For *tagbar*: exuberant-ctags
- For *unite*: silversearcher-ag, compiled from [here](https://github.com/ggreer/the_silver_searcher)
- For *jedi-vim*: jedi (Python package)
- For *autoformat*: astyle, jsbeautifier (Python package)
- For *youcompleteme*: cmake
- For *tern_for_vim*: node.js; npm

## Install
```bash
git clone https://github.com/phphong/dotvim ~/.vim
vim
```

Then, in Vim, execute `:PlugInstall`

## Known issues
- sometimes `cl`, `cj`, `ch`, `ck` change 2 chars; `ci"` delete the closing `"`; but `ciw` ok, status bar: `>-` (what?)
- vim signature some times show weird signature
- git gutter airline sometimes not work?
- search history `q/` sometimes show `\s\+$`

## Enhancement ideas

- YCM unicode vietnamese (multibyte problem, YCM supports only single-byte character)
- *unite*: search by register
- *tcomment*: toggle individual lines comment <--> uncomment
- *syntastic*: `lnext` `lprevious` relative to current line
- *syntax*: java custom type, custom identifier highlight
- Open markdown in linux (currently Linux have no app like *Marked 2* on OS X)

## My Vim Cheat Sheet
- https://github.com/phphong/vim-cheat-sheet
