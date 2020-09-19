# Dotbot Rust Plugin

This is a plugin for [Dotbot][dotbot] that handles installing [Rust][rust].
It also allows the installation other [rustup][rustup] components, as well as other Rust software with [Cargo][cargo].

## Installation

Add this repository as submodule to your repository:
```bash
git submodule add https://github.com/alexcormier/dotbot-rust
```

## Usage

Modify your `install` script to load this plugin, as follows:
```bash
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -p dotbot-rust/rust.py -d "${BASEDIR}" -c "${CONFIG}" "${@}"
```
For an example of more advanced usage, with multiple plugins, see [my dotfiles][dotfiles].

## Configuration

Two plugins are provided: `cargo` and `rust`. Here is how to configure them.

### Rust Plugin

Not yet implemented.
If you notice the `rust` section in [my dotfiles][dotfiles], note that it is only a draft configuration for the as of yet unimplemented plugin.

### Cargo Plugin

The simplest way to install binary crates is by listing them in a `cargo` section in your Dotbot configuration file, as follow:
```yaml
- cargo:
    - pijul
    - ripgrep
```
If you need to specify extra arguments to Cargo, you can instead specify a crate as a dictionary.
In this case, each key is passed to cargo as a long-form argument followed by its value, if any.
For example, consider the following configuration:
```yaml
- cargo:
    - pijul
    - ripgrep:
        - no-default-features
        - features: pcre2
```
This would result in the following commands being run:
```sh
cargo install --force pijul
cargo install --force ripgrep --no-default-features --features pcre2
```
You will note that `--force` was added, to allow upgrading binaries.

Finally, when using the dictionary format, any key starting with a `+` is interpreted as a toolchain with which to install the crate.
This means that to install `ripgrep` as above with the nightly toolchain (`cargo +nightly install --force ripgrep --no-default-features --features pcre2`), you would need a configuration like this:
```yaml
- cargo:
    - ripgrep:
        - +nightly
        - no-default-features
        - features: pcre2
```

[dotbot]: https://github.com/anishathalye/dotbot
[rust]: https://www.rust-lang.org/
[rustup]: https://rustup.rs/
[cargo]: http://doc.crates.io/
[dotfiles]: https://github.com/alexcormier/dotfiles/tree/54a90627e224f752e55372065f36a2584bb34609

