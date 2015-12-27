"
"  ~/.vimrc
" author  : TingoL
" amelxmx [at] gmail [dot] com
"
syntax on                   "self explanatory
filetype plugin on          "loads things based on document type
colorscheme euphrasia

let mapleader=" "
let maplocalleader="\\"
set backupdir=~/.vim/backup " Keep backups in ~/.vim/backup
set directory=~/.vim/temp   " Keep temp files in ~/.vim/temp
set hidden                  "allow scrolling between unsaved buffers
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set scrolloff=2             " 2 lines above/below cursor when scrolling
set foldmethod=manual
set relativenumber
set number                 " show line numbers
set lazyredraw
set wildmenu               " enhanced tab-completion shows all matching cmds in a popup menu
set regexpengine=1         " needed for jsctags
set clipboard=unnamed      " yank to X clipboard
set pastetoggle=<F2>
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set showmatch              " show matching brackets
set incsearch              " increment search
set ignorecase             " case-insensitive search
set smartcase              " uppercase causes case-sensitive search
set gdefault               " set /g on search default
set background=dark
"fzf
set rtp+=~/.fzf
let g:loaded_matchparen = 1
let g:acp_behaviorKeywordLength = 4
let g:vimwiki_list = [{'path':'~/Dropbox/vimwiki',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" status bar
set statusline=\ \%F%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\
set laststatus=2
set cmdheight=1
set encoding=utf-8

" vundle bundle
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'bling/vim-airline'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'tComment'
Plugin 'godlygeek/tabular'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'vimwiki/vimwiki'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'junegunn/goyo.vim'
Plugin 'mileszs/ack.vim'
Plugin 'chrisbra/csv.vim'
Plugin 'junegunn/fzf'
Plugin 'sjl/gundo.vim'

call vundle#end()
filetype plugin indent on   "new smartindent

inoremap <C-y> <C-k>
"ag for ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'
"airline symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = "luna"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
"neocomplcache magic
let g:acp_enableAtStartup = 0                                   " Disable AutoComplPop.
let g:neocomplcache_enable_at_startup = 1                       " Use neocomplcache.
let g:neocomplcache_enable_smart_case = 1                       " Use smartcase.
let g:neocomplcache_min_syntax_length = 3                       " Set minimum syntax keyword length.
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns['python'] = '[^. t].w*'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/UltiSnips'

" always jump to the last cursor position
autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

autocmd BufRead,BufNewFile *.txt set tw=80                                         " limit width to n cols for txt files
autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
autocmd FileType markdown set tw=80                                          " wrap at 80 chars for LaTeX files
autocmd FileType html setlocal shiftwidth=2 tabstop=2
" Enable omni completion.
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
let g:pydiction_location = '/usr/share/pydiction/complete-dict'

"mapping ------------------------------------------------------------------------
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
"mdless preview
nmap <silent><Leader>m :!mdless %:p<CR>
"spellcheck
nmap <silent> <leader>s :set spell!<CR>
" paragraph formatting
map <Leader>p gqap
" F-keys
nnoremap <Space> <Leader>
nnoremap <F6> :TagbarToggle<CR>
nnoremap <Leader>G :Goyo<CR>
"highlight last inserted text
nnoremap gV `[v`]`
"buffers
nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bp<CR>
"sorting
vnoremap <Leader>t :sort<CR>
"indentation
vnoremap < <gv
vnoremap > >gv
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
" Allows writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null

"up and down on wraps
nnoremap j gj
nnoremap k gk
" Rebuild Ctags (mnemonic RC -> CR -> <cr>)
nnoremap <leader><c> :silent !myctags<cr>:redraw!<cr>)
"kill trailing whitespace
nnoremap <silent> <Leader>dw :keeppatterns %s/\s\+$//<CR>
" Fugitive {{{
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

"FZF goodies
nnoremap <C-p> :FZF<cr>
" fzf colorscheme selector
nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

" fzf buffer selector
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" sane word processing settings
func! WordProcessorMode()
  setlocal formatoptions=1
  setlocal noexpandtab
  setlocal spell spelllang=en_us
  set complete+=s
  set formatprg=par
  setlocal wrap
  setlocal linebreak
endfu
com! WP call WordProcessorMode()
