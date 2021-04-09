"""""""""
" Useful default keyboard shorctuts:
"       Ctrl+A (normal mode) - increment next number
"       Ctrl+X (normal mode) - decrement next number
"       gd - go to definition
"       gD - go to global definition

" How to get .vims files associated with gvim:
" From admin command prompt:
" assoc .vims=vimsession
" ftype vimsession="C:\Program Files (x86)\Vim\vim81\gvim.exe" -S "%1" 

" Figure out where the vimfiles directory is
if has('win32')
    let $MYVIMDIR = $HOME."/vimfiles/"
else
    let $MYVIMDIR = $HOME."/.vim/"
endif


"==== vim plug ====
" Update this list and run PlugInstall or PlugUpdate or PlugClean
call plug#begin()
Plug 'nanotech/jellybeans.vim'        " Color scheme
Plug 'kshenoy/vim-signature'          " Plugin to make marks easier
Plug 'PProvost/vim-ps1'               " Powershell stuff
Plug 'triglav/vim-visual-increment'   " Ctrl-A block selection increment
Plug 'tpope/vim-surround'             " Edit surrounding stuff like quotes
Plug 'vim-airline/vim-airline'        " The fancy tabline/statusline
Plug 'frioux/vim-regedit'             " Visual register editing
Plug 'udalov/kotlin-vim'              " Kotlin syntax
Plug 'lervag/vimtex'                  " LaTeX plugin
" SnipMate stuff:                     " Add text snippets
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
call plug#end()

" Enable matchit
packadd! matchit

" https://github.com/nanotech/jellybeans.vim
syntax on
let g:jellybeans_overrides = {
\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
\              'attr': 'bold' },
\    'String': { 'guifg': 'ff8000' },
\    'background': { 'guibg': '000000' },
\    'Label': { 'guifg': '8cf2ff' },
\}
colorscheme jellybeans

set number
set nocompatible
set backspace=indent,eol,start
set guifont=DejaVu_Sans_Mono:h11
set mouse=a
set guioptions=gk!
au GUIEnter * simalt ~x " start maximized
set guipty
set showtabline=2 " always show the tab bar
set hlsearch incsearch
set nobomb
set autochdir
set autoindent
set tabstop=4
set expandtab
filetype plugin indent on

" Turn on matchit
runtime macros/matchit.vim

" Configure the statusline
set laststatus=2 " always show it
"let &statusline="Line:%l  Col:%c  Line Len:%{strwidth(getline('.'))} Char:0x%B"

"** Airline stuff **"
set hidden " Allows modified buffers to be hidden
let g:airline_section_z="L:%l C:%c LLen:%{strwidth(getline('.'))} C:0x%B"

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Don't use octal or hex for number increment/decrement (C-A/C-X)
set nrformats-=octal
set nrformats-=hex

" Make the TAB key insert 4 spaces, but still behave as a tab
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 "smarttab

" Smartcase+Ignorecase will make searches case-insensitive if they contain
" only lowercase characters
set ignorecase smartcase

" Use the system clipboard for yank/paste
set clipboard=unnamed

" Make splits open more intuitively
set splitbelow splitright

" Set the swap file directory so it doesn't put them in the current directory
set directory=$MYVIMDIR/swapfiles//

" Set an undo directory for persistant undo
set undodir=$MYVIMDIR/undodir
set undofile

" Use the 'simalt' command when alt+space is pressed
" to make the window menu pop up
nnoremap <M-Space> :simalt ~<CR>
inoremap <M-Space> <Esc>:simalt ~<CR>
vnoremap <M-Space> <Esc>:simalt ~<CR>

" Map Enter in normal mode to start a command
nnoremap <cr> :

vnoremap < <gv
vnoremap > >gv

" Map ctrl+n to find and center
nnoremap <c-n> nzz
nnoremap <c-s-n> Nzz

" Map Alt+Drag for block selection
noremap <M-LeftMouse> <4-LeftMouse>
inoremap <M-LeftMouse> <4-LeftMouse>
onoremap <M-LeftMouse> <C-C><4-LeftMouse>
noremap <M-LeftDrag> <LeftDrag>
inoremap <M-LeftDrag> <LeftDrag>
onoremap <M-LeftDrag> <C-C><LeftDrag>

" Easier paste 0 buffer
nnoremap <leader>p "0p
vnoremap <leader>p "0p
nnoremap <leader>P "0P
vnoremap <leader>P "0P

" Paste with CTRL+V, remap normal CTRL+V to CTRL+SHIFT+V
inoremap <c-v> <c-r>*

" Move lines up/down 
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Custom keyboard shortcuts
let mapleader=","
let maplocalleader='-'

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>eh :vsplit $MYVIMDIR/doc/cheatsheet.txt<cr>
nnoremap <leader>sh :helptags $MYVIMDIR/doc<cr>

" Tab shortcuts
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>q :tabclose<cr>
" Buffer shortcuts
nnoremap <C-Left> :bprev<cr>
nnoremap <C-h> :bprev<cr>
nnoremap <C-Right> :bnext<cr>
nnoremap <C-l> :bnext<cr>
nnoremap <leader>b :enew<cr>
nnoremap <leader>w :bd<cr>
nnoremap <leader>W :bd!<cr>
nnoremap <C-k> :ls<CR>:b<Space>

vnoremap <leader>y "*y
nnoremap <c-F1> :call ToggleToolbar()<cr>
" Keys to put the current line at the center, top, and bottom
nnoremap <space> zz
nnoremap <S-space> zt
nnoremap <C-space> zb
nnoremap ZZ <nop>
inoremap <S-Tab> <C-d>
cnoremap <a-bs> <c-w>
inoremap <c-bs> <c-w>
nnoremap <F9> :call FindAll()<cr>
nnoremap <F1> :call FindLastLabel()<cr>
" Make Y yank the whole line
nnoremap Y yg_
imap <C-u> <C-o>:call Repeat()<cr>

" Identify the syntax highlighting group used at the cursor
" Used for debugging language syntax files
map <F10> :echo "<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Custom commands / functions

" execute a command and show its output in a split window
command! -nargs=* -complete=shellcmd Rsplit execute "new | r! <args>"

" execute a command and show its output in a new tab
command! -nargs=* -complete=shellcmd Rtab execute "tabnew | r! <args>"

command! -nargs=0 Labels :vimgrep /^\s*\w\+:\(=\)\@!/ % | cwin

command! -nargs=0 ReverseToMarkA :.,'ag/^/m 'a<cr>

function! TrimTrailingWhitespace()
	execute ":%s/\\s\\+$//g"
	execute ":normal! ``"
endfunction

function! ToggleToolbar()
	if &guioptions=~#'mTrL'
		set guioptions-=mTrL
	else
		set guioptions+=mTrL
	endif
endfunction

function! Surround(start,end)
    call setline(line("."), a:start.getline(".").a:end)
endfunction

" Public domain function from
" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript/6271254#6271254
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! FindAll()
    call inputsave()
    let p = input('Enter pattern:')
    call inputrestore()
    execute 'vimgrep "'.p.'" % |copen'
endfunction

function! SecondsToTime(sec)
    let h=a:sec/3600
    let m=(a:sec%3600)/60
    let s=a:sec%60
    return printf("%02d:%02d:%02d",l:h,l:m,l:s)
endfunction

function! Repeat()
    let times = input("Count: ")
    let char  = input("Char: ")
    exe ":normal a" . repeat(char, times)
endfunction

"  Pad('abc', 5) == 'abc  '
"  Pad('ab', 5) ==  'ab   '
function! Pad(s,amt)
    return a:s . repeat(' ',a:amt - len(a:s))
endfunction

" PrePad('832', 4)      == ' 823'
" PrePad('832', 4, '0') == '0823'
function! PrePad(s,amt,...)
    if a:0 > 0
        let char = a:1
    else
        let char = ' '
    endif
    return repeat(char,a:amt - len(a:s)) . a:s
endfunction

function! LoadTags(rel)
    set tags=
    for i in split(glob($MYVIMDIR.'/tags/' . a:rel .'/*.tags'),'\n')
        execute 'set tags+=' . l:i
    endfor
endfunction

" Plugin configs

" SnipMate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.snippet_version = 1
imap <C-j> <Plug>snipMateNextOrTrigger
smap <C-j> <Plug>snipMateNextOrTrigger
imap <C-k> <Plug>snipMateBack
smap <C-k> <Plug>snipMateBack
imap <C-R><C-j> <Plug>snipMateShow

