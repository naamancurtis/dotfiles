au FileType rust runtime! lang/rust.vim

au FileType toml
  \ runtime! spacing/two.vim
  \ | set indentexpr=
  \ | set smartindent

au FileType yaml
  \ runtime! spacing/two.vim
  \ | set indentexpr=
  \ | set smartindent

au FileType javascript
  \ runtime! spacing/two.vim

au FileType nginx
  \ runtime! spacing/four.vim
  \ | set smartindent

au FileType python
  \ let &mp="clear; python2 %"
  \ | let &efm='%A %#File "%f"\, line %l\,%.%#,%-GTrace%.%#,%C %.%#,%Z%m,%-G%.%#'
  \ | runtime! spacing/four.vim

au FileType sh
  \ runtime! spacing/two.vim

au FileType zsh
  \ runtime! spacing/two.vim

au FileType sql
  \ runtime! spacing/two.vim

au FileType avsc
  \ runtime! spacing/two.vim
