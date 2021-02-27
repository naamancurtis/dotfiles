" Four space indents.
runtime! include/spacing/four.vim
set colorcolumn=100

" Make syntax highlighting more efficient.
syntax sync fromstart

" Always run rustfmt is applicable and always use stable.
let g:rustfmt_autosave_if_config_present = 1
let g:rustfmt_command = "rustfmt +stable"

" Crate information
if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

" Make CTRL-T work correctly with goto-definition.
setlocal tagfunc=CocTagFunc

" Make <TAB> select next completion and Shift-<TAB> to select previous.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
