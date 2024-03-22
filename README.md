# My dotfiles

A collection of dotfiles I use on my macOS machines.

## Instructions

1. Clone this repository to your local machine using the following command in your terminal or command prompt:

```bash
git clone https://github.com/eliseomartelli/dotfiles.git
```

2. Change into the `dotfiles` directory by running the following command:

```bash
cd dotfiles
```

3. Stow the dotfiles using the following command:

```bash
stow -t ~/ -S $(find . -type d ! -name "_*" ! -name ".*"  -depth 1 | cut -d/ -f2-)
```

This will create symbolic links in your home directory for a package.
