filetype plugin indent on
set nocompatible
set encoding=utf-8

syntax enable
set re=0

" Use same directory for windows and linux
if has('win32') || has('win64')
	set runtimepath^=~/.vim
endif

" Don't forget to run :PlugInstall
" After changing plugins
call plug#begin('~/.vim/plugged')
	" Conquer Of Completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Installed Language Servers
	" CocInstall coc-tsserver
	" CocInstall coc-vetur "Need to install: npm i eslint eslint-plugin-vue -D
	" CocInstall coc-eslint
	" CocInstall coc-json
	" CocInstall coc-phpls

	" More expressiveness
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-abolish'

	" On-demand loading
	Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
	Plug 'preservim/nerdcommenter'

	" Fuzzy Finder
	" On windows it's necessary to install with 'choco install fzf'
	" https://github.com/junegunn/fzf.vim
	" Remember to install: The Silver Searcher (Ag)
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" Colorschemes
	Plug 'phanviet/vim-monokai-pro'

	" Syntax highlight improvements
	Plug 'sheerun/vim-polyglot' 

	" Plug 'posva/vim-vue'
	
	"Plug 'pangloss/vim-javascript'  " Javascript syntax highlight
	"Plug 'HerringtonDarkholme/yats.vim' " Typescript syntax highlight
	Plug 'ekalinin/Dockerfile.vim' " Dockerfile syntax highlight

	Plug 'habamax/vim-asciidoctor'

call plug#end()

if has('gui_running')
	" set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
endif

if has("gui_macvim")
	set macligatures
endif

" Font
if has('gui_running')
	set guifont=Fira\ Code\ 13 " https://github.com/tonsky/FiraCode/issues/462
else 
	set guifont=Fira\ Code:h13
endif

set renderoptions=type:directx " https://github.com/tonsky/FiraCode/issues/462

" Line numbers
set nonumber

" Show relative numbers when focus
" Show line numbers when blur
" augroup numbertoggle
  " autocmd!
  " autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
  " autocmd BufLeave,FocusLost,InsertEnter   * set nonumber norelativenumber
" augroup END

" Colorscheme
" This code is needed to allow tmux on tmux with konsole
if &term =~# '256color' && ( &term =~# '^screen'  || &term =~# '^tmux' )
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

colorscheme monokai_pro
let g:lightline = {
			\ 'colorscheme': 'monokai_pro',
			\ }

set backspace=indent,eol,start

set autoindent

"set visualbell

set ignorecase
set smartcase
" set gdefault
set incsearch
set showmatch
set hlsearch

set scrolloff=3
set sidescrolloff=5

set wrap
set linebreak
set textwidth=100
set formatoptions=qrn1
"set colorcolumn=100

set showmode

" Fix movements
let mapleader = ","

" Enforce stop using arrows
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap j gj
nnoremap k gk

" Back to normal quickly
inoremap jk <ESC>

map Y y$

" Toggle wrap text
if !has("macunix")
	map \ez :set wrap!<CR>
else
	map Ω :set wrap!<CR>
endif

" === SHORTCUTS ===
map <leader>ss :sort<CR>

noremap <C-e> 2<C-e>
noremap <C-y> 2<C-y>

" Save/Load Files
map <leader>w :w<CR>
map <leader>e :e 

" Buffers
map <leader>bb :Buffers<CR>
map <leader>bf :buffer 
map <leader>bn :bn<CR>
map <leader>bp :bp<CR>

" Windows
" Split windows
map <leader>sv :vsp<CR><C-w>l
map <leader>sh :sp<CR><C-w>j
map <leader>sV :vsp<CR>
map <leader>sH :sp<CR>
"
" Change window easily
if !has("macunix")
	noremap <silent> <C-h> <C-w>h
	noremap <silent> <C-j> <C-w>j
	noremap <silent> <C-k> <C-w>k
	noremap <silent> <C-l> <C-w>l
	inoremap <silent> <C-h> <Esc><C-w>h
	inoremap <silent> <C-j> <Esc><C-w>j
	inoremap <silent> <C-k> <Esc><C-w>k
	inoremap <silent> <C-l> <Esc><C-w>l
else
	noremap <silent> ħ <C-w>h
	noremap <silent> ʝ <C-w>j
	noremap <silent> ĸ <C-w>k
	noremap <silent> ł <C-w>l
	inoremap <silent> ħ <Esc><C-w>h
	inoremap <silent> ʝ <Esc><C-w>j
	inoremap <silent> ĸ <Esc><C-w>k
	inoremap <silent> ł <Esc><C-w>l
	noremap <silent> ˙ <C-w>h
	noremap <silent> ∆ <C-w>j
	noremap <silent> ˚ <C-w>k
	noremap <silent> ¬ <C-w>l
	inoremap <silent> ˙ <Esc><C-w>h
	inoremap <silent> ∆ <Esc><C-w>j
	inoremap <silent> ˚ <Esc><C-w>k
	inoremap <silent> ¬ <Esc><C-w>l
endif

" Tabs
map <leader>tn :tabnew<CR>
map <leader>tN :tab split<CR>
map <leader>tm :tabmove +1<CR>
map <leader>tM :tabmove -1<CR>
noremap <PageUp> :tabprev<CR>
noremap <PageDown> :tabnext<CR>
noremap <leader><PageUp> :tabmove -1<CR>
noremap <leader><PageDown> :tabmove +1<CR>

" Toggles
map <leader>th :set hlsearch!<CR>
map <leader>tp :set paste!<CR>
map <leader>tw :set wrap!<CR>

" netrw (File Explorer)
map <leader>ee :Explore<CR>

" Reload .vimrc on runtime
map <leader>cr :source ~/.vimrc<CR> 
map <leader>co :e ~/.vimrc<CR>

" === PLUGINS ===
" NERDTree
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree

let g:NERDTreeChDirMode = 2 " Changes vim CWD when NERDTree changes root dir
map <leader>n :NERDTreeToggle<CR>
map <leader>bo :OpenBookmark 

" nerdcommenter
let g:NERDSpaceDelims = 1 " Use space after comment delimiter

" FZF
map <leader>ff :FZF<CR>
map <leader>fg :Ag 
map <leader>fr :Fold<CR>zMzv

" === COC ===
" Shortcuts

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif
"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>ccrn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>ccf  <Plug>(coc-format-selected)
nmap <leader>ccf  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>cca  <Plug>(coc-codeaction-selected)
nmap <leader>cca  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ccac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>ccqf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ccd  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>cce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>ccc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>cco  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ccs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>ccj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>cck  :<C-u>CocPrev<CR>
" Antes os atalhos eram só <space>k

" Other Configurations
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
