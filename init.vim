scriptencoding utf-8 "because this file has multibyte char. vint linter suggests this

let mapleader=' '
"let maplocalleader=" "

"Y yank from the cursor to the end of line
nnoremap Y y$

" screen line scroll. But remain default behaviour (linewise) when prefixed with a count and in operator pending mode.
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
vnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" In summary, we only use original gj and gk when moving from single visual line to single visual line. In all other cases (with count, or in operator pending mode), just use original j and k
noremap gj j
noremap gk k

"quickly move through split windows
nnoremap <tab> <c-w>
nnoremap <tab><tab> <c-w><c-w>
"forward position by Ctrl-M or enter
nnoremap <C-m> <C-I>

"quickly move through tabs
nnoremap <Right> gt
nnoremap <Left> gT

" sensible first of line
noremap 0 ^
noremap ^ 0
noremap g0 g^
noremap g^ g0

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" " for easier playing macro
" nnoremap m @

" " search current visual selection
" vnoremap z* "tyq/"tp<cr>N

" delete without cut (delete to the black hole register)
nnoremap \ "_
vnoremap \ "_
" paste from the last yank (because we never need the above function with paste)
nnoremap \p "0p
vnoremap \p "0p
nnoremap \P "0P
vnoremap \P "0P

" make single quote represents system clipboard
nnoremap ' "+
vnoremap ' "+
" paste from clipboard in the line below/above
nnoremap <silent> 'j :pu+<Bar>execute "'[-1"<CR>
nnoremap <silent> 'k :pu!+<Bar>execute "']+1"<CR>
" paste from clipboard in the end or beginning of current line
nnoremap <silent> 'l g_a <ESC>"+p
nnoremap <silent> 'h I <ESC>"+P

"scroll horizontally
nnoremap <c-h> 20zh
nnoremap <c-l> 20zl

"edit vimrc
nnoremap <silent> <leader>ee :e $MYVIMRC<CR>
nnoremap <silent> <leader>et :tabe $MYVIMRC<CR>
nnoremap <silent> <leader>es :split $MYVIMRC<CR>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>

"compare two opened windows, turn off by diffoff
nnoremap <silent> <leader>d :windo diffthis<CR>

" nnoremap gm :<C-U>silent make\|redraw!<CR>

"Q default is Ex-mode, which is not advisable
nnoremap <silent> Q :clo<cr>

" ----------------------------------------------------------------------------
" <Leader>c Close quickfix/location window
" ----------------------------------------------------------------------------

" nnoremap <silent> <leader>c :call LocationListWindowToggle()<CR>
" let g:location_list_window_is_open = 0  
"
" function! LocationListWindowToggle()
"     if g:location_list_window_is_open == 1
"         lclose
"         let g:location_list_window_is_open = 0 
"     else
"         lopen
"         let g:location_list_window_is_open = 1 
"     endif
" endfunction

"nnoremap <C-c> :qa<CR>

" disable highlight until the next search
nnoremap <silent> <BS> :noh<CR>
" search without moving cursor
nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" C-u to remove line range (we means count, not range). put='something', see h:put . 10 is the linefeed char; v:count is Vim global var, representing the count (the last number before entering command mode). <Bar>execute "something" is equivalent to :something . see h: '[ . -/+1 move cursor up/down 1 line
" nnoremap <silent> ]<Space> :<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "'[-1"<CR>
" nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "']+1"<CR>

" open help in vertical if width >120
" must be the same as coc below
cnoreabbrev <expr> h winwidth(0)>120 && getcmdtype() == ":" && getcmdline() == "h" ? "vert h" : "h"

"set guifont=Inconsolata-dz\ for\ Powerline:h12
"set fillchars=vert:\│ "continuous vertical split line
" set matchpairs+=<:>
set number relativenumber "show current line number
set cursorline "highlight the current line
set sidescrolloff=15 "when scrolling horizontally, you can see more
" set scrolloff=8 "when scrolling vertically, there should always have one more line
set expandtab "use space instead of tabs (because that seems to be the de facto standard)
set tabstop=2 "tab visual length is 4 columns
set shiftwidth=2 "set indent width (when using = or when pressing tab) to be equal to tabstop, do not set this =0 as indentation == will not work
set formatoptions-=c "don't wrap comment lines to textwidth
set wildignorecase "disable case sensitive in wildmenu (filename...)
set splitright splitbelow "avoid moving code
" set diffopt+=vertical "always open vimdiff in vertically split
" set noequalalways "keep layout after closing a window
set title "show title (in terminal, like in gui)
"set shortmess+=I "don't show intro message
"in :set list mode: see special characters: tab, trailing spaces, when nowrap and there is text after, before
set listchars=tab:│\ ,trail:·,extends:❯,precedes:❮,eol:¬
set linebreak breakindent "wrap line in logical place rather than separating words. Start wrapped lines at the same indentation rather than starting from the beginning of the line
" start wrapped line by
"let &showbreak='↪ '

"set fileformats+=mac "otherwise file using mac format won't be rendered properly (only ^M, no newline)
"set timeoutlen=500 "timeout in keymap
set cinoptions+=(0 "align parameters when having line break in c code.
set ignorecase "search /\c by default, after / ? * #
set smartcase "if the queries have uppercase letter, use case sensitive search
set termguicolors "enable true RGB colors for colorscheme
set updatetime=300 "git gutter depends on this option for gutter signs to be quickly updated. coc recommends 300 for diagnostic messages and CursorHold for CocActionAsync('highlight'). For disadvantages see this: https://www.reddit.com/r/vim/comments/8qvjnv/is_updatetime_parameter_good_for_vim/
"if this autocommand don't exist then vim only check and reload when we are trying to write to buffer
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
augroup autoreload_when_focused
    au!
    au FocusGained * :checktime
augroup END
" set mouse=a "enable using the mouse
" set lazyredraw "don't update screen halfway through mapping and macro (increase performance)
" set tags =./tags;/ "search for tags file from the directory containing the current file upwards until / (; is upwards)
"
" let s:cache_dir = '~/.local/share/nvim/cache'
"
" function! s:get_cache_dir(suffix, exact_path)
"     return resolve(expand(s:cache_dir . '/' . a:suffix)).(a:exact_path?'//':'')
" endfunction
"
" let &directory=s:get_cache_dir('swap',1) "// means swap file will have full path as swap file name (otherwise, if there are multiple files with the same name opened, swap file name will be .swp, .swn, .swo....)
let &directory='.' " create swap files in the same location as edited files

" normally shada (information from previous nvim sessions) is remembered. When you don't want it to happen, run nvim -i NONE
" set shada="NONE" "disable viminfo forever

" "we can undo even after quit vim and then reopen the same file
" if exists("+undofile")
"     let &undodir=s:get_cache_dir('undo',1)
"     set undofile
" endif
set noundofile
set nobackup
let g:netrw_dirhistmax=0 "disable .netrwhist file

"auto reload vimrc every save
augroup myvimrchooks
    au!
    "nested will be needed in git gutter color, airline color, PlugInstall after writing to vimrc
    autocmd bufwritepost $MYVIMRC source $MYVIMRC
    " autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline().' ' : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'
  return '[%n] %f %<'.ro.mod.sep.ft.fug.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

" function! EnsureExists(path)
"     if !isdirectory(expand(a:path))
"         call mkdir(expand(a:path))
"     endif
" endfunction
"
" call EnsureExists(s:cache_dir)
" " call EnsureExists(&undodir)
" " call EnsureExists(&backupdir)
" " call EnsureExists(&directory)

" dependencies: fd, fzf, rg, bat. jedi for coc-python
" for ale: vint, shellcheck

":PlugStatus to see which plugin is loaded
call plug#begin()
Plug 'tomtom/tcomment_vim' "gcc / gc + motion. Vim-commentary does not comment blank lines.
Plug 'sheerun/vim-polyglot' "better syntax for many languages. Sometimes make big python file slow when inserting new line

Plug 'Yggdroot/indentLine'
let g:indentLine_fileTypeExclude = ['json'] "this plugin makes json file not show quotes
" Plug 'ajmwagar/vim-deus' "ok, no highlight bracket
" Plug 'tomasr/molokai' "ok, a little bright, no highlight au!
" Plug 'lifepillar/vim-solarized8'
" Plug 'nanotech/jellybeans.vim' "highlight everything but not beautiful color
" Plug 'NLKNguyen/papercolor-theme' "support many languages
" Plug 'morhetz/gruvbox' "ok, no highlight bracket
" Plug 'lifepillar/vim-gruvbox8/' "seemingly not as updated as gruvbox-community
" yob in unimpaired for changing background dark - light
Plug 'gruvbox-community/gruvbox' "comminity-updated gruvbox
let g:gruvbox_italic=0
" Plug 'mhartington/oceanic-next' "ok, not differentiate FocusGained and smartcase
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 0
" if $TERM_PROGRAM != "iTerm.app" "including the case of ssh (one must set sshd server to accept Env Variable TERM_PROGRAM)
"     let g:solarized_termcolors=256 "use degraded 256 solarized color (but better)
" endif

" " Peekaboo will show you the contents of the registers on the sidebar when you hit " or @ in normal mode or <CTRL-R> in insert mode. The sidebar is automatically closed on subsequent key strokes.
" " You can toggle fullscreen mode by pressing spacebar.
" Plug 'junegunn/vim-peekaboo'

Plug '/usr/local/opt/fzf' "fzf, installed by Homebrew. brew upgrade fzf to upgrade
" " PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"   " Both options are optional. You don't have to install fzf in ~/.fzf
"   " and you don't have to run the install script if you use fzf only in Vim.
Plug 'junegunn/fzf.vim'

" Floating fzf. From https://github.com/junegunn/dotfiles/blob/master/vimrc
if has('nvim')
  function! s:create_float(hl, opts)
    let buf = nvim_create_buf(v:false, v:true)
    let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
    call setwinvar(win, '&colorcolumn', '')
    return buf
  endfunction

  function! FloatingFZF()
    " Size and position
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)

    " Border
    let top = '╭' . repeat('─', width - 2) . '╮'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '╰' . repeat('─', width - 2) . '╯'
    let border = [top] + repeat([mid], height - 2) + [bot]

    " Draw frame
    let s:frame = s:create_float('Comment', {'row': row, 'col': col, 'width': width, 'height': height})
    call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

    " Draw viewport
    call s:create_float('Normal', {'row': row + 1, 'col': col + 1, 'width': width - 2, 'height': height - 2})
    autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

" Fzf preview files
" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse']}), <bang>0)

" " search for text and use fzf to filter by the line contaning the text + filename
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

" From https://github.com/junegunn/fzf.vim
" search for text and you can change the text to search in fzf window
" column and line-number: have these coordinates for each match. --no-heading means do not group matches in the same file. always output with color. smart-case: search case-insensitive when all lowercase and case-sensitive when there is at least 1 uppercase letter.
function! RipgrepFzf(query, only_current_file, fullscreen)
" CY: must be the same as .zshrc and below. hidden means search also files starting with dot. -g !.git means do not search .git dir.
  let command_fmt = 'rg --hidden  -g !.git --column --line-number --no-heading --color=always --smart-case --with-filename %s ' . (a:only_current_file? fnameescape(expand('%')):'') . ' || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  " used for reloading, {q} means take the text as the query
  let reload_command = printf(command_fmt, '{q}')
  " :h fzf for explaining these options.
  " phony means no fuzzy finder, just selector.
  " --query query means the original query is placed inside the search line right at the start.
  " --bind change:reload: whenever text changes, auto search the changed text all over again.
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--bind', 'ctrl-r:toggle-preview-wrap']}
  " ctrl-p is for toggle preview. hidden: default hidden preview window. Ctrl-r for toggle wrap in preview window
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, 'down:hidden', 'ctrl-p'), a:fullscreen)
endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" search the word/WORD under the cursor in all buffers
nnoremap <silent> <leader>fs :call RipgrepFzf(expand('<cword>'), 0, 0)<cr>
nnoremap <silent> <leader>fw :call RipgrepFzf(expand('<cWORD>'), 0, 0)<cr>
vnoremap <silent> <leader>fs "ty:<C-u> call RipgrepFzf("<C-r>t", 0, 0)<cr>
" start searching something in all buffers
nnoremap <silent> <leader>fk :call RipgrepFzf("", 0, 0)<cr>
" start searching something only in this buffer (like /)
nnoremap <silent> <leader>fl :call RipgrepFzf("", 1, 0)<cr>

" When using gruvbox, in the default theme of Bat (Monokai Extended), it is very difficult to see the highlighted line. see plugged/fzf.vim/bin/preview.sh
" For more info: https://github.com/neovim/neovim/issues/4696#issuecomment-216535968
let $BAT_THEME = 'Monokai Extended Origin' " used for highlighting single line in Rg FZF preview.

" when in nerd_tree, switch to another window and then execute :Files
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
" nnoremap <silent> <leader>fl :BLines<cr>
nnoremap <silent> <leader>fb :Buffers<cr>
nnoremap <silent> <leader>fy :History<cr>
nnoremap <silent> <leader>f; :History:<cr>
nnoremap <silent> <leader>f/ :History/<cr>
nnoremap <silent> <leader>fh :Helptags<cr>
nnoremap <silent> <leader>fc :Commands<cr>

" Show all mappings in current mode
nmap <leader>fm <plug>(fzf-maps-n)
xmap <leader>fm <plug>(fzf-maps-x)
omap <leader>fm <plug>(fzf-maps-o)
imap <c-f><c-m> <plug>(fzf-maps-i)

" this is unnecessary because of coc
" " Insert mode path completion. For example: ~/Desktop/<c-f><c-f>
" " CY: must be the same as .zshrc.
" inoremap <expr> <c-f><c-f> fzf#vim#complete#path('fd --hidden --ignore-file $HOME/.gitignore --exclude .git')

Plug 'tpope/vim-fugitive' "git interface
" press g? to show keymap inside :Gstatus
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiffsplit<CR>
"nnoremap <silent> <leader>gv :Gvdiffsplit<CR>
"nnoremap <silent> <leader>gc :Gcommit<CR>
"nnoremap <silent> <leader>gw :Gwrite<CR>
"nnoremap <silent> <leader>gp :Gpush<CR>

Plug 'airblade/vim-rooter', { 'on': 'Rooter' }
" nnoremap <silent> gr :Rooter<CR>
let g:rooter_manual_only = 1
let g:rooter_change_directory_for_non_project_files = 'current'

" on demand loading: only load this plugin only from when this command is called or when we start vim with a directory instead of a file
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" https://github.com/junegunn/dotfiles/blob/master/vimrc https://github.com/junegunn/vim-plug/issues/424
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END
nnoremap <leader>n :NERDTreeToggle<cr>

" err and warnings will show up in location window :lopen
" Plug 'dense-analysis/ale' "this will override git-gutter in lines having problems
" " let g:ale_linters = {'java': [], 'yaml': [], 'scala': [], 'clojure': []}
" " let g:ale_fixers = {'ruby': ['rubocop']}
" " let g:ale_lint_delay = 1000
" let g:ale_sign_warning = '😟'
" let g:ale_sign_error = '😡'
" "override ]a [a from unimpaired
" nmap ]a <Plug>(ale_next_wrap)
" nmap [a <Plug>(ale_previous_wrap)

Plug 'honza/vim-snippets' "install snippets for coc-snippets

" :CocInstall extension_name
" :CocCommand some_cmd
" :CocList commands/extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" To pick a different color, use command: :call CocAction('pickColor')
" coc-git causes flashing start screen
" coc-rls: To enable formatting on save, open coc-settings.json by :CocConfig, then add "rust" to coc.preferences.formatOnSaveFiletypes field.
" coc-snippets: to move between snippet placeholders, ctrl j and ctrl k
let g:coc_global_extensions = ['coc-highlight', 'coc-git', 'coc-snippets', 'coc-pairs', 'coc-json', 'coc-vimlsp', 'coc-tsserver', 'coc-python']
" autocmd FileType json syntax match Comment +\/\/.\+$+ "supporting comment like // in .json files

"return true if cursor in the first column or the previous character is a whitespace
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" if completion menu is showing, tab to select down. If it's not showing and check_back_space is false, show it. if check_back_space is true, just insert a normal Tab
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <silent><expr> <S-TAB>
            \ pumvisible() ? "\<C-p>" :
            \ <SID>check_back_space() ? "\<S-TAB>" :
            \ coc#refresh()

" moving in select mode - coc snippet
" let g:coc_snippet_next = '<TAB>'
" let g:coc_snippet_prev = '<S-TAB>'

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position. See i_CTRL-G_u
" Coc only does snippet and additional edit on confirm.
" inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" to make coc-pairs works properly (auto insert new line) when pressing enter
" https://github.com/neoclide/coc-pairs/issues/13#issuecomment-478998416
" don't use on_enter when you have performance issue
inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics >>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
" h for header
nmap <silent> gh <Plug>(coc-declaration)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    " if the current filetype is vim or help
    if (index(['vim','help'], &filetype) >= 0)
        " must be the same as cnoreabbrev above
        execute ((winwidth(0)>120)?'vert h':'h'). ' '. expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" rename current word
nmap <leader>cn <Plug>(coc-rename)

" format selected region. xmap is for only visual mode. Can be used with motion e.g. <leader>cfap
xmap <leader>cf <Plug>(coc-format-selected)
nmap <leader>cf <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>caap` for current paragraph
xmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction-selected)

" autofix (sửa) problem of current line
nmap <leader>cs <Plug>(coc-fix-current)

" expand select region
nmap <silent> + <Plug>(coc-range-select)
xmap <silent> + <Plug>(coc-range-select)

" Create motion mappings for function text object, requires document symbols feature of languageserver. (vif, daf)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

augroup my_coc_group
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" ---------------coc-git---------------------
" navigate chunks of current buffer
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap <leader>hp <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <leader>hc <Plug>(coc-git-commit)
nnoremap <leader>hs :CocCommand git.chunkStage<cr>
nnoremap <leader>hu :CocCommand git.chunkUndo<cr>
" Fold unchanged lines of current buffer.
nnoremap <leader>hf :CocCommand git.foldUnchanged<cr>
" Open current line in browser, github url supported.
nnoremap <leader>ho :CocCommand git.browserOpen<cr>
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
" omap ag <Plug>(coc-git-chunk-outer)
" xmap ag <Plug>(coc-git-chunk-outer)
"------------------------------------------

Plug 'jackguo380/vim-lsp-cxx-highlight'

" Adding support to a plugin is generally as simple as the following command at the end of your map functions.
" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
Plug 'tpope/vim-repeat' "repeat some plugins using dot .

"surround words or selection with '' () {} :cs] ds' ysiw[ (you surround inner word by [])
"surround line with yss)
Plug 'tpope/vim-surround'

" read https://github.com/junegunn/vim-easy-align for usage
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga=). ga2= (second =), ga*= (all)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip=)
nmap ga <Plug>(EasyAlign)

Plug 'terryma/vim-multiple-cursors'

Plug 'justinmk/vim-sneak' "replace f F t T : using s<char1><char2> and ; , | `` or <C-o> go to first position | s<enter> repeat the last search
" hi link SneakPluginTarget Search
map f <Plug>Sneak_f
map F <Plug>Sneak_F
" replace 't' with 1-char Sneak
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" only load this plugin since the time this command is called
" press ? for help
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
let g:undotree_WindowLayout = 4
nnoremap U :UndotreeToggle<CR>
" Plug 'chrisbra/Colorizer', { 'on': 'ColorToggle' } " :ColorToggle. Not affect startup time.
" "let g:colorizer_auto_filetype='css,html,javascript'
" Plug 'justinmk/vim-syntax-extra' "highlight pointer, brackets...

"Plug 'LaTeX-Box-Team/LaTeX-Box'
"let g:LatexBox_latexmk_preview_continuously=1 "run compilations every time we save the latex file. We should use Skim (with auto detect changes enabled) to preview changes every time the file is saved
"let g:LatexBox_quickfix=2
"if has("gui_running")
"    let g:LatexBox_latexmk_async=1 "to auto open quickfix error list, only work when have vimserver (GUI has), which does not work in terminal MacVim
"endif
"" let g:LatexBox_latexmk_options = "-xelatex -interaction=nonstopmode" "use xelatex instead of pdflatex; do not prompt for user input if there is error
"let g:LatexBox_latexmk_options = "-xelatex" "use xelatex instead of pdflatex
"" Plug 'lervag/vimtex'
"" let g:vimtex_latexmk_options='-xelatex'
"let g:tex_flavor="latex" "when first edit a .tex file, use filetype tex instead of plaintex
"
"function! s:latexfiles_settings()
"    nnoremap <silent> <leader>lv :LatexView<cr>
"    nnoremap <silent> <leader>ll :Latexmk<cr>
"    nnoremap <silent> <leader>ls :LatexmkStop<cr>
"    " let g:DiffUnit = "Word1" "for diffchar plugins
"endfunction
"
"augroup latex_settings
"    autocmd! FileType tex call s:latexfiles_settings()
"augroup END

Plug 'tpope/vim-eunuch' " :Delete, :Rename :SudoWrite :SudoEdit

"Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'evanmiller/nginx-vim-syntax'

"Plug 'python-mode/python-mode' "currently using: motion, run code (:PymodeRun or <leader>r), python folding, better python syntax
"" [[                Jump to previous class or function (normal, visual, operator modes)
"" ]]                Jump to next class or function  (normal, visual, operator modes)
"" [M                Jump to previous class or method (normal, visual, operator modes)
"" ]M                Jump to next class or method (normal, visual, operator modes)
"" aC                Select a class. Ex: vaC, daC, yaC, caC (normal, operator modes)
"" iC                Select inner class. Ex: viC, diC, yiC, ciC (normal, operator modes)
"" aM                Select a function or method. Ex: vaM, daM, yaM, caM (normal, operator modes)
"" iM                Select inner function or method. Ex: viM, diM, yiM, ciM (normal, operator modes)
"let g:pymode_motion = 1
"let g:pymode_folding = 1
"" TODO: virtualenv, conda environment?
"" :PymodeRun --> can run buffer or selection
"let g:pymode_lint_on_write = 0
"let g:pymode_rope = 0
"let g:pymode_options = 0
"let g:pymode_doc = 0 "use doc from jedi vim since that only popup inside a split, not across all splits like pymode
"" set nofoldenable "don't auto fold a python file when open
"" augroup Python_settings
""     "auto open all fold when open a python file
""     autocmd! FileType python let b:delimitMate_quotes = "` '"
"" augroup END

" set completeopt-=preview

"" Plug 'pangloss/vim-javascript'
"Plug 'jelera/vim-javascript-syntax' "better javascript syntax
"Plug 'othree/javascript-libraries-syntax.vim'

"Plug 'tmux-plugins/vim-tmux' "tmux syntax; documentation
"Plug 'plasticboy/vim-markdown' "depends on tabular
"let g:vim_markdown_folding_disabled=1
"let g:vim_markdown_no_default_key_mappings = 1

"augroup Markdown_settings
"    autocmd! FileType mkd.markdown call s:markdown_settings()
"augroup END

"function! s:markdown_settings()
"    setlocal formatoptions+=ro "auto add - * when start inserting a new line
"    setlocal shiftwidth=2 tabstop=2 "for nested list
"    if has("unix")
"        let s:uname = substitute(system("uname -s"), '\n', '', '')
"        if s:uname == "Darwin"
"            setlocal makeprg=open\ % "open markdown file by chrome to view
"        endif
"    endif
"endfunction

"Plug 'shime/vim-livedown'
"nnoremap <F7> :LivedownToggle<CR>

Plug 'szw/vim-g', { 'on': 'Google' } "google search from vim
vnoremap gs :Google<CR>
nnoremap gs :Google<CR>
" search exact
vnoremap gd :Google "<CR>

" Plug 'tommcdo/vim-exchange' "exchange words, sentences... in vim: cx<motion> cx<motion>; cxx for currentline; X for visual
" Plug 'tpope/vim-dispatch' "compile, run processes
"Plug 'nathanalderson/yang.vim' "yang syntax
"Plug 'tfnico/vim-gradle' "gradle syntax
" Plug 'rickhowe/diffchar.vim' "note: latexfiles_settings function, change g:DiffUnit there
"Plug 'jwalton512/vim-blade'
"Plug 'tomlion/vim-solidity'

" [space create blank lines, [e move current line up
" [x ]x encode decode xml html, [u URL, [y C string style escape
" [a [b move between buffer. [q move between errors in quickfix. [Q first error. [l move in location list
" yos: toggle spell check. yol: toggle list option. yow: toggle wrap
" =p, =P, [p,]p    Paste after, before linewise, reindenting.
" see :h unimpaired for detailed description
Plug 'tpope/vim-unimpaired'
call plug#end()

colorscheme gruvbox
