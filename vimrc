set nocompatible " not vi compatible

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.vim/plugged')

" File searching
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'

" Find and Replace
Plug 'mhinz/vim-grepper'

" Coding Sanity
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-multiple-cursors'

" Shell Sanity
Plug 'pbrisbin/vim-mkdir'

" - Code Commenting
Plug 'preservim/nerdcommenter'

" - Automatic adjusting of editor settings (tabs vs spaces etc.)
Plug 'tpope/vim-sleuth'
Plug 'editorconfig/editorconfig-vim'

" VIM Enhancements
Plug 'ciaranm/securemodelines'
Plug 'justinmk/vim-sneak'

" GUI Enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" Git help
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Language Intellisense
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() }}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-eslint', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier', 'coc-yaml', 'coc-rls', 'coc-highlight', 'coc-jest', 'coc-rust-analyzer']

" Rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml' " Currently no coc related toml file

" Javascript & Typescript
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" === Trialing ===
Plug 'Shougo/vimproc.vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'davidpdrsn/vim-notable'
Plug 'davidpdrsn/vim-spectacular'

Plug 'jparise/vim-graphql'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'SirVer/ultisnips'

Plug 'nanotech/jellybeans.vim'

Plug 'oknozor/illumination', { 'dir': '~/.illumination', 'do': '.install.sh' }

call plug#end()

" ==============================
" ===           FZF          ===
" ==============================


let $FZF_DEFAULT_COMMAND = "rg --files --no-ignore-vcs | rg -v \"(^|/)target/\""

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'options': '--tiebreak=index'}, <bang>0)

source ~/.vim/functions.vim

" ==============================
" ===    GENERAL SETTINGS    ===
" ==============================

filetype plugin indent on         " Enable good stuff
syntax enable                     " Enable syntax highlighting

color jellybeans

set updatetime=250

set fillchars+=vert:\             " Don't show pipes in vertical splits
set hidden                        " Don't unload buffers when leaving them 
set spell                         " Set spell checking to true 
set spelllang=en_us               " Use English US for spell checking
set lazyredraw                    " Don't redraw screen while running macros
set scrolljump=5                  " Scroll more than one line
set scrolloff=3                   " Minimum lines to keep above or below the cursor when scrolling
set nojoinspaces                  " Insert only one space when joining lines that contain sentence-terminating punctuation like `.`.
set splitbelow                    " Open splits below
set splitright                    " Open splits to the right
set timeout                       " Lower the delay of escaping out of other modes
set visualbell                    " Disable annoying beep
set wildmenu                      " Enable command-line like completion
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set wrap                          " Wrap long lines

" UI
set laststatus=2                  " Always show the status line
set linebreak                     " Don't break lines in the middle of words
set list                          " Show some more characters
set listchars=tab:▸\              " Char representing a tab
set listchars+=extends:❯          " Char representing an extending line
set listchars+=nbsp:␣             " Non breaking space
set listchars+=precedes:❮         " Char representing an extending line in the other direction
set listchars+=trail:·            " Show trailing spaces as dots
set nocursorcolumn                " Don't highlight the current column
set cursorline                    " Highlight the current line
set number                        " Don't show line numbers
set numberwidth=4                 " The width of the number column
set relativenumber                " Show relative numbers
set guifont=Input\ Mono:h11       " Set GUI font
set guioptions-=T                 " No tool bar in MacVim
set guioptions-=r                 " Also no scrollbar
set guioptions-=L                 " Really no scrollbar
set signcolumn=yes
set cmdheight=1
set conceallevel=0
set textwidth=80

highlight TermCursor ctermfg=red guifg=red

" searching
set hlsearch                      " Highlight search matches
set ignorecase                    " Do case insensitive search unless there are capital letters
set incsearch                     " Perform incremental searching
set smartcase

" backups & undo
set noswapfile
set history=2500                  " Sets how many lines of history Vim has to remember
set undolevels=1000               " How many steps of undo history Vim should remember
set writebackup
set undodir=~/.vimdid
set undofile

" indentation
set noexpandtab                   " Indent with tabs
set shiftwidth=2                  " Number of spaces to use when indenting
set smartindent                   " Auto indent new lines
set softtabstop=2                 " Number of spaces a <tab> counts for when inserting
set tabstop=2                     " Number of spaces a <tab> counts for

" folds
set foldenable                    " Enable folds
set foldlevelstart=99             " Open all folds by default
set foldmethod=indent             " Fold by indentation

" ==============================
" ===      AUTO-COMMANDS     ===
" ==============================

augroup resumeCursorPosition
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

augroup miscGroup
  autocmd!

  " somehow this is required to move the gray color of the sign column
  autocmd FileType * highlight clear SignColumn

  " when in a git commit buffer go the beginning
  autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " save files when focus is lost
  autocmd BufLeave * silent! update

  " always have quickfix window take up all the horizontal space
  autocmd FileType qf wincmd J

  " configure indentation for python
  autocmd FileType python set expandtab tabstop=4 softtabstop=4 shiftwidth=4

  " configure indentation for python
  autocmd FileType rust set expandtab tabstop=4 softtabstop=4 shiftwidth=4

  " Disable spell checking in vim help files
  autocmd FileType help set nospell

  " Fasto setup
  autocmd BufNewFile,BufRead *.fo setlocal ft=fasto

  " Janus setup
  autocmd BufNewFile,BufRead *.ja setlocal ft=janus

  " C setup, Vim thinks .h is C++
  autocmd BufNewFile,BufRead *.h setlocal ft=c

  " C setup, Vim thinks .h is C++
  autocmd BufNewFile,BufRead /private/tmp/* set filetype=markdown

  " Pow setup
  autocmd BufNewFile,BufRead *.pow setlocal ft=pow
  autocmd FileType pow set commentstring={{\ %s\ }}

  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  autocmd FileType rust set colorcolumn=9999

  autocmd FileType markdown let &makeprg='proselint %'

  autocmd BufEnter,FocusGained * checktime

  autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/

  autocmd FileType rust nnoremap <buffer> <cr> :w<cr>:RustFmt<cr>:w<cr>
augroup END

augroup neorun
  autocmd!
  autocmd TermClose * :call TerminalOnTermClose(0+expand('<abuf>'))
augroup end

" ==============================
" ===        MAPPINGS        ===
" ==============================

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Resize windows with the arrow keys
nnoremap <up> 10<C-W>+
nnoremap <down> 10<C-W>-
nnoremap <left> 3<C-W>>
nnoremap <right> 3<C-W><

nmap <leader>w :w<CR>                  " Easy Save
nnoremap <leader><leader> <c-^>        " Quick Toggle between buffers

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" No arrow keys --- force yourself to use the home row
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" fzf
" Shortcuts for commonly used searches 
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>
noremap <leader>s :Rg

" insert path to current file
" in command (:) mode
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" correct spelling from insert mode by hitting CTRL-l
inoremap <c-l> <esc>:call CorrectSpelling()<cr>a

" Git Fugitive
set tags^=.git/tags;~
nmap <leader>gs :G<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nnoremap <leader>gc :Gcommit -v<cr>
nnoremap <leader>gp :Gpush<cr>

" Vim Grepper

let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Make terminal mode behave more like any other mode
tnoremap <C-[> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <A-k> <C-\><C-n><C-W>+i
tnoremap <A-j> <C-\><C-n><C-W>-i
tnoremap <A-h> <C-\><C-n>3<C-W>>i
tnoremap <A-l> <C-\><C-n>3<C-W><i

nnoremap <leader>W :wq<cr>                         " Save and quit
nnoremap <leader>a :call YankWholeBuffer(0)<cr>
nnoremap <leader>p :call PasteFromSystemClipBoard()<cr>

nnoremap <leader>J :call GotoDefinitionInSplit(1)<cr>
nnoremap <leader>O :!open %<cr><cr>
nnoremap <leader>j :call GotoDefinitionInSplit(0)<cr>

nnoremap <leader>t :w<cr>:call spectacular#run_tests()<cr>
nnoremap <leader>k :w<cr>:call spectacular#run_tests_with_current_line()<cr>

nnoremap <leader>rf :call RenameFile()<cr>
nnoremap <leader>sb :call notable#open_notes_file()<cr>

nnoremap <leader>st :sp term://zsh<cr>
nnoremap <leader>z :call CorrectSpelling()<cr>

" COC Language Servers

nnoremap <leader>la :CocCommand actions.open<cr>

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>sy  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" tmux
nmap <leader>v :normal V<cr><Plug>SendSelectionToTmux
vmap <leader>v <Plug>SendSelectionToTmux
nmap <leader>V <Plug>SetTmuxVars

" ==============================
" ===    MISC PLUGIN VARS    ===
" ==============================

let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetDirectories = ["ultisnips"]

let g:multi_cursor_exit_from_visual_mode = 0

let g:spectacular_use_terminal_emulator = 1
let g:spectacular_debugging_mode = 0

let g:notable_notes_folder = "~/notes/"

" Hack to make CTRL-h work in Neovim
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'enable': {
  \   'statusline': 1,
  \   'tabline': 0
  \ },
  \ 'active': {
  \   'right': [[ 'lineinfo' ]],
  \   'left': [[ 'mode', 'paste' ],
  \            [ 'readonly', 'relativepath', 'gitbranch', 'modified', 'cocstatus' ]]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head',
  \   'cocstatus': 'coc#status',
  \ },
  \ 'component_expand': {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'cocstatus': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \ }
  \ }

let g:rustfmt_command = "rustfmt"
let g:rustfmt_autosave=1     
let g:highlightedyank_highlight_duration = 170

let g:diminactive_enable_focus = 1
let g:diminactive_use_colorcolumn = 1
let g:diminactive_use_syntax = 0

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Follow Rust code style rules
au Filetype rust set colorcolumn=100

" Crate information
if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif
 
" ==============================
" ===      TEST RUNNING      ===
" ==============================

call spectacular#reset()

call spectacular#add_test_runner(
      \ 'ruby, javascript, eruby, coffee, haml, yml',
      \ ':call SmartRun("rspec {spec}")',
      \ ''
      \ )

call spectacular#add_test_runner(
      \ 'ruby, javascript, eruby, coffee, haml, yml',
      \ ':call SmartRun("rspec {spec}:{line-number}")',
      \ ''
      \ )

call spectacular#add_test_runner(
      \ 'rust, pest, toml, cfg, ron, graphql',
      \ ':call SmartRun("cargo check --tests")',
      \ '.rs'
      \ )

" ==============================
" ===  LOCAL CUSTOMIZATIONS  ===
" ==============================

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
