scriptencoding utf-8 "because this file has multibyte char. vint linter suggests this

set updatetime=300 "git gutter depends on this option for gutter signs to be quickly updated. coc recommends 300 for diagnostic messages and CursorHold for CocActionAsync('highlight'). For disadvantages see this: https://www.reddit.com/r/vim/comments/8qvjnv/is_updatetime_parameter_good_for_vim/
let g:netrw_dirhistmax=0 "disable .netrwhist file

"auto reload vimrc every save
augroup myvimrchooks
    au!
    "nested will be needed in git gutter color, airline color, PlugInstall after writing to vimrc
    autocmd bufwritepost $MYVIMRC source $MYVIMRC
    " autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

":PlugStatus to see which plugin is loaded
call plug#begin()
Plug 'tomtom/tcomment_vim' "gcc / gc + motion. Vim-commentary does not comment blank lines.

call plug#end()
