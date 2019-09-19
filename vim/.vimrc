set nocompatible

let g:has_async = v:version >= 800 || has('nvim')

call plug#begin('~/.vim/plugged')

" ControlP (requires fzf installed)
Plug 'tacahiroy/ctrlp-funky'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Theme Plugin
Plug 'nanotech/jellybeans.vim'

" Side windows displaying buffers
Plug 'jeetsukumaran/vim-buffergator'

" Improve the `.` command to include macros, plugin maps, etc.
Plug 'tpope/vim-repeat'

" Switch between source and header
Plug 'vim-scripts/a.vim'

" Moving lines up+down
Plug 'matze/vim-move'

" Improved status line (e.g. file named)
Plug 'itchyny/lightline.vim'

" Toggle surroundings around text
Plug 'tpope/vim-surround'

" Highlight the first char to a word
Plug 'unblevable/quick-scope'

" Improved Rainbow Parenthesis
Plug 'luochen1990/rainbow'

" Git features 
Plug 'tpope/vim-fugitive'

" CTags manager
Plug 'ludovicchabant/vim-gutentags'

" Show information about files in a git repo
Plug 'airblade/vim-gitgutter'

" Asynchronous Lint Engine
if g:has_async
    " Disabled due to speed issues. TODO: Investigate and resolve
    "Plug 'w0rp/ale'
endif

" Initialize plugin system
call plug#end()

" Needed in Linux Shell to send <Alt+j/k> for the `vim-move` plugin
if !has('win32')
    execute "set <M-j>=\ej"
    execute "set <M-k>=\ek"
    execute "set <M-h>=\eh"
    execute "set <M-l>=\el"
endif

" Remap leader from '\' to ','
let mapleader = ","

if (executable('fzf'))
    " Remap CtrlP mappings to FZF
    nnoremap <c-p> :Files<Cr>
    nnoremap <Leader>ct :Tags<Cr>
    " Search tags with the word under the cursor
    nnoremap <Leader>cc :execute 'Tags ' . expand('<cword>')<Cr>
else
    " If there is no fzf on this machine, use CtrlP
    " Enable CtrlP extensions
    let g:ctrlp_extensions = ['funky']

    " Fix CommandP by switching the searching tool to something that works and is faster
    if (executable('fd'))
        let g:ctrlp_user_command = 'fd --type file'
    endif

    " Keys for CtrlP Funky
    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
endif

" Visual
colorscheme jellybeans

" Tell vim-whitespace to strip whitespace on save
let g:strip_whitespace_on_save = 1

" Enable Rainbow Parenthesis
let g:rainbow_active = 1

" Run linter only after I save the file, not continuously
"let g:ale_lint_on_enter = 0
" Do not run the linters immediatley after file open
"let g:ale_lint_on_text_changed = 'never'

" Relative line number
set number                     " Show current line number
set relativenumber             " Show relative line numbers

" Shift+dir to jump paragraphs
nnoremap <S-k> <S-{>
nnoremap <S-j> <S-}>

" Shift+dir to jump to begin/end of line
nnoremap <S-h> ^
nnoremap <S-l> $

" Use Ctrl-c as the escape
nmap <c-c> <esc>
imap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>

" Map Ctrl-j to Shift-j; aka line join
nnoremap <c-j> <S-j>

" Map Ctrl+O to open the NERDTree sidebar
nmap <silent> <c-o> :NERDTreeToggle<cr>

" Map Ctrl-l to go to next tab
noremap <C-l> :<C-U>tabnext<CR>
inoremap <C-l> <C-\><C-N>:tabnext<CR>
" Map Ctrl-h to go to previous tab
noremap <C-h> :<C-U>tabprevious<CR>
inoremap <C-h> <C-\><C-N>:tabprevious<CR>
" Map Alt-h to go to move this tab to the left
noremap <M-h> :<C-U>-tabmove<CR>
inoremap <M-h> <C-\><C-N>:-tabmove<CR>
" Map Alt-l to go to move this tab to the right
noremap <M-l> :<C-U>+tabmove<CR>
inoremap <M-l> <C-\><C-N>:+tabmove<CR>
" Map Ctrl-n to create a new blank tab
nnoremap <c-n> :tabnew<cr>
" Map Ctrl-k to kill/close the current tab
nnoremap <c-k> :tabc!<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Unhighlight search terms with leader+space
nnoremap <leader><space> :noh<cr>

" Sets the default register to use the "* reg on Windows.
if has('win32')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

set autoindent
set smartindent
" Tab width in spaces
set tabstop=4
" Size of indent in spaces
set shiftwidth=4
" Make spaces feel like real tabs
set softtabstop=4
" Convert tabs to spaces
set expandtab

map <F2> :let @+ = expand("%")<cr>

set guifont=FuraCode_NF:h11
set guifont+=Fira_Code:h11
set guifont+=Consolas:h11

" Must be set before GUI is loaded, don't move to gvimrc.
" For flag explanation, read http://vimdoc.sourceforge.net/htmldoc/options.html#'guioptions'
" Disable menus and preserve window sizing
set guioptions=Mk

" Set the default search to use smartcase
set ignorecase
set smartcase

" Make the backspace + delete work like in most other programs
set backspace=indent,eol,start

" Show a real status line
set laststatus=2

" Hide the default mode indicator (using lightline instead)
set noshowmode

" Highlight all search matches
set hlsearch
" Highlight all search matches while searching
set incsearch
" Unhighlight search terms with leader+space
nnoremap <leader><space> :noh<cr>

" Set colorscheme options based on detected 256 color support
if &t_Co == 256
    " Use 24-bit color if available
    if has('termguicolors')
        " Required to set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
    endif
endif

" Ensure Powershell uses correct colors
set termguicolors

" Set search to very-magic
nnoremap / /\v
cnoremap %s/ %s/\v

" Gheto custom autoclose mappings
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Keybinding for substitute word with yanked register
nmap <leader>ss ve"0p
" Keybinding for paste yanked register
nmap <leader>p "0p
" Keybinding for paste yanked register behind
nmap <leader>P "0P
" Keybinding for paste yanked register when in visual mode
vmap <leader>p "0p

" Change virtualedit mode
nmap <leader>vd :set virtualedit=""<cr>
nmap <leader>va :set virtualedit=all<cr>

" Spell Checker
nmap <leader>sp :setlocal spell spelllang=en_us<cr>
nmap <leader>sp :setlocal spell!<cr>

" RipGrep with the word under the cursor
nnoremap <leader>rg :execute 'Rg ' . expand('<cword>')<Cr>

" Pull word under cursor into LHS of a substitute (find and replace)
nnoremap <leader>rr :%s#\<<C-r>=expand("<cword>")<CR>\>#
" Same thing, but global within the line and don't match whole word
nnoremap <leader>rw :%s/<C-r>=expand("<cword>")<CR>//g

" Alias for :w
nnoremap <leader>w :w<Cr>

" Alias for :Buffers
nnoremap <leader>b :Buffers<Cr>

" Alias for :e! (force reload buffer)
nnoremap <leader>e :e!<Cr>

" Alias for :A (switching source/header with a.vim)
nnoremap <leader>a :A<Cr>

" Edit vimr configuration file
nnoremap <leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <leader>vr :source $MYVIMRC<CR>

" Faster scrolling
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Map Ctrl+[/] to increment/decrement
nnoremap <C-[> <C-x>
nnoremap <C-]> <C-a>

" Clean up pasted in text, replacing large whitespace with newlines and
" removing line numbers
nnoremap <leader><C-v> :%s/ \{5,\}/\r/g<CR> :%s/^[0-9]\+ *//g<CR>

" Trigger a highlight in the appropriate direction for quick-scope
"let g:qs_enable=0
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Convert camal case to Java constant style
function! JavaUpperCase()
    :s/\(\u\)/_\1/g
    :s/.*/\U&/g
endfunction

" Add argument (can be negative, default 1) to global variable i.
" Return value of i before the change.
function! Inc(...)
  let result = g:i
    let g:i += a:0 > 0 ? a:1 : 1
      return result
endfunction

" Pull word under cursor into LHS of a increasing number addition
nnoremap <leader>inc :let i = 1<Cr> :%s/\(<C-r>=expand("<cword>")<CR>\)/\=submatch(1) . Inc()/g

" Convert Java constant style to camal case
function! JavaLowerCase()
    :s/.*/\L&/g
    :s/_\(\l\)/\U\1/g
endfunction

" Map java constant case functions to keys
nmap <leader>ju :call JavaUpperCase()<Cr>
nmap <leader>jl :call JavaLowerCase()<Cr>

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" Get null output stream path based on platform
function! DevNullPath()
    if has('win32')
        return 'NUL'
    else
        return '/dev/null'
    endif
endfunction

" Creates the given directory if it doesn't exist
function! EnsureDirectory(path)
    let a:expandedPath = expand(a:path)
    let a:devNull = DevNullPath()
    if empty(glob(a:expandedPath))
        :silent execute '!mkdir -p ' . a:expandedPath . ' > ' . a:devNull . ' 2>&1'
    endif
endfunction

" Enable persistent undo, and put undo files in their own directory to prevent
" pollution of project directories
if has('persistent_undo')
    call EnsureDirectory('~/.vim/undo')
    " Remove current directory and home directory, then add .vim/undo as main
    " dir and current dir as backup dir
    set undodir-=.
    set undodir-=~/
    set undodir+=.
    set undodir^=~/.vim/undo//
    set undofile
endif

" Move swap files and backup files to their own directory to prevent pollution
call EnsureDirectory('~/.vim/backup')
" Remove current directory and home directory, then add .vim/backup as main dir
" and current dir as backup dir
set backupdir-=.
set backupdir-=~/
set backupdir+=.
set backupdir^=~/.vim/backup//
" Enable standard backups if not built with 'writebackup'
if !has('writebackup')
    set backup
endif

call EnsureDirectory('~/.vim/swap')
" Remove current directory and home directory, then add .vim/swap as main
" dir and current dir as backup dir
set directory-=.
set directory-=~/
set directory+=.
set directory^=~/.vim/swap//
set swapfile
