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
set tabstop=2
set shiftwidth=2
set softtabstop=2
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

Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'davidhalter/jedi-vim'
Plugin 'gmarik/vundle'
Plugin 'Valloric/MatchTagAlways'
Plugin 'junegunn/fzf'
Plugin 'junegunn/goyo.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'leafgarland/typescript-vim'
Plugin 'mbbill/undotree'
Plugin 'nvie/vim-flake8'
Plugin 'elzr/vim-json'
Plugin 'mattn/emmet-vim'
Plugin 'quramy/tsuquyomi'
Plugin 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'yaml', 'html'] }
Plugin 'raimondi/delimitMate'
Plugin 'reedes/vim-pencil'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tComment'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vimwiki/vimwiki'

call vundle#end()

let g:user_emmet_leader_key='<C-Z>'
"airline symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = "onedark"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
"YouCompleteMe
let g:ycm_server_python_interpreter="/usr/bin/python3.7"
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^', 're!^\s+', ': ' ],
    \   'scss': [ 're!^', 're!^\s+', ': ' ],
    \ }
" Plugin key-mappings.
" UltiSnips
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" Undotree
if has('persistent_undo')
    nnoremap <silent> <Space>u :UndotreeToggle<CR>
    let g:undotree_SetFocusWhenToggle = 1
    set undofile
    set undodir=~/.vim/undodir/
    set undolevels=1000
    set undoreload=10000
endif
" always jump to the last cursor position
autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif
"Pencil
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType vimwiki      call pencil#init()
  autocmd FileType text         call pencil#init({'wrap': 'hard'})
augroup END"


au BufNewFile,BufRead *.py
    \ set textwidth=79 |
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set fileformat=unix

au BufNewFile,BufRead,BufWrite *.js
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
autocmd FileType typescript
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2

augroup typescript_key_mapping
  autocmd FileType typescript nmap <buffer> <Leader>r  <Plug>(TsuquyomiRenameSymbol)
  autocmd FileType typescript nmap <buffer> <Leader>E  <Plug>(TsuquyomiRenameSymbolC)
  autocmd FileType typescript nmap <buffer> <Leader>ii <Plug>(TsuquyomiImport)
  autocmd FileType typescript nmap <buffer> <Leader>qf <Plug>(TsuquyomiQuickFix)
  autocmd FileType typescript nmap <buffer> <Leader>t :<C-u>echo tsuquyomi#hint()<CR>
augroup END
autocmd BufRead,BufNewFile,BufWrite *.ts set ft=typescript
autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell     " width, mail syntax hilight, spellcheck

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0
" Extra text objects!
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

"Tsuquyomi config
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

"mapping ------------------------------------------------------------------------
"mdless preview
nmap <silent><Leader>m :!mdless %:p<CR>
"spellcheck
nmap <silent> <leader>s :set spell!<CR>
" paragraph formatting
map <Leader>P gqap
" F-keys
nnoremap <Space> <Leader>
set pastetoggle=<F2>
nnoremap <F3> :Lexplore<CR>
nnoremap <F5> :r! date "+\%d-\%m-\%Y \%H:\%M:\%S"<CR>
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
"Goyo
nnoremap <Leader>G :Goyo<CR>
"up and down on wraps
nnoremap j gj
nnoremap k gk
"kill trailing whitespace
nnoremap <silent> <Leader>dw :keeppatterns %s/\s\+$//<CR>
" Fugitive & GitGutter {{{
let g:gitgutter_enabled = 0
nnoremap <Leader>g :GitGutterToggle<cr>
nnoremap <C-n> :GitGutterNextHunk<CR>
nnoremap <C-p> :GitGutterPrevHunk<CR>
nnoremap <C-u> :GitGutterUndoHunk<CR>
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
