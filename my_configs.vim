set showcmd
set number 
colorscheme gruvbox 

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>


" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif



" PLUGINS


let data_dir = '$HOME/.vim_runtime' 
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim_runtime/my_plugins')

Plug 'rhysd/vim-clang-format'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jiangmiao/auto-pairs'
" Plug 'alvan/vim-closetag' 
call plug#end()


ClangFormatAutoEnable
nmap <leader>cf :ClangFormat<cr>


g:ackprg = 'ag --nogroup --nocolor --column'

"""""""""""""""""""""""""""""""""""""""
" Coc
"""""""""""""""""""""""""""""""""""""""

" " Tab to go through completion list
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? "\<C-y>":
      \ CheckBackspace() ? "\<TAB>":
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? "\<C-p>" : "\<C-h>"

inoremap <expr> <cr> coc#pum#visible() ? "\<C-y>" : "\<C-g>u\<CR>"


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
"
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

"""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""
" let g:UltiSnipsExpandTrigger="<C-y>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" autocmd FileType js UltiSnipsAddFiletypes html
" autocmd FileType jsx UltiSnipsAddFiletypes html
" autocmd FileType ts UltiSnipsAddFiletypes html
" autocmd FileType tsx UltiSnipsAddFiletypes html
"
"
autocmd FileType typescriptreact let b:AutoPairs = AutoPairsDefine({'>' : '<'}, [])
autocmd FileType typescript.tsx let b:AutoPairs = AutoPairsDefine({'>' : '<'}, [])
autocmd FileType html let b:AutoPairs = AutoPairsDefine({'>' : '<'}, [])
autocmd FileType typescript let b:AutoPairs = AutoPairsDefine({'>' : '<'}, [])
autocmd FileType javascript let b:AutoPairs = AutoPairsDefine({'>' : '<'}, [])
