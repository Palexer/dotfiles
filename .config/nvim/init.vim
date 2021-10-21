" neovim config file by Palexer (init.vim)

" Plugins
" Install Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'jiangmiao/auto-pairs' " auto close brackets, etc.
Plug 'godlygeek/tabular'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'chrisbra/unicode.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" general
filetype plugin indent on
set autoindent
set smartindent
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set number
syntax on
set encoding=utf-8
set nowrap
set noswapfile
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set background=dark
set noerrorbells
set t_Co=256 " force 256 colors
set cursorline!
set lazyredraw
set mouse=a
set updatetime=300

" disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" leader key
let mapleader = ","

" splits
set splitbelow
set splitright

" Enable folding 
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Brackets Highlighting Colors
hi MatchParen cterm=none ctermbg=black ctermfg=white

" status bar
set laststatus=2
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           		" buffer number
set statusline+=%#Visual#       		" colour
set statusline+=%#CursorIM#     		" colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     		" colour
set statusline+=%R                      " readonly flag
set statusline+=%M                      " modified [+] flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     		" colour
set statusline+=\ %t\                   " short file name
set statusline+=%=                      " right align
set statusline+=%#CursorLine#   		" colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     		" colour
set statusline+=\ %3l:%-2c\         	" line + column
set statusline+=%#Cursor#       		" colour
set statusline+=\ %3p%%\                " percentage

" spell checking
let b:myLang=0
let g:myLangList=["nospell","de_de","en_gb"]
function! ToggleSpell()
  let b:myLang=b:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
  endif
  echo "spell checking language:" g:myLangList[b:myLang]
endfunction

" shortcuts for spell checking:
" ]s next error / [s previous error
" z= show fixes / zg add to dictionary

" toggle language with F7
nmap <silent> <F7> :call ToggleSpell()<CR>

set complete+=kspell

" autocompletion
set completeopt=menuone,longest
set shortmess+=c

" Navigate the complete menu items like CTRL+n / CTRL+p would.
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" navigate autocompletion menu with Tab
inoremap <silent><expr><TAB>
    \ pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <silent><expr><S-TAB>
    \ pumvisible() ? "\<C-p>" : "\<TAB>"

" Coc
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" use <c-space>for trigger completion inoremap
inoremap <silent><expr> <c-space> coc#refresh()

" go to next/previous error
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

let g:coc_global_extensions = [
  \ 'coc-json', 
  \ 'coc-jedi',
  \ 'coc-go',
  \ 'coc-rls',
  \ 'coc-clangd',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-vetur',
  \ ]

let g:LanguageClient_serverCommands = {
	\ 'lua': ['lua-lsp'],
	\ }
let g:LanguageClient_autoStart = 1

" go to definition, find all references, rename
nmap <F2> <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" :Prettier to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" coc-prettier
autocmd BufWritePre *.js,*.vue,*.css,*.html,*.json,*.yml,*.yaml CocCommand prettier.formatFile

" leader + f for range format
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-go autoimports on save
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" NERDTree configuration
" Toggle side window with `CTRL+z`.
map <C-z> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1 " Show hidden files

" emmet-vim
let g:user_emmet_leader_key='<C-g>'

" hide parts of the default status bar
set noshowmode
set noruler
set noshowcmd
set cmdheight=1

" copy/paste with system clipboard by default
set clipboard+=unnamedplus

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" tabs
nnoremap <silent> <A-h> :tabprevious<CR>
nnoremap <silent> <A-l> :tabnext<CR>
nnoremap <silent> <A-H> :tabm -1<CR>
nnoremap <silent> <A-L> :tabm +1<CR>

" open new tab with NERDTree
nnoremap <silent> <A-t> :tabe .<CR>

" close tab
nnoremap <silent> <A-q> :tabclose <CR>

" compile/view document

" view sent shortcut
map <F4> :!sent %<CR><CR>

" asciidoc convert to pdf
autocmd FileType asciidoc map <buffer> <F4> :!asciidoctor-pdf -a pdf-fontsdir=/usr/share/fonts/noto,GEM_FONTS_DIR -a pdf-theme=$HOME/dotfiles/other/asciidoc-pdf-theme.yml % <CR><CR>
autocmd FileType asciidoc map <buffer> <F5> :!asciidoctor-revealjs % <CR><CR>
autocmd FileType asciidoc map <buffer> <F6> :!asciidoctor-pdf -a pdf-fontsdir=/usr/share/fonts/noto,GEM_FONTS_DIR -a pdf-theme=theme.yml % <CR><CR>

" markdown converter
autocmd FileType markdown map <buffer> <F4> :!mdconv -o %:r.pdf % <CR> <CR>
" autocmd FileType markdown map <buffer> <F5> :!mdconv -o %:r.pdf % && !zathura %:r.pdf && !rm %

" colors
colorscheme nord
set termguicolors

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" no indentation for markdown files
autocmd FileType markdown setlocal indentexpr=
autocmd FileType tex setlocal indentexpr=
