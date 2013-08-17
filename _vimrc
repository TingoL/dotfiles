"
"  ~/.vimrc
" author  : TingoL 
" amelxmx [at] gmail [dot] com
"
set nocompatible
syntax on
filetype plugin on
colorscheme euphrasia

let mapleader=" "
let maplocalleader="\\"
set backupdir=~/.vim/backup " Keep backups in ~/.vim/backup
set directory=~/.vim/temp   " Keep temp files in ~/.vim/temp
set hidden                 " allow scrolling between unsaved buffers
set nobackup               " disable backup files (filename~)
set relativenumber
set number                 " show line numbers
set lazyredraw
set wildmenu               " enhanced tab-completion shows all matching cmds in a popup menu
set clipboard=unnamed      " yank to X clipboard
set pastetoggle=<F2>
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set showmatch              " show matching brackets
set nohlsearch             " Do not highlight the string we searched.
set incsearch              " increment search
set ignorecase             " case-insensitive search
set smartcase              " uppercase causes case-sensitive search
"set runtimepath=~/.vim,/vimfiles,
let g:loaded_matchparen = 1
let g:acp_behaviorKeywordLength = 4
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
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-markdown' 
Bundle "Raimondi/delimitMate"
Bundle "tpope/vim-fugitive"
Bundle 'tComment'
Bundle "godlygeek/tabular"
Bundle "dhruvasagar/vim-table-mode"
Bundle "majutsushi/tagbar"
Bundle "scrooloose/syntastic"
Bundle "Shougo/neosnippet"
Bundle "Shougo/neocomplcache.vim"

"airline symbols
let g:airline_left_sep='▶'
let g:airline_right_sep='◀'
"neocomplcache magic
let g:acp_enableAtStartup = 0                                   " Disable AutoComplPop.
let g:neocomplcache_enable_at_startup = 1                       " Use neocomplcache.
let g:neocomplcache_enable_smart_case = 1                       " Use smartcase.
let g:neocomplcache_min_syntax_length = 3                       " Set minimum syntax keyword length.
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
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/UltiSnips'
"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

if has("autocmd")
    " always jump to the last cursor position
    "
autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

autocmd BufRead,BufNewFile *.txt set tw=80                                         " limit width to n cols for txt files
autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
autocmd FileType tex set tw=80                                          " wrap at 80 chars for LaTeX files
	    autocmd FileType html setlocal shiftwidth=2 tabstop=2
	    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 omnifunc=pythoncomplete#Complete
	    "let g:pydiction_location = '/usr/share/pydiction/complete-dict'
endif

"mapping
"Ack
nmap <leader>a <Esc>:Ack!
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
" use ctrl-t to open file in a new tab
map <c-t> :call DmenuOpen("tabe")<cr>
" use ctrl-f to open file in current buffer
map <c-f> :call DmenuOpen("e")<cr>

function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
  endfunction

function! DmenuOpen(cmd)
    let fname = Chomp(system("find | dmenu -i -l 20 -p " . a:cmd))
    if empty(fname)
      return
        endif
          execute a:cmd . " " . fname
          endfunction
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
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
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
" augroup ft_html
"     au!
" 
"     au BufNewFile,BufRead *.html setlocal filetype=htmldjango
"     au BufNewFile,BufRead *.dram setlocal filetype=htmldjango
" 
"     au FileType html,jinja,htmldjango setlocal foldmethod=manual
"     " Use <localleader>f to fold the current tag.
"     au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf
"     " Use <localleader>t to fold the current templatetag.
"     au FileType html,jinja,htmldjango nmap <buffer> <localleader>t viikojozf
"     " Indent tag
"     au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>= Vat=
"     " Django tags
"     au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>
"     " Django variables
"     au FileType jinja,htmldjango inoremap <buffer> <c-b> {{<space><space>}}<left><left><left>
" augroup END
" 
" " }}}
" Markdown {{{

augroup ft_markdown
    au!

    au BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1

    " Use <localleader>1/2/3 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space>`zllll <ESC>
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
