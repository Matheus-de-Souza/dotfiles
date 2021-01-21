filetype plugin indent on
set nocompatible
set encoding=utf-8

syntax enable

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
	Plug 'pangloss/vim-javascript'
	Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

if has('gui_running')
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
endif

if has("gui_macvim")
	set macligatures
endif

" Font
set guifont=Fira\ Code:h13 " https://github.com/tonsky/FiraCode/issues/462
set renderoptions=type:directx

" Line numbers
set number relativenumber

" Show relative numbers when focus
" Show line numbers when blur
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Colorscheme
set termguicolors
set background=dark
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

set wrap
set textwidth=100
set formatoptions=qrn1
"set colorcolumn=100

set showmode

" Fix movements
let mapleader = ","

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

inoremap jk <ESC>
map Y y$

map <M-z> :set wrap!<CR>

" === SHORTCUTS ===
" 
map <leader>ss :sort<CR>

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
map <leader>sv :vsp<CR><C-l>
map <leader>sh :sp<CR><C-j>
" Change window easily
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k
noremap <silent> <C-l> <C-w>l
inoremap <silent> <C-h> <Esc><C-w>h
inoremap <silent> <C-j> <Esc><C-w>j
inoremap <silent> <C-k> <Esc><C-w>k
inoremap <silent> <C-l> <Esc><C-w>l

" Tabs
map <leader>tn :tabnew<CR>
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

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

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

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

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

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
