set nocompatible

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
    nnoremap <Leader>fu :Tags<Cr>
    " Search tags with the word under the cursor
    nnoremap <Leader>fU :execute 'Tags ' . expand('<cword>')<Cr>
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

" Change virtualedit mode
nmap <leader>vd :set virtualedit=""<cr>
nmap <leader>va :set virtualedit=all<cr>

" Spell Checker
nmap <leader>sp :setlocal spell spelllang=en_us<cr>
nmap <leader>sp :setlocal spell!<cr>

" Trigger a highlight in the appropriate direction for quick-scope
"let g:qs_enable=0
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Convert camal case to Java constant style
function! JavaUpperCase()
    :s/\(\u\)/_\1/g
    :s/.*/\U&/g
endfunction

" Convert Java constant style to camal case
function! JavaLowerCase()
    :s/.*/\L&/g
    :s/_\(\l\)/\U\1/g
endfunction

" Map java constant case functions to keys
nmap <leader>ju :call JavaUpperCase()<Cr>
nmap <leader>jl :call JavaLowerCase()<Cr>
