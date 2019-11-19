""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" get plugin manager if we don't already have it
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
 silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'w0rp/ale'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'junegunn/fzf.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This ensures all virtual envs have access to flake8 & black
" let g:python3_host_prog = '/Users/jasonadam/.local/share/virtualenvs/nvim-kCTaSSN-/bin/python'

syntax on
set number
set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start
set mouse=a
let mapleader = " "

" Tab & Indent Config
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Ignore case when searching
set ignorecase
set smartcase

" General Usability
set scrolloff=5
set autoindent
set clipboard=unnamedplus

" Search will center on line if found
nnoremap n nzzzv
nnoremap N Nzzzv

" JSON formatting
command! -nargs=0 Json :exe "norm :%!jq\<Return>"

" escape from the home row
inoremap fd <ESC>
vnoremap fd <ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open NT when vim opens
autocmd vimenter * NERDTree

" Map toggle
nnoremap <LEADER>tt :NERDTreeTabsToggle <CR>
vnoremap <LEADER>tt :NERDTreeTabsToggle <CR>

let NERDTreeMinimalUI = 1       " hide help string
let NERDTreeShowLineNumbers = 0 " hide line numbers

" Automatically find and select currently opened file in NERDTree.
let g:nerdtree_tabs_autofind = 1

" Close vim if NT only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dracula
colorscheme dracula

" Airline
let g:airline_theme = 'dracula'
let g:airline#extensions#ale#enabled     = 1
let g:airline#extensions#coc#enabled     = 1

" True Color Support
set termguicolors

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_set_quickfix = 1
let g:ale_virtualtext_cursor = 1
let g:ale_warn_about_trailing_blank_lines = 0

let g:ale_linters = {
                \ 'python': ['flake8', 'mypy'],
                \ 'sh': ['language_server'],
                \ }

let g:ale_fixers = {
            \ '*': ['trim_whitespace'],
            \ 'c': ['trim_whitespace', 'clang-format', 'clangtidy'],
            \ 'go': ['trim whitespace', 'goimports'],
            \ 'python': ['black', 'isort'],
            \ }

let g:ale_python_flake8_options    = '--max-line-length=120'
let g:ale_python_black_options     = '--line-length 120'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc Nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set nobackup
set nowritebackup
set shortmess+=c
set signcolumn=yes

inoremap <silent> <expr><Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <silent> <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-p>"
inoremap <silent> <expr> <C-Space> coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" auto close scratch/preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_highlight_functions         = 1
let g:go_highlight_function_calls    = 1
let g:go_highlight_methods           = 1
let g:go_highlight_types             = 1
let g:go_highlight_fields            = 1
let g:go_highlight_operators         = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags     = 1
let g:go_highlight_debug             = 1
let g:go_fmt_command = 'goimports'
let g:go_auto_type_info = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Formatting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup yaml_files
    autocmd!
    au BufRead,BufNewFile *.yml setfiletype yaml
    au FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup make_files
    autocmd!
    au FileType make setlocal noexpandtab
augroup END

augroup docker_files
    autocmd!
    au BufRead,BufNewFile Dockerfile.* set syntax=Dockerfile
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = {'down': '20%'}

" search filenames
nmap <LEADER>ff :Files <CR>

" search tags in current buffer
nmap <LEADER>ft :BTags <CR>

" search tags in the project
nmap <LEADER>fT :Tags <CR>

" search lines in current buffer
nmap <LEADER>fl :BLines <CR>

" search lines in loaded buffers
nmap <LEADER>fL :Lines <CR>

" ripgrep search results
nmap <LEADER>fr :Rg <CR>

" another alias for ripgrep
nmap <LEADER>rg :Rg <CR>
