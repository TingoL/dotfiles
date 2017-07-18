"  ~/.vimrc
" author  : TingoL
" amelxmx [at] gmail [dot] com
syntax on                   "self explanatory
filetype plugin on          "loads things based on document type
filetype plugin indent on   "new smartindent
colorscheme euphrasia

let mapleader=" "
let maplocalleader="\\"
set backupdir=~/.vim/backup " Keep backups in ~/.vim/backup
set directory=~/.vim/temp   " Keep temp files in ~/.vim/temp
set hidden                  "allow scrolling between unsaved buffers
set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
set grepformat=%f:%l:%c%m
let g:tex_flavor = "latex"
set scrolloff=2             " 2 lines above/below cursor when scrolling
set foldmethod=manual
set relativenumber
set number                 " show line numbers
set lazyredraw
set wildmenu               " enhanced tab-completion shows all matching cmds in a popup menu
set regexpengine=1         " needed for jsctags
set clipboard=unnamed      " yank to X clipboard
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
set undofile
set undodir=~/.vim/undodir
set noesckeys              "fixes delay after O
"fzf
set rtp+=~/.fzf
let g:loaded_matchparen = 1
let g:acp_behaviorKeywordLength = 4
let g:vimwiki_list = [{'path':'~/Dropbox/vimwiki',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
autocmd QuickFixCmdPost *grep* cwindow

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
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'tComment'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'vimwiki/vimwiki'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'junegunn/fzf'
Plugin 'mbbill/undotree'
Plugin 'justinmk/vim-sneak'
Plugin 'sunaku/vim-dasht'
Plugin 'airblade/vim-gitgutter'
Plugin 'chrisbra/vim-autosave'
Plugin 'gregsexton/MatchTag'
Plugin 'skammer/vim-css-color'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'

call vundle#end()
"C-y for digraphs since C-k is taken by neosnippet
inoremap <C-y> <C-k>
"dasht integration
"Search API docs for query you type in:
nnoremap <Leader>k :Dasht<Space>
" Search API docs for word under cursor:
nnoremap <silent> <Leader>K :call Dasht(expand('<cword>'))<Return>
" Search API docs for the selected text:
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>
"pandoc markdwown spelling off by default
let g:pandoc#spell#enabled = 0
"js-libs-syntax
let g:used_javascript_libs = 'jquery,angularjs'
"airline symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = "base16_eighties"
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
" Plugin key-mappings.
imap <C-l>     <Plug>(neosnippet_expand_or_jump)
smap <C-l>     <Plug>(neosnippet_expand_or_jump)
xmap <C-l>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
 imap <expr><TAB> neosnippet#expandable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" Undotree
if has('persistent_undo')
    nnoremap <silent> <Space>u :UndotreeToggle<CR>
    let g:undotree_SetFocusWhenToggle = 1
    set undofile
    set undodir=~/.vim/undodir/
    set undolevels=1000
    set undoreload=10000
endif
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/UltiSnips'
" always jump to the last cursor position
autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif


au BufNewFile,BufRead *.py
    \ set textwidth=79 |
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
autocmd BufRead,BufNewFile,BufWrite *.txt,*.md,*.mkd set tw=80 ft=pandoc  " limit width to n cols for txt files
autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell     " width, mail syntax hilight, spellcheck
"
" Enable omni completion.
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#auto_vim_configuration = 0
    let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'
" Extra text objects!
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

"mapping ------------------------------------------------------------------------
"mdless preview
nmap <silent><Leader>m :!mdless %:p<CR>
"spellcheck
nmap <silent> <leader>s :set spell!<CR>
" paragraph formatting
map <Leader>p gqap
" F-keys
nnoremap <Space> <Leader>
set pastetoggle=<F2>
nnoremap <F3> :Lexplore<CR>
nnoremap <F4> :UndotreeToggle<CR>
nnoremap <F5> :r! date "+\%d-\%m-\%Y \%H:\%M:\%S"<CR>
nnoremap <F6> :TagbarToggle<CR>
"buffers
nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bp<CR>
"splits
nnoremap <expr><silent> \| !v:count ? "<C-W>v<C-W><Right>" : '\|'
nnoremap <expr><silent> _  !v:count ? "<C-W>s<C-W><Down>"  : '_'
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
" Fugitive & GitGutter {{{
let g:gitgutter_enabled = 0
nnoremap <Leader>g :GitGutterToggle<cr>
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

"netrw as nerdtree replacement
nnoremap - :exe 'Lexplore' expand('%:h')<CR>
let g:netrw_winsize=25
let g:netrw_liststyle=3
