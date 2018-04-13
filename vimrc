let mapleader=" "
let maplocalleader=" "
"Y yank from the cursor to the end of line
nnoremap Y y$
"now you can undo <C-U> more intuitively
inoremap <C-U> <C-G>u<C-U>

"toggle vietnamese keyboard
" noremap `` :execute 'set keymap='.(&keymap == '' ? 'vietnamese-telex' : '')<cr>:echo &keymap<cr>

" screen line scroll. But remain default behaviour (linewise) when prefixed with a count
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
vnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

"quickly move through split windows
nnoremap <tab> <c-w>
nnoremap <tab><tab> <c-w><c-w>
nnoremap <C-m> <C-I>

nnoremap <Right> :tabnext<CR>
nnoremap <Left> :tabprevious<CR>

" linewise scroll without prefixed
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

nnoremap 0 ^
nnoremap ^ 0

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" for easier playing macro
nnoremap ] @

" search current visual selection
vnoremap z* "tyq/"tp<cr>N

" delete without cut (delete to the black hole register)
noremap , "_
" paste from the last yank (because we never need the above function with paste)
noremap ,p "0p
noremap ,P "0P
" p or P to the below/ above line
nnoremap <silent> ,j :pu<Bar>execute "'[-1"<CR>
nnoremap <silent> ,k :pu!<Bar>execute "']+1"<CR>
" work with system clipboard
noremap ' "+
if empty($SSH_CLIENT)
    " paste from clipboard in the line below/above
    nnoremap <silent> 'j :pu+<Bar>execute "'[-1"<CR>
    nnoremap <silent> 'k :pu!+<Bar>execute "']+1"<CR>
    " paste from clipboard in the end or beginning of current line
    nnoremap <silent> 'l g_a <ESC>"+p
    nnoremap <silent> 'h I <ESC>"+P
else
    " Source: https://gist.github.com/burke/5960455
    function! PropagatePasteBufferToOSX()
        call system('pbcopy-remote', @")
    endfunction

    function! PopulatePasteBufferFromOSX()
        let @i = system('pbpaste-remote')
    endfunction
    " After copying, call this to transfer to OS X clipboard
    nnoremap <silent> <leader>' :call PropagatePasteBufferToOSX()<cr>

    " paste from OS X clipboard to remote vim
    nnoremap <silent> 'j :call PopulatePasteBufferFromOSX()<Bar>pu i<Bar>execute "'[-1"<CR>
    nnoremap <silent> 'k :call PopulatePasteBufferFromOSX()<Bar>pu! i<Bar>execute "']+1"<CR>
    " paste from clipboard in the end or beginning of current line
    nnoremap <silent> 'l :call PopulatePasteBufferFromOSX()<CR>g_a <ESC>"ip
    nnoremap <silent> 'h :call PopulatePasteBufferFromOSX()<CR>I <ESC>"iP
    nnoremap <silent> 'p :call PopulatePasteBufferFromOSX()<CR>"ip
    nnoremap <silent> 'P :call PopulatePasteBufferFromOSX()<CR>"iP
endif

" insert a space in the end or beginning of current line
nnoremap <silent> ,l g_a <ESC>
nnoremap <silent> ,h I <ESC>

"scroll horizontally
nnoremap <c-h> 20zh
nnoremap <c-l> 20zl

"edit vimrc
nnoremap <silent> <leader>ee :e $MYVIMRC<CR>
nnoremap <silent> <leader>et :tabe $MYVIMRC<CR>
nnoremap <silent> <leader>es :split $MYVIMRC<CR>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>

nnoremap <silent> <leader>d :windo diffthis<CR>

"go to shell
nnoremap <c-s> :sh<CR>

function! s:MapNextFamily(map,cmd)
    let map = '<Plug>unimpaired'.toupper(a:map)
    let cmd = '".(v:count ? v:count : "")."'.a:cmd
    let end = '"<CR>'.(a:cmd == 'l' || a:cmd == 'c' ? 'zv' : '')
    execute 'nnoremap <silent> '.map.'Previous :<C-U>exe "'.cmd.'previous'.end
    execute 'nnoremap <silent> '.map.'Next     :<C-U>exe "'.cmd.'next'.end
    execute 'nnoremap <silent> '.map.'First    :<C-U>exe "'.cmd.'first'.end
    execute 'nnoremap <silent> '.map.'Last     :<C-U>exe "'.cmd.'last'.end
    execute 'nmap <silent> ['.        a:map .' '.map.'Previous'
    execute 'nmap <silent> ]'.        a:map .' '.map.'Next'
    execute 'nmap <silent> ['.toupper(a:map).' '.map.'First'
    execute 'nmap <silent> ]'.toupper(a:map).' '.map.'Last'
    if exists(':'.a:cmd.'nfile')
        execute 'nnoremap <silent> '.map.'PFile :<C-U>exe "'.cmd.'pfile'.end
        execute 'nnoremap <silent> '.map.'NFile :<C-U>exe "'.cmd.'nfile'.end
        execute 'nmap <silent> [<C-'.a:map.'> '.map.'PFile'
        execute 'nmap <silent> ]<C-'.a:map.'> '.map.'NFile'
    endif
endfunction

call s:MapNextFamily('l','l')

" nnoremap gm :<C-U>silent make\|redraw!\|copen<CR><C-w>L
nnoremap gm :<C-U>silent make\|redraw!<CR>
function! CloseWindowOrKillBuffer() "{{{
    let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

    " never bdelete a nerd tree
    if matchstr(expand("%"), 'NERD') == 'NERD'
        wincmd c
        return
    endif

    if number_of_windows_to_this_buffer > 1
        wincmd c
    else
        bdelete
    endif
endfunction
"Q default is Ex-mode, which is not advisable
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>

" use Q in q: q/
augroup ExitCommandWindow
    au!
    au CmdwinEnter * nnoremap <silent> Q :q<CR>
    au CmdwinLeave * nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>
augroup END

nnoremap <C-c> :qa<CR>

" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

" disable highlight until the next search
nnoremap <silent> <BS> :noh<CR>

" C-u to remove line range (we means count, not range). put='something', see h:put . 10 is the linefeed char; v:count is Vim global var, representing the count (the last number before entering command mode). <Bar>execute "something" is equivalent to :something . see h: '[ . -/+1 move cursor up/down 1 line
nnoremap <silent> ]<Space> :<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "'[-1"<CR>
nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "']+1"<CR>

" open help in vertical if width >120
cnoreabbrev <expr> h winwidth(0)>120 && getcmdtype() == ":" && getcmdline() == "h" ? "vert h" : "h"

set guifont=Inconsolata-dz\ for\ Powerline:h12
set fillchars=vert:\│ "continuous vertical split line
" set matchpairs+=<:> 
runtime macros/matchit.vim "enable html tag matching by pressing %
set number relativenumber "show current line number
set laststatus=2 "always show status line
" set ruler "show cursor position and percentage in the file
" set showmatch "briefly jump to the match bracket if it's on the screen
set cursorline "highlight the current line
"disable scrollbar left and right in gui
set guioptions-=L
set guioptions-=r
set sidescroll=1 "disable cursor jumping when horizontal scrolling
set sidescrolloff=15
" set scrolloff=8 "when scrolling vertically, there should always have one more line
set expandtab "use space instead of tabs (because that seems to be the de facto standard)
set autoindent "auto indent the below line same as the above line
set smarttab "a <BS> will delete shiftwidth spaces, (1 space when off)
set tabstop=4 "tab visual length is 4 columns
set shiftwidth=4 "set indent width (when using =) to be equal to tabstop, do not set this =0 as indentation == will not work
"softtabstop: de biet no lam j` thi set no =5 la hieu, nhung ko hieu muc dich, just leave it =0 by default
set visualbell t_vb= "disable beeping and visual bell
set showcmd "show normal mode command; show some information when using visual mode
" set tw=80 "wrap comment lines only, we don't want to wrap inline comment or code line. See formatoptions. Note, if set tw, then set nowrap also for better visually
set wildmenu "show suggestion on command line when pressing tab
set wildmode=longest:full,full "When you type the first tab hit will complete as much as possible, the second tab hit will provide a list and cycle through completion options so you can complete the file without further keys
set wildignorecase "disable case sensitive in wildmenu
set splitright splitbelow "avoid moving code
" set diffopt+=vertical "always open vimdiff in vertically split
" set noequalalways "keep layout after closing a window
set display+=lastline "no discussion
set t_ut= "use vim background color to erase (otherwise in tmux, the background won't work)
set hlsearch
set title "show title (in terminal, like in gui)
set shortmess+=I "don't show intro message
"see special characters: tab, trailing spaces, when nowrap and there is text after, before
set listchars=tab:│\ ,trail:·,extends:❯,precedes:❮,eol:¬
set linebreak breakindent "wrap line in logical place rather than separating words. Start wrapped lines at the same indentation rather than starting from the beginning of the line
" start wrapped line by
let &showbreak='↪ '

filetype plugin indent on "enable filetype-specific settings inside ($VIMRUNTIME/ftplugin/language.vim or .vim/ftplugin/language.vim). But in my case this is the default already (see :filetype)
set nrformats-=octal "otherwise using Ctrl-a on 007 gives 010
set fileformats+=mac "otherwise file using mac format won't be rendered properly (only ^M, no newline)
set backspace=indent,eol,start "allow backspacing everything in insert mode
set ttimeoutlen=0 "eliminate delay when pressing esc in terminal
set timeoutlen=500 "timeout in keymap
set hidden "allow for hiding changed buffer
set autoread "auto load changes from other apps
set formatoptions+=j " Delete comment character when joining commented lines
set cinoptions+=(0 "align parameters when having line break in c code.
set ignorecase "search /\c by default, after / ? * #
set smartcase "if the queries have uppercase letter, use case sensitive search
set ttyfast "make vim scrolls more smoothly, assume fast connection
set ttyscroll=0 "don't know why but this make smooth scroll much better when scroll down (no ghost cursor lines when scrolling down from the last line; no delay cursorline when scrolling down from somewhere in the middle. This will disable scrolling when set mouse=a
set mouse=a "enable using the mouse
set lazyredraw "don't update screen halfway through mapping and macro (increase performance)
set encoding=utf-8 "to see the effect, try setting encoding=latin1 (default)
" set tags=tags;/ "search for tags file from the current directory and upwards until / (; is upwards)
set tags =./tags;/ "search for tags file from the directory containing the current file upwards until / (; is upwards)

let s:cache_dir = '~/.vim/.cache'

function! s:get_cache_dir(suffix, exact_path)
    return resolve(expand(s:cache_dir . '/' . a:suffix)).(a:exact_path?'//':'')
endfunction

" let &backupdir=s:get_cache_dir('backup',0) "backupdir currently does not support // (full path)
" set backup "enable backup
set nobackup

" let &directory=s:get_cache_dir('swap',1) "// means swap file will have full path as swap file name (otherwise, if there are multiple files with the same name opened, swap file name will be .swp, .swn, .swo....)

" set viminfo+=n~/.vim/viminfo "specify the place of viminfo
set viminfo=

" "we can undo even after quit vim and then reopen the same file (security hole)
" if exists("+undofile")
"     let &undodir=s:get_cache_dir('undo',1)
"     set undofile
" endif
set noundofile

"auto reload vimrc every save
augroup myvimrchooks
    au!
    "nested will be needed in git gutter color, airline color, PlugInstall after writing to vimrc
    " only initialize YCM once, otherwise ultisnips won't show in YCM
    autocmd bufwritepost vimrc nested source $MYVIMRC | autocmd! LoadYCMInsertMode
augroup END

augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

function! EnsureExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path))
    endif
endfunction

call EnsureExists(s:cache_dir)
" call EnsureExists(&undodir)
" call EnsureExists(&backupdir)
" call EnsureExists(&directory)

call plug#begin('~/.vim/plugged')
Plug 'tomtom/tcomment_vim' " nerdcommentter have no motion, 'tpope/vim-commentary' don't recognize comment without space. Use gc + motion
" Plug 'mhinz/vim-startify' "helpful start screen
" let g:startify_session_dir = s:get_cache_dir('sessions',0)
" let g:startify_change_to_vcs_root = 1
" Plug 'chriskempson/vim-tomorrow-theme'
Plug 'phphong/vim-colors-solarized'
let &t_Co=256 "assume that this terminal support 256 colors
set background=dark
nnoremap <silent> <F12> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
if $TERM_PROGRAM != "iTerm.app" "including the case of ssh (one must set sshd server to accept Env Variable TERM_PROGRAM)
    let g:solarized_termcolors=256 "use degraded 256 solarized color (but better)
endif
" " set background based on current time
" if strftime("%H") > 5 && strftime("%H") < 19
"     set background=light
" else
"     set background=dark
" endif
Plug 'jszakmeister/vim-togglecursor' "toggle cursor shape in terminal, have some problem with tmux?
let g:togglecursor_leave = "line"
let g:togglecursor_force = "cursorshape" "Assume the terminal is Konsole. In OS X iTerm is used but for some reasons it just works so just leave it here
Plug 'tpope/vim-fugitive' "git interface
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gv :Gvdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gp :Gpush<CR>
Plug 'gregsexton/gitv' "git log viewer
nnoremap <silent> <leader>gl :Gitv!<CR>
let g:Gitv_DoNotMapCtrlKey = 0
Plug 'airblade/vim-rooter'
nnoremap <silent> gr :Rooter<CR>
" let g:rooter_disable_map = 1
let g:rooter_manual_only = 1
let g:rooter_change_directory_for_non_project_files = 1
Plug 'Shougo/vimfiler.vim'
" nnoremap <silent> <F1> :VimFilerCurrentDir -split -simple -winwidth=35 -toggle -no-quit -find<cr>
function! VimfilerFindIfExistOrCloseOtherwise()
    if bufwinnr('vimfiler') > 0
        exe 'VimFilerCurrentDir -split -simple -winwidth=35 -toggle -no-quit'
    else
        exe 'VimFilerCurrentDir -split -simple -winwidth=35 -toggle -no-quit -find'
    endif
endfunction
nnoremap <silent> <F1> :call VimfilerFindIfExistOrCloseOtherwise()<cr>

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon=''
let g:vimfiler_tree_closed_icon='▸'
let g:vimfiler_tree_opened_icon='▾'
let g:vimfiler_data_directory=s:get_cache_dir('vimfiler',0)
let g:vimfiler_expand_jump_to_first_child=0
highlight def link vimfilerOpenedFile Identifier
highlight def link vimfilerClosedFile Identifier
" let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'
augroup Vimfiler_settings
    autocmd!
    autocmd FileType vimfiler nunmap <buffer> <Space>
    autocmd FileType vimfiler vunmap <buffer> <Space>
    autocmd FileType vimfiler nmap <buffer> z <Plug>(vimfiler_toggle_mark_current_line)
    autocmd FileType vimfiler vmap <buffer> z <Plug>(vimfiler_toggle_mark_selected_lines)
    autocmd FileType vimfiler nnoremap <silent> <buffer> <F1> :VimFilerCurrentDir -toggle -no-quit<cr>
augroup END

" Plug 'wesQ3/vim-windowswap' "Window swap: <leader>ww
Plug 'tpope/vim-repeat' "repeat some plugins using dot .
Plug 'tpope/vim-surround' "surround words or selection with '' () {} :cs] ds' ysiw[ (you surround inner word by [])
Plug 'godlygeek/tabular' " :Tabularize /<pattern>
" align the cheat section
" use T mark for Temp
nnoremap <silent> <Leader>ac mTG?CHEAT<CR>VG:Tabularize /<Bar><CR>:noh<CR>'T:delmarks T<CR>
vnoremap <silent> <leader>a: :Tabularize /:<CR>
vnoremap <silent> <leader>a= :Tabularize /=<CR>
vnoremap <silent> <leader>a, :Tabularize /,/l0<CR>
vnoremap <silent> <leader>a<Bar> :Tabularize /<Bar><CR>
Plug 'majutsushi/tagbar' "tag bar (structure of variables, methods...)
nnoremap <F4> :TagbarToggle<CR>
Plug 'Valloric/YouCompleteMe', { 'on': [], 'do': './install.py' }
" load in insert mode start
augroup LoadYCMInsertMode
    autocmd!
    autocmd InsertEnter * call plug#load('YouCompleteMe')
                \| call youcompleteme#Enable() | autocmd! LoadYCMInsertMode
augroup END
" because YCM does not work with Anaconda, we must point it to the default Python
" let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
" ycm complete semantic engine can be used for many languages, including Java
" use python semantic autocomplete from jedi-vim, not YCM because jedi-vim has auto import statement (jedi#smart_auto_mappings)
let g:ycm_filetype_specific_completion_to_disable = {
            \ 'gitcommit': 1,
            \ 'python': 1,
            \}
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1 "display docstring for selected item
" let g:ycm_complete_in_comments = 0
let g:ycm_key_list_select_completion=['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<Up>']
" autocompletion in notes is disabled due to YCM's bug in Unicode chars
let g:ycm_filetype_blacklist={
            \ 'unite': 1,
            \ 'mkd.markdown': 1,
            \ 'text': 1,
            \ } "don't autocomplete in unite buffer
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1 "ctags command for ycm to use: ctags -R --fields=+l .

Plug 'SirVer/ultisnips' "snippets with YCM
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
augroup blade_settings
    autocmd! FileType blade UltiSnipsAddFiletypes php.html
augroup END

Plug 'phphong/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 "enable display tabline
let g:airline#extensions#tabline#tab_nr_type = 1 "only show tab number, don't show number of split windows
" let g:airline#extensions#tabline#show_tab_nr = 1 "enable show tabs
let g:airline#extensions#tabline#show_buffers = 0 "disable show buffer
" let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2 "only show tab line when there is >=2 tabs
let g:airline#extensions#tabline#show_close_button = 0 "disable showing little X button at the far right
let g:airline#extensions#tabline#show_tab_type = 0 "show whether this is 'tabs' or 'buffers' (because we always use tabs)
let g:airline#extensions#tabline#fnamemod = ':t' "only show filename in tab
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' "show path when tab have same file name
let g:airline#extensions#tagbar#enabled=0 "don't show function name, to save performance
"disable indent and trailing checks
let g:airline#extensions#whitespace#enabled = 0
" let g:airline#extensions#whitespace#checks = [ 'indent'] "airline only check for indentation, not trailing spaces
" let g:airline#extensions#whitespace#mixed_indent_algo = 2 "don't show warning for alignment parameter
" let g:airline_section_z= '%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3v'
" let g:airline_section_z= '%3p%%' "only show percentage, not line/column
set noshowmode "just show mode by airline, no need to show mode below
Plug 'justinmk/vim-sneak' "replace f F t T : using s<char1><char2> and ; , | `` or <C-o> go to first position | s<enter> repeat the last search
"replace 'f', so we no longer need to remember s and z separately (this auto unset s)
hi link SneakPluginTarget Search
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
Plug 'haya14busa/incsearch.vim' "incremental search and highlight
" auto disable highlight after searching (by moving cursor)
let g:incsearch#auto_nohlsearch = 1
" If cursor is in first or last line of window, scroll to middle line.
function! s:MaybeMiddle()
    let l:range=2
    if winline() < 1 + l:range || winline() > winheight(0) - l:range
        normal! zz
    endif
endfunction
map <silent> n  <Plug>(incsearch-nohl-n):call <SID>MaybeMiddle()<CR>
map <silent> N  <Plug>(incsearch-nohl-N):call <SID>MaybeMiddle()<CR>
" add N for disabling moving cursor
map *  <Plug>(incsearch-nohl-*)N
map #  <Plug>(incsearch-nohl-#)N
map g* <Plug>(incsearch-nohl-g*)N
map g# <Plug>(incsearch-nohl-g#)N

let s:center_module = {"name": "Center"}

function! s:center_module.priority(event) abort
    return a:event is# "on_char" ? 999 : 0
endfunction

function! s:center_module.on_leave(cmdline) abort
    if exists("s:center_on_leave_flag")
        unlet s:center_on_leave_flag
        normal! zz
    endif
endfunction

function! s:center_module.on_char_pre(cmdline) abort
    if a:cmdline.is_input("<Over>(center)")
        call a:cmdline.setchar("")
    endif
endfunction

function! s:center_module.on_char(cmdline) abort
    if a:cmdline.is_input("<Over>(center)")
        normal! zz
        let s:center_on_leave_flag = 1
    endif
endfunction

function! s:config_center(...) abort
    return extend(copy({
                \   "modules": [s:center_module],
                \   "keymap": {
                \       "\<Tab>": {
                \           "key": "<Over>(incsearch-next)<Over>(center)",
                \           "noremap": 1
                \       },
                \       "\<S-Tab>": {
                \           "key": "<Over>(incsearch-prev)<Over>(center)",
                \           "noremap": 1
                \       }
                \   },
                \   "is_expr": 0
                \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> / incsearch#go(<SID>config_center({"command": "/"}))
noremap <silent><expr> ? incsearch#go(<SID>config_center({"command": "?"}))
noremap <silent><expr> g/ incsearch#go(<SID>config_center({"command": "/", "is_stay": 1}))
Plug 'terryma/vim-multiple-cursors'
" Plug 'airblade/vim-rooter' "auto cd to project directory when switch to buffer
" let g:rooter_silent_chdir = 1 "make rooter not echo pwd change
" let g:rooter_change_directory_for_non_project_files = 1
Plug 'airblade/vim-gitgutter' "jump between hunks: [] c; stage:<leader>hs; revert <leader>hr; prevew <leader>hp
set updatetime=100 "git gutter depends on this option
let g:gitgutter_max_signs = 1000 "default 500, not work well with large files
nmap [c <Plug>GitGutterPrevHunkzz
nmap ]c <Plug>GitGutterNextHunkzz
Plug 'terryma/vim-smooth-scroll'
nnoremap <silent> <c-p> :call smooth_scroll#up(&scroll/2   ,20 ,1)<CR>
nnoremap <silent> <c-g> :call smooth_scroll#down(&scroll/2 ,20 ,1)<CR>
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll     ,20 ,2)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll   ,20 ,2)<CR>
nnoremap <silent> <c-b> :call smooth_scroll#up(&scroll*2   ,20 ,2)<CR>
nnoremap <silent> <c-f> :call smooth_scroll#down(&scroll*2 ,20 ,2)<CR>
Plug 'terryma/vim-expand-region' "press +, _ to expand, shrink
Plug 'sjl/gundo.vim' "undo tree
nnoremap <F5> :GundoToggle<CR>
let g:gundo_right = 1
" Plug 'rking/ag.vim' "search in current directory
" Plug 'ap/vim-css-color' "css color highlight
Plug 'chrisbra/Colorizer' "highlight color
let g:colorizer_auto_filetype='css,html,javascript'
" "Plug 'lilydjwg/colorizer'
" Plug 'justinmk/vim-syntax-extra' "highlight pointer, brackets...

Plug 'LaTeX-Box-Team/LaTeX-Box'
let g:LatexBox_latexmk_preview_continuously=1 "run compilations every time we save the latex file. We should use Skim (with auto detect changes enabled) to preview changes every time the file is saved
let g:LatexBox_quickfix=2
if has("gui_running")
    let g:LatexBox_latexmk_async=1 "to auto open quickfix error list, only work when have vimserver (GUI has), which does not work in terminal MacVim
endif
" let g:LatexBox_latexmk_options = "-xelatex -interaction=nonstopmode" "use xelatex instead of pdflatex; do not prompt for user input if there is error
let g:LatexBox_latexmk_options = "-xelatex" "use xelatex instead of pdflatex
" Plug 'lervag/vimtex'
" let g:vimtex_latexmk_options='-xelatex'
let g:tex_flavor="latex" "when first edit a .tex file, use filetype tex instead of plaintex

function! s:latexfiles_settings()
    nnoremap <silent> <leader>lv :LatexView<cr>
    nnoremap <silent> <leader>ll :Latexmk<cr>
    nnoremap <silent> <leader>ls :LatexmkStop<cr>
    " let g:DiffUnit = "Word1" "for diffchar plugins
endfunction

augroup latex_settings
    autocmd! FileType tex call s:latexfiles_settings()
augroup END

Plug 'tpope/vim-eunuch' "remove, rename files
Plug 'Shougo/unite.vim'
let g:unite_data_directory=s:get_cache_dir('unite',0)
" let g:unite_split_rule = 'botright'

if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_recursive_opt=''
    " let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C0'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
endif

" Q and esc to exit unite
function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)

    nmap <buffer> <esc> <plug>(unite_exit)
    nmap <buffer> <C-p> <Plug>(unite_toggle_auto_preview)
    nmap <buffer> <C-j> <Plug>(unite_loop_cursor_down)
    nmap <buffer> <C-k> <Plug>(unite_loop_cursor_up)
    nmap <buffer> <C-z> <Plug>(unite_toggle_mark_current_candidate)
    nnoremap <silent><buffer><expr> <C-s>     unite#do_action('splitswitch')
    nnoremap <silent><buffer><expr> <C-v>     unite#do_action('vsplitswitch')

    imap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <C-p> <Plug>(unite_toggle_auto_preview)
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
    imap <buffer> <C-z> <Plug>(unite_toggle_mark_current_candidate)
    inoremap <silent><buffer><expr> <C-s>     unite#do_action('splitswitch')
    inoremap <silent><buffer><expr> <C-v>     unite#do_action('vsplitswitch')
endfunction

augroup Unite_settings
    autocmd! FileType unite call s:unite_settings()
augroup END

" search file recursively
Plug 'Shougo/vimproc.vim', { 'do': 'make' } "dependency for file_rec/async or file_rec/git
" nnoremap <silent> [f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr>
"file_rec/git use git ls-files: cached means tracked files; others means untracked files; exclude-standard means ignore files in .gitignore
nnoremap <silent> [f :<C-u>Unite -auto-resize -buffer-name=files file_rec/git:--cached:--others:--exclude-standard<CR>
" find files named as current word
nnoremap <silent> <F3> :<C-u>UniteWithCursorWord -auto-resize -buffer-name=files file_rec/git:--cached:--others:--exclude-standard<CR>
" search current buffers
nnoremap <silent> [v :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
" open unite bookmarks
nnoremap <silent> [k :<C-u>Unite -auto-resize -buffer-name=bookmarks bookmark<CR>
" does not include <CR> so that we can choose to bookmark dir or file
nnoremap <silent> [d :<C-u>UniteBookmarkAdd 
" search recent files
" Plug 'Shougo/neomru.vim' "dependency for unite mru
" let g:neomru#file_mru_path = s:get_cache_dir('neomru',0)
" nnoremap <silent> [a :<C-u>Unite -auto-resize -buffer-name=recent file_mru<cr>
" search yank history
" nnoremap <silent> [y :<C-u>Unite -auto-resize -buffer-name=yanks history/yank<cr>
" registers content
nnoremap <silent> [r :<C-u>Unite -auto-resize -buffer-name=registers register<cr>
" search lines in current buffer
nnoremap <silent> [l :<C-u>Unite -auto-resize -auto-preview -buffer-name=line line<cr>
" grep text in current directory
nnoremap <silent> [s :<C-u>Unite -auto-resize -auto-preview -buffer-name=search grep:.<cr>
" find usages of a word
nnoremap <silent> <F2> :<C-u>Unite -auto-resize -auto-preview -buffer-name=search grep:.<cr><C-r><C-w><cr>
vnoremap <silent> <F2> "ty:<C-u>Unite -auto-resize -auto-preview -no-quit -buffer-name=search grep:.<cr><C-r>t<cr>
" search all mappings
nnoremap <silent> [p :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
" reopen last unite buffer
nnoremap <silent> [u :<C-u>UniteResume<CR>
" search messages
nnoremap <silent> [e :<C-u>Unite -auto-resize -buffer-name=messages output:messages<cr>
Plug 'tsukkee/unite-tag'
nnoremap <silent> [t :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>
Plug 'Shougo/unite-outline' "outline, similar to tagbar
nnoremap <silent> [o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
Plug 'Shougo/unite-help' "search help topic
nnoremap <silent> [h :<C-u>Unite -auto-resize -buffer-name=help help<cr>

Plug 'kshenoy/vim-signature' "show marks on sign column, maximum 2 per line
let g:SignatureMap = {
            \ 'Leader'             :  "m",
            \ 'PurgeMarksAtLine'   :  "m-",
            \ 'PurgeMarks'         :  "m<Space>",
            \ 'PlaceNextMark'      :  "", 'ToggleMarkAtLine'   :  "", 'DeleteMark'         :  "", 'PurgeMarkers'       :  "", 'GotoNextLineAlpha'  :  "", 'GotoPrevLineAlpha'  :  "", 'GotoNextSpotAlpha'  :  "", 'GotoPrevSpotAlpha'  :  "", 'GotoNextLineByPos'  :  "", 'GotoPrevLineByPos'  :  "", 'GotoNextSpotByPos'  :  "", 'GotoPrevSpotByPos'  :  "", 'GotoNextMarker'     :  "", 'GotoPrevMarker'     :  "", 'GotoNextMarkerAny'  :  "", 'GotoPrevMarkerAny'  :  "", 'ListLocalMarks'     :  "", 'ListLocalMarkers'   :  ""
            \ }
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'evanmiller/nginx-vim-syntax'
Plug 'klen/python-mode' "currently using: motion, run code (:PymodeRun or <leader>r), python folding, better python syntax
" [[                Jump to previous class or function (normal, visual, operator modes)
" ]]                Jump to next class or function  (normal, visual, operator modes)
" [M                Jump to previous class or method (normal, visual, operator modes)
" ]M                Jump to next class or method (normal, visual, operator modes)
" aC                Select a class. Ex: vaC, daC, yaC, caC (normal, operator modes)
" iC                Select inner class. Ex: viC, diC, yiC, ciC (normal, operator modes)
" aM                Select a function or method. Ex: vaM, daM, yaM, caM (normal, operator modes)
" iM                Select inner function or method. Ex: viM, diM, yiM, ciM (normal, operator modes)
let g:pymode_motion = 1
let g:pymode_folding = 1
" TODO: virtualenv, conda environment?
" :PymodeRun --> can run buffer or selection
let g:pymode_lint_on_write = 0
let g:pymode_rope = 0
let g:pymode_options = 0
let g:pymode_doc = 0 "use doc from jedi vim since that only popup inside a split, not across all splits like pymode
set nofoldenable "don't auto fold a python file when open
" augroup Python_settings
"     "auto open all fold when open a python file
"     autocmd! FileType python let b:delimitMate_quotes = "` '"
" augroup END
Plug 'davidhalter/jedi-vim' "use python documentation from jedivim, not python-mode. Use python semantic autocomplete from jedi, not YCM
" let g:jedi#auto_initialization = 0
" let g:jedi#completions_enabled = 0

let g:jedi#goto_command = "<leader>pd"
let g:jedi#goto_assignments_command = "<leader>pa"
let g:jedi#goto_definitions_command = "<leader>pf"
let g:jedi#usages_command = "<leader>pu"
" rename seems not working
let g:jedi#rename_command = "<leader>pr"
let g:jedi#documentation_command = "K"
" :Pyimport numpy  ---> open module numpy in Vim

" nnoremap <silent> <buffer> <leader>pr :call jedi#rename()<cr>
" set completeopt-=preview
Plug 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_style_warning_symbol = '≈'
" passive means not check automatically when write
let g:syntastic_mode_map = {
            \ "mode": "passive"
            \ }
let g:syntastic_check_on_wq = 0 "don't auto check when write and quit (in active mod)
let g:syntastic_always_populate_loc_list = 1 "for use of lnext and lprevious
let g:syntastic_auto_loc_list = 1 "auto open loc window
let g:syntastic_java_javac_args = "-encoding ISO-8859-1" "allow vietnamese in java
" Plug 'Valloric/vim-operator-highlight' "highlight +-*/;()....
" let g:ophigh_color_gui = "#d700d7"
" let g:ophigh_color = "164"
Plug 'oblitum/rainbow'
Plug 'Raimondi/delimitMate' "auto close brackets
let delimitMate_expand_cr = 1 "{ [cursor] } works intuitively
let delimitMate_excluded_ft = "unite"
augroup delimitMate_settings
    "prevent the double quote auto match in vim filetype
    autocmd! FileType vim let b:delimitMate_quotes = "` '"
augroup END
" Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax' "better javascript syntax
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' } "find usages, go to def, omnicomplet
augroup TernSettings
    autocmd! FileType javascript nnoremap K :TernDoc<CR>
augroup END

Plug 'Chiel92/vim-autoformat' "autoformat container for all file types
noremap <F6> :Autoformat<CR>
"--max-instatement-indent=? --close-templates?
let s:autoformat_astyle_common_options='--style=java --indent-switches --indent-labels --indent-col1-comments --min-conditional-indent=0 --pad-oper --unpad-paren --pad-header --add-brackets --convert-tabs ".(&expandtab ? "--indent=spaces=".&shiftwidth : "--indent=tab")'
let g:formatdef_my_custom_java = '"astyle --mode=java '.s:autoformat_astyle_common_options
let s:autoformat_astyle_c_options='--indent-modifiers --indent-namespaces --indent-preproc-block --indent-preproc-define --align-pointer=type '
let g:formatdef_my_custom_c = '"astyle --mode=c '.s:autoformat_astyle_c_options.s:autoformat_astyle_common_options
let g:formatdef_my_custom_cs= '"astyle --mode=cs --align-method-colon --pad-method-colon=after '.s:autoformat_astyle_c_options.s:autoformat_astyle_common_options

" let s:autoformat_uncrustify='"uncrustify -c ~/.uncrustify"'
" let g:formatdef_my_custom_java=s:autoformat_uncrustify
" let g:formatdef_my_custom_c=s:autoformat_uncrustify
" let g:formatdef_my_custom_cs=s:autoformat_uncrustify

let g:formatters_java = ['my_custom_java']
let g:formatters_cs = ['my_custom_cs']
" note: clangformat only format a selection (range of lines)
let g:formatters_c = ['clangformat', 'my_custom_c']
let g:formatters_cpp = ['clangformat', 'my_custom_c']
Plug 'tmux-plugins/vim-tmux' "tmux syntax; documentation
Plug 'plasticboy/vim-markdown' "depends on tabular
let g:vim_markdown_folding_disabled=1

augroup Markdown_settings
    autocmd! FileType mkd.markdown call s:markdown_settings()
augroup END

function! s:markdown_settings()
    setlocal formatoptions+=ro "auto add - * when start inserting a new line
    setlocal shiftwidth=2 tabstop=2 "for nested list
    if has("unix")
        let s:uname = substitute(system("uname -s"), '\n', '', '')
        if s:uname == "Darwin"
            setlocal makeprg=open\ % "open markdown file by chrome to view
        endif
    endif
endfunction

Plug 'szw/vim-g' "google search from vim
vnoremap gs :Google<CR>
nnoremap gs :Google<CR>
" search exact
vnoremap gd :Google "<CR>
Plug 'tommcdo/vim-exchange' "exchange words, sentences... in vim: cx<motion> cx<motion>; cxx for currentline; X for visual
" Plug 'tpope/vim-dispatch' "compile, run processes
Plug 'nathanalderson/yang.vim' "yang syntax
Plug 'tfnico/vim-gradle' "gradle syntax
" Plug 'vim-scripts/diffchar.vim' "note: latexfiles_settings function, change g:DiffUnit there
Plug 'jwalton512/vim-blade'
Plug 'tomlion/vim-solidity'
call plug#end()

" turn off vim filer safe mode by default
call vimfiler#custom#profile('default', 'context', {
            \   'safe' : 0
            \ })

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
            \ 'start_insert': 1
            \ })
" disable the limit in grepping with unite
call unite#custom#source('grep/git', 'max_candidates', 0)
call unite#custom#source('grep', 'max_candidates', 0)

augroup Rainbow_load
    autocmd! FileType c,cpp,objc,objcpp,java,rust call rainbow#load()
augroup END

colorscheme solarized
"thin vertical split
" hi vertsplit ctermbg=bg guibg=bg
