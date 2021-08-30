"============================================================================
"
"=============================================================================


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	 !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	 !pip3 install --user --upgrade pynvim
endif

" ===
" Settings
set number
set relativenumber

set mouse=nvic
set hidden
set updatetime=300
set shortmess+=c

set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set wildmenu
set showcmd
set list
set wrap
set whichwrap=b,s,<,>,[,]
set listchars=tab:\|\ ,trail:▫
set hlsearch
set incsearch
set ignorecase
set smartcase
set foldmethod=indent
set cindent
set foldlevelstart=999
exec "nohlsearch"

set ruler
set sidescroll=10
set scrolloff=5

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
syntax enable

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" persistent operation hist Copy from theniceboy
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

" ===
" KEY MAP
nmap <Space> <nop>
let mapleader=" "
map U <C-r>
map <LEADER>w :w<CR>
map <LEADER>W :w !sudo tee %
map <LEADER>q :wq<CR>
map <LEADER>Q :q!<CR>
map H 5h
map J 5j
map K 5k
map L 5l
noremap! jkl <Esc>
noremap! <C-h> <left>
noremap! <C-j> <down>
noremap! <C-k> <up>
noremap! <C-l> <right>
vmap <LEADER>n :normal
map <C-h> :help<Space>

" ===
" Comment
nmap <LEADER>c 0i"<Space><Esc>
nmap <LEADER>C 0d2l
vmap <LEADER>c :normal 0i"<Space><CR>
vmap <LEADER>C :normal 0d2l<CR>

noremap <LEADER>h :nohlsearch<CR>
map <LEADER>f zM
map <LEADER>F zR
map <LEADER>r :source $MYVIMRC<CR>

" Split
map sh :set nosplitright<CR>:vsplit<CR>
map sl :set splitright<CR>:vsplit<CR>
map sj :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>
map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>l <C-w>l
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
map <up> :res +5<CR>
map <down> :res -5<CR>

" Tab
map nt :tabe<CR>
map tn :-tabnext<CR>
map tp :+tabnext<CR>

" Yank
map <LEADER>y "*y
map <LEADER>p "*p
vmap <LEADER>y "*y
vmap <LEADER>p "*p

" For Parallels Desktop
" map <LEADER>y "+y
" map <LEADER>p "+p
" vmap <LEADER>y "+y
" vmap <LEADER>p "+p

" No interrupt
map <C-z> <nop>

" NerdTree
map <LEADER>nt :NERDTree
map <LEADER>ntv :NERDTreeVCS
map <LEADER>ntfb :NERDTreeFromBookmark
map <LEADER>ntt :NERDTreeToggle
map <LEADER>nttv :NERDTreeToggleVCS
map <LEADER>ntf :NERDTreeFocus<CR>
map <LEADER>ntc :NERDTreeClose<CR>
map <LEADER>ntf :NERDTreeFind

" ===
" Command
" Show changes
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis

" vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'mbbill/undotree'
Plug 'dense-analysis/ale'
Plug 'preservim/tagbar'
Plug 'instant-markdown/vim-instant-markdown'
Plug 'kshenoy/vim-signature'
Plug 'li-yi-dong/vim-cuda-syntax'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'


call plug#end()


" ===
" Plug settings

" ===
" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
autocmd BufWinEnter * silent NERDTreeMirror

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let NERDTreeShowHidden=1

" ===
" CoC
" Extensions
let g:coc_global_extensions = [
	\'coc-json',
	\'coc-vimlsp',
	\'coc-clangd',
	\'coc-cmake',
	\'coc-todolist',
    \'coc-actions',
    \'coc-translator',
    \'coc-snippets',
    \'coc-lists',
    \'coc-prettier',
    \'coc-yank',
	\'coc-marketplace']

" Tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Kep map
inoremap <silent><expr> <C-o> coc#refresh()
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> D :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>cc  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <silent> <space>Y  :<C-u>CocList -A --normal yank<cr>

nmap ts <Plug>(coc-translator-p)

let g:lsp_settings = {'clangd': {'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cuda']}}
