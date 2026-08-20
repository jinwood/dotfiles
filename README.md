# dotfiles

Personal shell, Git, tmux, editor, and terminal configuration for Fedora,
Arch/Manjaro, Ubuntu/Debian, and macOS.

## Install

Clone the repository, then run:

```sh
./install.sh
```

The installer detects the operating system, installs its system packages, and
links the shared configuration into your home directory. On Fedora it installs
packages from [`os/fedora/Dnffile`](os/fedora/Dnffile) with `dnf`.

The bootstrap also downloads Deno, Oh My Zsh, nvm, Node, and the LazyVim config,
so it requires an internet connection. Review the scripts before running them
on a machine with existing configuration.

After installation, open a new login session or run `exec zsh -l` so the linked
`.zshrc` and its aliases are loaded.
