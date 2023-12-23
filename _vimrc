"  ~/.vimrc
"
" amelxmx [at] gmail [dot] com
"

syntax on                   "self explanatory
filetype plugin on          "loads things based on document type
filetype plugin indent on   "new smartindent
let mapleader=" "
let maplocalleader="\\"
set backupdir=~/.vim/backup " Keep backups in ~/.vim/backup
set directory=~/.vim/temp   " Keep temp files in ~/.vim/temp
set hidden                  "allow scrolling between unsaved buffers
set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
set grepformat=%f:%l:%c%m
let g:tex_flavor = "latex"
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
set noshowmode
set undofile
set undodir=~/.vim/undodir
"fzf
set rtp+=~/.fzf
let g:loaded_matchparen = 1
let g:acp_behaviorKeywordLength = 4
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path':'~/Nextcloud/vimwiki',
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
Plugin 'fatih/vim-go'
Plugin 'mbbill/undotree'
Plugin 'mattn/emmet-vim'
Plugin 'honza/vim-snippets'
Plugin 'tComment'
Plugin 'tpope/vim-fugitive'
Plugin 'vimwiki/vimwiki'
Plugin 'thaerkh/vim-workspace'
Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plugin 'neoclide/coc.nvim'
Plugin 'windwp/nvim-autopairs'
Plugin 'lukas-reineke/indent-blankline.nvim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'EdenEast/nightfox.nvim'
Plugin 'nvim-tree/nvim-tree.lua'

call vundle#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
vim.g.markdown_fenced_languages = {'html', 'js=javascript', 'ts=typescript', 'bash=sh'}
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_respect_buf_cwd = 1

require("ibl").setup({
  scope = enabled,
  indent = { char = "▏" },
})
require("nvim-tree").setup({
  view = {
    width = 60,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
})
require("nvim-autopairs").setup()
require("nightfox").setup({
 options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})
vim.cmd("colorscheme nightfox")
EOF

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \  'coc-snippets',
  \  'coc-angular',
  \  'coc-go',
  \  'coc-json'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
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
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:user_emmet_leader_key='<C-Z>'

let g:airline_powerline_fonts = 1
let g:airline_theme = "night_owl"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

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

au BufNewFile,BufRead,BufWrite *.js
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

autocmd FileType typescript
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2

autocmd BufEnter,BufRead,BufNewFile,BufWrite *.ts set ft=typescript
autocmd BufEnter,BufRead,BufNewFile,BufWrite *.md set tw=80
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufRead ~/.mutt/temp/mutt-* set tw=80 ft=mail nocindent spell     " width, mail syntax highlight, spellcheck

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
nmap <silent> <leader>s :set spell!<CR>  " spell check

"workspace
nnoremap <leader>S :ToggleWorkspace<CR> " manage sessions
let g:workspace_autosave_always = 0
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
nnoremap <silent> <Leader>f :Ag .<CR>
" paragraph formatting
map <Leader>P gqap
nnoremap <Leader>tt :Prettier<CR>
" F-keys
nnoremap <Space> <Leader>
set pastetoggle=<F2>
nnoremap <leader>T :NvimTreeToggle<CR>
nnoremap <F5> :r! date "+\%d-\%m-\%Y \%H:\%M:\%S"<CR>
"buffers
nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bp<CR>
"indentation
vnoremap < <gv
vnoremap > >gv
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
" Allows writing to files with root privileges
cmap w!! w !sudo tee % > /dev/null
nnoremap <Leader>G :Goyo<CR>
"up and down on wraps
nnoremap j gj
nnoremap k gk
" Fugitive & GitGutter {{{
let g:gitgutter_enabled = 1
nnoremap <Leader>g :GitGutterToggle<cr>
nnoremap <leader>diff :Gdiff<cr>
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Git add .<cr>
nnoremap <leader>gb :Git branch<space>
nnoremap <leader>gco :Git checkout<space>
nnoremap <leader>gci :Git commit<cr>
nnoremap <leader>gm :Gmove<space>
nnoremap <leader>gr :Gremove<space>
"FZF goodies
nnoremap <C-p> :Files<cr>
nnoremap <silent> <Leader><Enter> :Buffers<cr>
nnoremap <silent> <Leader>l :Lines<cr>

