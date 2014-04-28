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
set scrolloff=2             " 2 lines above/below cursor when scrolling
set foldmethod=manual
set relativenumber
set number                 " show line numbers
set lazyredraw
set wildmenu               " enhanced tab-completion shows all matching cmds in a popup menu
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
" set runtimepath=~/.vim,/vimfiles,
let g:loaded_matchparen = 1
let g:acp_behaviorKeywordLength = 4
let g:vimwiki_list = [{'path':'~/Dropbox/vimwiki'}]

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" status bar
set statusline=\ \%F%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ 
set laststatus=2
set cmdheight=1
set encoding=utf-8
"pdf reader
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw118

" vundle bundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'chrisbra/csv.vim'
Plugin 'tpope/vim-markdown'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'tComment'
Plugin 'godlygeek/tabular'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/seoul256.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neocomplcache.vim'

call vundle#end()
filetype plugin indent on   "new smartindent 

"airline symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = "badwolf"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
"seoul colors
let g:seoul256_background = 234
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
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" " Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/UltiSnips'

" always jump to the last cursor position
autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

autocmd BufRead,BufNewFile *.txt set tw=80                                         " limit width to n cols for txt files
autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
autocmd FileType tex set tw=80                                          " wrap at 80 chars for LaTeX files
autocmd FileType html setlocal shiftwidth=2 tabstop=2
" Enable omni completion.
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
let g:pydiction_location = '/usr/share/pydiction/complete-dict'

"mapping ------------------------------------------------------------------------

"spellcheck
nmap <silent> <leader>s :set spell!<CR>
" paragraph formatting
map <Leader>p gqap
" F-keys
nnoremap <F3> :NERDTreeToggle<CR>
nmap <silent> <F4> :call NumberToggle()<CR>
nnoremap <Space> <Leader>
nnoremap <F6> :TagbarToggle<CR>
"cycle through windows with one key combo
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-l> <C-w>l
map <C-h> <C-w>h
"tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
"buffers
nnoremap <PageUp>   :bp<CR>
nnoremap <PageDown> :bn<CR>
"bubbles
nmap <C-Up> ddkP
nmap <C-Down> ddp
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]
"sorting
vnoremap <Leader>s :sort<CR>
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
nnoremap <leader><cr> :silent !myctags<cr>:redraw!<cr>)
" Easy filetype switching {{{
nnoremap _md :set ft=markdown<CR>
nnoremap _hd :set ft=htmldjango<CR>
nnoremap _jt :set ft=htmljinja<CR>
nnoremap _js :set ft=javascript<CR>
nnoremap _cw :set ft=confluencewiki<CR>
nnoremap _pd :set ft=python.django<CR>
nnoremap _d  :set ft=diff<CR>
" }}}
" Quick editing ----------------------------------------------------------- {{{
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
" }}}
" Django {{{

augroup ft_django
    au!

    au BufNewFile,BufRead urls.py           setlocal nowrap
    au BufNewFile,BufRead urls.py           normal! zR
    au BufNewFile,BufRead dashboard.py      normal! zR
    au BufNewFile,BufRead local_settings.py normal! zR

    au BufNewFile,BufRead admin.py     setlocal filetype=python.django
    au BufNewFile,BufRead urls.py      setlocal filetype=python.django
    au BufNewFile,BufRead models.py    setlocal filetype=python.django
    au BufNewFile,BufRead views.py     setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal foldmethod=marker
    au BufNewFile,BufRead forms.py     setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal foldmethod=marker
augroup END

" }}}
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
"NERDTree
let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                    \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                    \ '.*\.o$', 'db.db', 'tags.bak', '.*\.pdf$', '.*\.mid$',
                    \ '.*\.midi$']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeMapJumpFirstChild = 'gK'

" Use Ranger as a file explorer {{{

fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
map <Leader>x :call RangerChooser()<CR>
" }}}

