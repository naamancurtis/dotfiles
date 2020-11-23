set nocompatible " not vi compatible

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

let mapleader = "\<Space>"
nnoremap <leader>svf :source $MYVIMRC<CR>
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
" Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
 
" Shell Sanity
Plug 'pbrisbin/vim-mkdir'

" - Code Commenting
Plug 'preservim/nerdcommenter'

" - Automatic adjusting of editor settings (tabs vs spaces etc.)
Plug 'tpope/vim-sleuth'
Plug 'editorconfig/editorconfig-vim'
Plug 'ciaranm/securemodelines'

" VIM Enhancements
Plug 'justinmk/vim-sneak'

" GUI Enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" Git help
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Language Intellisense
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() }}
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml' " Currently no coc related toml file
Plug 'mhinz/vim-crates'

" Javascript & Typescript
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'

" === Trialing ===
Plug 'Shougo/vimproc.vim'

Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'davidpdrsn/vim-notable'
Plug 'davidpdrsn/vim-spectacular'

Plug 'jparise/vim-graphql'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'

Plug 'sainnhe/edge' " Color Scheme

call plug#end()

" ==============================
" ===    GENERAL SETTINGS    ===
" ==============================

filetype plugin indent on         " Enable good stuff
syntax enable                     " Enable syntax highlighting

" Color Scheme
let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1

let g:python3_host_prog = '/usr/local/opt/python@3.8/bin/python3.8'
set termguicolors
colorscheme edge

set updatetime=250

set fillchars+=vert:\             " Don't show pipes in vertical splits
set hidden                        " Don't unload buffers when leaving them 
set nospell                       " Set spell checking to false by default
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

" mouse
set mouse=a

set t_ZH=^[[3m
set t_ZR=^[[23m

source ~/.vim/functions.vim

" ==============================
" ===           FZF          ===
" ==============================

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --no-ignore-vcs'

let g:fzf_layout = { 'down': '~20%' }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

let g:fzf_preview_window = 'right:60%'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

" Shortcuts for commonly used searches 
map <C-p> :GFiles<cr>
map <leader><C-p> :Files<cr>
nmap <leader>; :Buffers<CR>
noremap <leader>s :Rg

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' 
  \ }

" ==============================
" ===      AUTO-COMMANDS     ===
" ==============================

augroup configureFoldsAndSpelling
  autocmd!
  autocmd FileType mkd       setlocal spell nofoldenable
  autocmd FileType markdown  setlocal spell nofoldenable
  autocmd FileType text      setlocal spell nofoldenable
  autocmd FileType gitcommit setlocal spell
  autocmd FileType vim       setlocal foldmethod=marker
augroup END

augroup resumeCursorPosition
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

augroup miscGroup
  autocmd!
  " when in a git commit buffer go the beginning
  autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " save files when focus is lost
  autocmd BufLeave * silent! update

  " always have quickfix window take up all the horizontal space
  autocmd FileType qf wincmd J

  " configure indentation for python
  autocmd FileType python set expandtab tabstop=4 softtabstop=4 shiftwidth=4

  " Disable spell checking in vim help files
  autocmd FileType help set nospell

  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup END

augroup neorun
  autocmd!
  autocmd TermClose * :call TerminalOnTermClose(0+expand('<abuf>'))
augroup end

" ==============================
" ===    GENERAL MAPPINGS    ===
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

" save and quit
nnoremap <leader>W :wq<CR>
" safe save
nnoremap <leader>w :update<CR>
" double leader to toggle between buffers
nnoremap <leader><leader> <c-^>
" leader q to just close the current focused buffer
nnoremap <leader>q :bd<CR>

" HH to stop searching
vnoremap HH :nohlsearch<cr>
nnoremap HH :nohlsearch<cr>

" Pasting
xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" ==============================
" ===    CUSTOM FUNCTIONS    ===
" ==============================

" insert path to current file in command (:) mode
cnoremap %% <C-R>=expand('%:h/')<cr>

" rename current buffer
nnoremap <leader>rf :call RenameFile()<cr>

nnoremap <leader>a :call YankWholeBuffer(0)<cr>
nnoremap <leader>p :call PasteFromSystemClipBoard()<cr>
nnoremap <leader>cs :call CorrectSpelling()<cr>

" ==============================
" ===          GIT           ===
" ==============================

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

" ==============================
" ===     TERMINAL MODE      ===
" ==============================

" Make terminal mode behave more like any other mode
tnoremap <C-[> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
" tnoremap <A-k> <C-\><C-n><C-W>+i
" tnoremap <A-j> <C-\><C-n><C-W>-i
tnoremap <A-k> <Up>
tnoremap <A-j> <Down>
tnoremap <A-h> <C-\><C-n>3<C-W>>i
tnoremap <A-l> <C-\><C-n>3<C-W><i
" tnoremap ∆ <Down>
" tnoremap ˚ <Up>

" Open terminal in vertical split
nnoremap <leader>st :vs term://zsh<cr>¡

" ==============================
" ===         COC            ===
" ==============================

let g:coc_global_extensions = [ 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier', 'coc-yaml', 'coc-highlight',  'coc-tslint-plugin',  'coc-rust-analyzer', 'coc-snippets']
 " \ 'coc-eslint',
 " \ 'coc-tsserver',
 " \ 'coc-jest',

nnoremap <leader>cao :CocCommand actions.open<cr>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for cycling through options - has to be wrapped in autocmd to
" overwrite plugin
autocmd VimEnter * inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
autocmd VimEnter * inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" Remap keys for applying codeAction to the current buffer.
nmap <leader> ca <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader> qf <Plug>(coc-fix-current)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader> rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:OrganiseImports` command for organize imports of the current buffer. - Not currently
" supported in Rust

" command! -nargs=0 OrganiseImports :call CocAction('runCommand', 'editor.action.organizeImport')
" nnoremap <leader>OI :OrganiseImports<CR>

" Find symbol of current document.
nnoremap <silent> <space>o :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>sy :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
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

" Custom color highlighting for Coc

" Set the chaining hint to be different from the rest of the syntax
highlight CocRustChainingHint ctermfg=White guifg=#9580ff

" Inline error highlighting
highlight CocErrorVirtualText ctermfg=Red guifg=#CC3232
highlight CocWarningVirtualText ctermfg=Yellow guifg=#fff5b1

" ==============================
" ===          TMUX          ===
" ==============================

" ==============================
" ===          GUI           ===
" ==============================

let g:lightline = {
  \ 'colorscheme': 'edge',
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
  \ }

" ==============================
" ===    DEBUGGING REMAPS    ===
" ==============================
"
" Debugger remaps
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>dr :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" ==============================
" ===    BUILD / RUNNING     ===
" ==============================

nnoremap <leader>b :call BuildCurrentFile()<cr>
nnoremap <leader>B :call RunCurrentFile()<cr>

" ==============================
" ===      TEST RUNNING      ===
" ==============================

nnoremap <leader>t :w<cr>:call spectacular#run_tests()<cr>
nnoremap <leader>tl :w<cr>:call spectacular#run_tests_with_current_line()<cr>

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
      \ 'rust, toml',
      \ ':call SmartRun("cargo test")',
      \ '.rs'
      \ )

let g:spectacular_use_terminal_emulator = 1
let g:spectacular_debugging_mode = 0

" ==============================
" ===        SNIPPETS        ===
" ==============================

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ["ultisnips"]

" ==============================
" ===      NOTE TAKING       ===
" ==============================

nnoremap <leader>sb :call notable#open_notes_file()<cr>
let g:notable_notes_folder = "~/notes/"

" ==============================
" ===     COMMENTING         ===
" ==============================

" turn off all the default bindings
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDToggleCheckAllLines = 1

map <leader>c<leader> <plug>NERDCommenterToggle

" ==============================
" == ** LANGUAGE SPECIFICS ** ==
" ==============================

" ==============================
" ===         RUST           ===
" ==============================

let g:rustfmt_command = "rustfmt"
let g:rustfmt_autosave = 1

" Follow Rust code style rules
au Filetype rust set colorcolumn=100

" Crate information
if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

" ==============================
" ===     MISC SETTINGS      ===
" ==============================

let g:multi_cursor_exit_from_visual_mode = 0

" Change highlighted yank coloring to be more visible
highlight HighlightedyankRegion cterm=reverse gui=reverse
let g:highlightedyank_highlight_duration = 170

" ==============================
" ===  LOCAL CUSTOMIZATIONS  ===
" ==============================

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
