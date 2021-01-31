" neovim config file by Palexer (init.vim)

set number
syntax on
set encoding=utf-8
set smartindent
set tabstop=4
set shiftwidth=4
set nowrap
set nu
set noswapfile
set undodir=~/.vim/undodir
set undofile
set incsearch
set background=dark
set noerrorbells

" splits
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" colors
colorscheme onedark
set termguicolors

" Plugins
" Install Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
call plug#end()

