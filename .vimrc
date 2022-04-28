"==========================="
"          SETTINGS         "
"==========================="
let mapleader="\<Space>"

syntax enable
filetype plugin indent on

set autoindent
set background=dark
set clipboard=unnamedplus
set cmdheight=2
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set hidden
set incsearch
set iskeyword+=_
set laststatus=0
set nolinebreak
set nobackup
set noerrorbells
set noswapfile
set nowrap
set nowritebackup
set number relativenumber
set pumheight=10
set ruler
set shiftwidth=2
set showtabline=2
set smartcase
set smartindent
set smarttab
set splitbelow
set splitright
set t_Co=256
set tabstop=2 softtabstop=2
set undodir=~/.vim/undodir
set undofile
set updatetime=300

highlight ColorColumn ctermbg=0 guibg=lightblue

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>l :bnext<CR>
map <leader>h :bprevious<CR>
map <leader>w :bdelete<CR>

" Split Window
nmap ss :split<CR>
nmap sv :vsplit<CR>

" Move Window
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" Switch tab
nmap <S-Tab> :bprevious<Return>
nmap <Tab> :bnext<Return>

map <leader>v :e $MYVIMRC<CR>
"==========================="
"          PLUGINS          "
"==========================="

call plug#begin()
" File Display
Plug 'scrooloose/nerdtree'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'

Plug 'preservim/nerdcommenter'

Plug 'airblade/vim-gitgutter'
call plug#end()

"==========================="
"         NERDTREE          "
"==========================="

nmap <C-n> :NERDTreeToggle<CR>

" Start NERDTree and put the cursor back in the other window
autocmd VimEnter * NERDTree | wincmd p

" Exit VIM if NERDTree is the only window remaining in the only tab
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

autocmd BufEnter * lcd %:p:h

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

" nnoremap <silent> <C-}> :bnext<CR>:call SyncTree()<CR>
" nnoremap <silent> <C-{> :bprev<CR>:call SyncTree()<CR>

"==========================="
"            FZF            "
"==========================="

"function! s:find_git_root()
  "return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
"endfunction

"command! ProjectFiles execute 'Files' s:find_git_root()

"nnoremap <silent> <C-p> :ProjectFiles<CR>

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-:> :Lines<CR>
nnoremap <silent> <C-f> :Rg<CR>

" let g:fzf_preview_window = ['right:hidden']
let g:fzf_layout = { 'down' : '50%'}

"==========================="
"          AIRLINE          "
"==========================="

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#fnamemod = ':t'
