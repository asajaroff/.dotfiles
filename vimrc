" Galera's .vimrc file

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Multi Language Spell Checking
" For Spanish dictionary I use:
" :setlocal spell spelllang=spa
" :setlocal spell spelllang=spa
"
" set spell

set nocompatible

" Visual Bell
set visualbell

" Large status
set ruler
set laststatus=2

" Use case insensitive search, except when using capital letters.
set ignorecase
set smartcase

" Set all swap files to go to the same directory so they are not scattered everywhere.
set directory=~/.vim/swapfiles//
set backupdir=~/.vim/backupfiles//

" Set undo directory so undo persists outside of vim.
set undodir=~/.vim/undodir
set undofile

" Display line numbers on the left.
set number relativenumber

" Indenting
set autoindent
set smartindent
set shiftwidth=2

" Color Syntax
syntax on

" Tabbing options
set ts=2
set sts=2
set et

" Whitespaces (Activate with :set list)
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Powerline support
" set rtp+=/usr/lib/python3.7/site-packages/powerline/bindings/vim
let g:powerline_pycmd="py3"

" Filetype 
filetype plugin on

" Finding Files
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Search
set incsearch

" Copy to macOS clipboard
vmap '' :w ! pbcopy<CR><CR>

" netrw Configuration
" Tree style directory view
let g:netrw_liststyle=3

" Remove banner 
let g:netrw_banner = 0

let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 20

" YAML 
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
