# Nushell Environment Config File

# def create_left_prompt [] {
#     let path_segment = if (is-admin) {
#         $"(ansi red_bold)($env.PWD)"
#     } else {
#         $"(ansi green_bold)($env.PWD)"
#     }

#     $path_segment
# }

# def create_right_prompt [] {
#     let time_segment = ([
#         (date now | date format '%m/%d/%Y %r')
#     ] | str join)

#     $time_segment
# }

# # Use nushell functions to define your right and left prompt
# let-env PROMPT_COMMAND = { create_left_prompt }
# let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

# let-env BAT_THEME = OneHalfDark
# let-env CARGO_TARGET_DIR = ~/code/.cargo
# let-env NVM_DIR = ~/.nvm

# Seems like nu shell can pull from zsh based PATH?
# let path = [
#   "~/code/bin",
#   "~/code/exec",
#   "~/.cargo/bin",
#   "/usr/local/opt/llvm/bin",
#   "/usr/local/bin/rust-analyzer",
#   "~/go/bin",
# ]

# $path | each { |$it| let-env PATH = ($env.PATH | append $it) }

# starship init nu | save ~/.cache/starship/init.nu