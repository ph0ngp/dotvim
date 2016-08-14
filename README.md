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

## Vim miscellaneous

#### Vim regex example
**Question:** change all `[XXX]`, `[YYY]` into `"XXX"`, `"YYY"`:
**Solution:** `s/\[\(.\{-}\)\]/"\1"/g`

- `s/match/subsitute/g`: substitute command, replace all matches in a line
- `\[` and `\]`: match square brackets
- `\(` and `\)`: create matched pattern for reuse later
- `\1`: the first matched pattern
- `.\{-}`: shortest match. For longest match use `.*`
- `"\1"`: substitute with the first matched pattern surrounded with quotes

#### Vimscript note
- String list syntax:
  - `-=` removes the value from a string list.
  - `+=` appends the value to a string list.
  - `^=` prepends the value to a string list.
- Never put an inline comment to the right of mapping commands, because the `"` character can be considered to be part of the right hand side of the mapping
- Difference `map` and `noremap`:
```vimscript
map j gg
map Q j
noremap W j
```

`j` will be mapped to `gg`. `Q` will also be mapped to `gg`, because `j` will be expanded for the recursive mapping. `W` will be mapped to `j` (and not to `gg`) because `j` will not be expanded for the non-recursive mapping.

- `<expr>` means the right hand side should be evaluated. Try removing it to see the effect

#### Vim cheatsheet

The mode of *Meaning* column is the `NORMAL` mode if not specified otherwise

Key binding                                       | Meaning
------------------------------------------------- | ---------------------------------------
`,` `;`                                               | repeat the last `f` `F` `t` `T`
`.`                                                 | repeat the last editing command
`-` `Enter`                                           | go to beginning of previous, next line
`C-c`                                               | back to normal mode from insert mode
`q<char>` + commands + `q`             | macro (chains of commands) record
`@<char>` `@@`                   | play the macro specified; replay the last macro
`%`                                                 | go to matching brackets
`$%`                                                | at the beginning of for loop, go to the closing braces (work with Java-style braces)
`b` `e` `w` `ge`                                          | recommended way to move horizontally
`w` `W`                                               | next word, next big word (big word are only separated by white spaces)
`zt` `zz` `zb`                                          | position window such that cursor at top, middle, bottom of screen
`H` `M` `L`                                             | position cursor inside window at head, middle last of screen
`'.`                                                | jump back to last edited line
`` `. ``                                                | jump to the last edited position
`gi`                                                | jump to the last edited position and switch to insert
`g;` `g,`                                             | cycle to the previous / next edited position.
`` `[ `` `` `] ``                                             | beginning/ ending char of changed or yanked text
`'[` `']`                                             | beginning/ ending line of changed or yanked text
``` `` ``` `''`                                             | jump to previous position / line (work after executing a jump)
`R`                                                 | replace text
`^` `_`                                               | go to the first non-whitespace in line (the latter supports count)
`()`                                                | beginning of previous, next sentence (separated by dot)
`{}`                                                | beginning of prev, next paragraph (separated by blank lines)
`vaw` `viw`                                           | select word with (without) trailing spaces
`viwp`                                              | replace word with yanked text
`viw"0p`                                            | replace word with first yanked text
`w` `s` `p` `t`                                           | word, sentence, paragraph, tag
`vib`                                               | select inner block
`viB`  `vi{`                                | select curly block
`<C-a>`  `<C-x>`                                      | increase, decrease number
`<C-x><C-D>`                                        | complete predifined C preprocessor (rarely used)
`zo` `zc`                                             | open close fold
`do` `dp`                                             | `DIFF` take diff from, put diff to other window
`:diffu`                                            | `DIFF` update change inside line
`<<` `>>`| `NORMAL` indent, unindent
`<` `>`  |`VISUAL` indent, unindent
`<C-d>` `<C-t>`  |`INSERT` indent, unindent
`~` `u` `U`                                             | `VISUAL` toggle uppercase - lowercase
`:123` `123G` `123gg`                                   | `COMMAND` `NORMAL` go to line 123
`C-f` `C-b` `C-d` `C-u` `C-e` `C-y`                           | scroll up down
`m<char>` `'<char>` `` `<char> ``                           | set mark, go to beginning of mark line, go to mark
`*` `#` `g*` `g#`                                         | find current word forward/backwards; whole word/not whole word
`:127,215 s/foo/bar`                                | `COMMAND` change the first occurrence of `foo` into `bar` on each line between 127 and 215
`:3,/foo/ ........`                         | `COMMAND` change apply from line 3 to the occurence of `foo`
`23:`                                               | enter line range and enter command mode: from current line to the next 23 lines
`:.,/foo/+1 .......`                              | `COMMAND` change apply from current line to the line after the line containing `foo`
`.` `,` `$`                                             | `COMMAND` represent current and last lines respectively
`:.,$j`                                             | `COMMAND` from the current line to the last line, join them all into one line
`:%`                                                | `COMMAND` same as :1,$ (all the lines)
`:.,+21g/foo/d`                                     | `COMMAND` delete any lines containing the string `foo` from the current one through the next 21 lines"
`:.,$v/bar/d`                                       | `COMMAND` from here to the end of the file, delete any lines which DON'T contain the string 'bar'
`:<linerange>s/foo/bar/g` `:<linerange>s/foo/bar/gc`            | `COMMAND` replace `foo` with `bar` globally/ globally and ask for each occurence
`:<linerange>g/pattern/...` `:<linerange>v/pattern/...` | `COMMAND` apply to lines which match/ not match a pattern
`:...` `d` `p` `m` `j` `s`                                    | `COMMAND` delete, print, move , join, substitute
`:g/re/p`                                           | `COMMAND` globally print lines containing a regular expression (re) (this is grep)
`:% g/foo/m$`                                       | `COMMAND` all the `foo` lines will have been moved to the end of the file. (Note the other tip about using the end of your file as a scratch space). This will have preserved the relative order of all the `foo` lines while having extracted them from the rest of the lis
`:% g/foo/s/bar/zzz/g`                              | `COMMAND` for every line containing `foo` substitute all `bar` with `zzz`
`:'a,'bg/foo/j`                                     | `COMMAND` join any line containing the string foo to its subsequent line, if it lies between the lines between the `a` and `b` marks.
`:r <filename>`                                       | `COMMAND` inserts the contents of the file named `filename` at the current line
`ma` + move to the other end + `` y`a `` or `` d`a ``             | copy or cut an arbitrary selection of text
`"add` `"ap`                                          | cut the line into `a` register and paste from that register
`y/foo`                                             | copy text from here too the next occurence of `foo`
`/\cfoo` `/foo\c`                                  | match `foo`, `Foo,` `fOO`, `FOO`, etc
`/\Cfoo` `/foo\C`                                  | only match `foo`.
`3J`                                                | join the next 3 lines
`d2}`                                               | delete from here to the end of the 2nd paragraph from here
`:! ls ~/Desktop/`                                  | `COMMAND` execute command (list all files on the desktop)
`:! subl %`                                         | `COMMAND` open the current file by sublime text
`1G!Gsort` / `:1,$!sort`                     | `NORMAL` `COMMAND` execute the external sort command on all the lines of this file
`:r! ls ~/Desktop/`                                 | `COMMAND` print the results of this command to the text
`:so ~/.vimrc` `:source ~/.vimrc`          | `COMMAND` execute all lines of this file (called by default at the beginning)
`<C-r>` +                                           | `INSERT` `COMMAND` print those things
                                                  | `a` - `z` the named registers
                                                  | `"` the unnamed register, containing the last delete or yank
                                                  | `0` the yank register
                                                  | `1`-`9` the delete register (>= a line)
                                                  | `-` the small delete register (less than a line)
                                                  | `%` the current file name
                                                  | `#` the alternate file name
                                                  | `*` the clipboard contents (X11: primary selection)
                                                  | `+` the clipboard contents
                                                  | `/` the last search pattern
                                                  | `:` the last command-line
                                                  | `.` the last inserted text
                                                  | `=5*5` insert 25 into text (mini-calculator)
`:%s/foo(/foo(bar,/`                             | `COMMAND` add `bar` parameter to function `foo`
`:normal dd`                                        | `COMMAND` execute the following text as if it was typed in in normal mode, here we delete line
`q:` `:<C-f>` `q/`                           | `NORMAL` `COMMAND` command, search history
`<C-x>/<C-u>` `<C-n>/<C-p>`                         | `NORMAL` `INSERT` completion (not tried yet)
`<C-w>=` + `<count>` + `>` `<` `+` `-`                                   | change window size
`<C-w><C-o>`                                      | make this window the only window
`<C-u>`                                             | `INSERT` delete to beginning of line
`:verbose set tw? wm?`                              | find out where `textwidth` and `wrapmargin` were set last
`C-]`                    | Jump to tags
`C-O` / `C-I` `Tab` | Jump back / forward in the place list
`<C-g>` `g<C-g>`                                      | print current column, line, bytes, %, word count... information
`<S-pageUp/Down>`                                   | move up/down after seeing the output of an external program (e.g. make, fugitive log, etc)
`<count>` + `@:`                                         | `COMMAND` execute last ex command
`gx`                                                | open url
