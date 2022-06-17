"  ~/.vimr
" author  : TingoL
" amelxmx [at] gmail [dot] com
"

syntax on                   "self explanatory
filetype plugin on          "loads things based on document type
filetype plugin indent on   "new smartindent
colorscheme one
let mapleader=" "
let maplocalleader="\\"
set backupdir=~/.vim/backup " Keep backups in ~/.vim/backup
set directory=~/.vim/temp   " Keep temp files in ~/.vim/temp
set hidden                  "allow scrolling between unsaved buffers
set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
set grepformat=%f:%l:%c%m
let g:tex_flavor = "latex"
set
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set relativenumber
set number                 " show line numbers
set lazyredraw
set termguicolors
set wildmenu               " enhanced tab-completion shows all matching cmds in a popup menu
set regexpengine=1         " needed for jsctags
set clipboard+=unnamed      " yank to X clipboard
set autoindent
set smartindent
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
"fzf
set rtp+=~/.fzf
let g:loaded_matchparen = 1
let g:acp_behaviorKeywordLength = 4
let g:vimwiki_list = [{'path':'~/Dropbox/vimwiki',
                       \ 'syntax': 'markdown', 'ext': '.md',
                       \'template_path': '~/.vim/bundle/vimwiki/autoload/vimwiki/default.tpl'}]

autocmd QuickFixCmdPost *grep* cwindow
autocmd BufReadPost,FileReadPost * normal zR

" status bar
set statusline=\ \%F%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\
set laststatus=2
set cmdheight=1
set encoding=utf-8

" vundle bundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'leafgarland/typescript-vim'
Plugin 'mbbill/undotree'
Plugin 'mattn/emmet-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'reedes/vim-pencil'
Plugin 'preservim/vim-wordy'
Plugin 'honza/vim-snippets'
Plugin 'tComment'
Plugin 'tpope/vim-fugitive'
Plugin 'vimwiki/vimwiki'
Plugin 'thaerkh/vim-workspace'
Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plugin 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plugin 'neoclide/coc.nvim'
Plugin 'lukas-reineke/indent-blankline.nvim'
Plugin 'ryanoasis/vim-devicons'


call vundle#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintaned",
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF

"Coc settings
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \  'coc-snippets',
  \  'coc-json'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>sy :<C-u>CocList -I symbols<cr>
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:user_emmet_leader_key='<C-Z>'
"airline symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = "onedark"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" Plugin key-mappings.
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

autocmd BufRead,BufNewFile,BufWrite *.ts set ft=typescript
autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell     " width, mail syntax hilight, spellcheck

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" Extra text objects!
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

"mapping ------------------------------------------------------------------------
nmap <silent> <leader>s :set spell!<CR> 	" spell check

"workspace
nnoremap <leader>S :ToggleWorkspace<CR>		" manage sessions
let g:workspace_autosave_always = 1
let g:workspace_session_directory = $HOME . '/.vim/sessions/'

" paragraph formatting
map <Leader>P gqap
" F-keys
nnoremap <Space> <Leader>
set pastetoggle=<F2>
nnoremap <leader>f <cmd>CHADopen<cr>
nnoremap <F5> :r! date "+\%d-\%m-\%Y \%H:\%M:\%S"<CR>
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
"Goyo
nnoremap <Leader>G :Goyo<CR>
"up and down on wraps
nnoremap j gj
nnoremap k gk
" Rebuild Ctags
nnoremap <leader>ct :silent !ctags -R --exclude=@.ctagsignore .<cr>:redraw!<cr>
" Fugitive & GitGutter {{{
let g:gitgutter_enabled = 1
nnoremap <Leader>g :GitGutterToggle<cr>
nnoremap <C-n> :GitGutterNextHunk<CR>
nnoremap <C-p> :GitGutterPrevHunk<CR>
nnoremap <C-u> :GitGutterUndoHunk<CR>
nnoremap <leader>gd :Git diff<cr>
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Git add<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Git commit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
"FZF goodies
nnoremap <C-p> :Files<cr>
" fzf colorscheme selector
nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>
nnoremap <silent> <Leader><Enter> :Buffers<cr>
nnoremap <silent> <Leader>l :Lines<cr>
