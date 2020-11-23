" ========================================
" == Functions ===========================
" ========================================

function! YankWholeBuffer(to_system_clipboard)
  if a:to_system_clipboard
    normal maggVG"*y`a
  else
    normal maggyG`a
  endif
endfunction

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

function! CorrectSpelling()
  normal ma
  let word_before_correction = expand("<cword>")
  let original_setting = &spell

  set spell
  normal 1z=

  let word_after_correction = expand("<cword>")

  if tolower(word_after_correction) == word_before_correction
    undo
  endif

  normal `a
  let &spell = original_setting
endfunction

function! BuildCurrentFile()
  if &filetype == "rust"
    call SmartRun("cargo build")
  elseif &filetype == "toml"
    call SmartRun("cargo build")
  else
    echo "Dunno how to run such a file..."
  endif
endfunction

function! RunCurrentFile()
  if &filetype == "rust"
    call RunCommand("cargo run")
  elseif &filetype == "javascript"
    call RunCommand("node " . PathToCurrentFile())
  elseif &filetype == "shell"
    call RunCommand("sh " . PathToCurrentFile())
  elseif &filetype == "python"
    call RunCommand("python " . PathToCurrentFile())
  else
    echo "Dunno how to run such a file..."
  endif
endfunction

function! RunCommand(cmd)
  exec 'tabe term://' . a:cmd
endfunction

function! PasteFromSystemClipBoard()
  let os = system("uname")
  if os == "Linux"
    read !xclip -selection clipboard -out
  else
    execute "normal! \<esc>o\<esc>\"+]p"
  end
endfunction

" <test-running-functions>
" Functions used to run tests in a terminal split and automatically closing
" the split if the tests are green. If they're red, jump forward to the
" word 'Failure'
function! TerminalRun(cmd)
	execute "new"
	call termopen(a:cmd, {
				\ 'on_exit': function('TerminalOnExit'),
				\ 'buf': expand('<abuf>')
				\})
	execute "normal i"
endfunction

function! TerminalOnExit(job_id, exit_code, event) dict
	if a:exit_code == 0
		execute "bd! " . s:test_buffer_number
		wincmd =
	else
		wincmd =
	endif
endfunction

function! TerminalOnTermClose(buf)
	let s:test_buffer_number = a:buf
endfunction
" </test-running-functions>

function! FifoRun(cmd)
  let pwd = getcwd()
  execute "silent !runner --pwd " . pwd . " --cmd '" . a:cmd . "'"
endfunction

function! TestRun(cmd)
  call FifoRun(a:cmd)
endfunction

function! SmartRun(cmd)
  silent! let output = system('runner --check')

  if output == "Found at least one instance running\n"
    call FifoRun(a:cmd)
  else
    call TerminalRun(a:cmd)
  endif
endfunction

function! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun
