set nocompatible

call plug#begin('~/.vim/plugged')

" ControlP
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'tacahiroy/ctrlp-funky'
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

" Initialize plugin system
call plug#end()

Plug 'itchyny/lightline.vim'

" Remap leader from '\' to ','
let mapleader = " "

" If there is no fzf on this machine, use CtrlP
if (!executable('fzf'))
    " Enable CtrlP extensions
    let g:ctrlp_extensions = ['funky']

    " Fix CommandP by switching the searching tool to something that works and is faster
    if (executable('fd'))
        let g:ctrlp_user_command = 'fd --type file'
    endif
endif

if (executable('fzf'))
    " Remap CtrlP mappings to FZF
    nnoremap <c-p> :Files<Cr>
    nnoremap <Leader>fu :Tags<Cr>
    " Search tags with the word under the cursor
    nnoremap <Leader>fU :execute 'Tags ' . expand('<cword>')<Cr>
else
    " Keys for CtrlP Funky
    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
endif

" Visual
colorscheme jellybeans

" Relative line number
set number                     " Show current line number
set relativenumber             " Show relative line numbers

" Shift+dir to jump paragraphs
nnoremap <S-k> <S-{>
nnoremap <S-j> <S-}>

" Shift+dir to jump to begin/end of line
nnoremap <S-h> ^
nnoremap <S-l> $

" Map Ctrl-j to Shift-j; aka line join
nnoremap <c-j> <S-j>

" Map Ctrl+O to open the NERDTree sidebar
nmap <silent> <c-o> :NERDTreeToggle<cr>

" Map Ctrl-Tab to go to next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
" Map Ctrl-Shift-Tab to go to previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
" Map Ctrl-n to create a new blank tab
nnoremap <c-n> :tabnew<cr>
" Map Ctrl-k to kill/close the current tab
nnoremap <c-k> :tabc!<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Sets the default register to use the "* reg.
set clipboard=unnamed

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
