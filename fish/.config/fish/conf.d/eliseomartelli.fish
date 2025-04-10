# Localization
set -x LANG en_US.UTF-8

# Aliases
alias dev 'cd ~/Developer/'
alias wor 'cd ~/Developer/work/'
alias icd 'cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias uni 'cd ~/Documents/University/master/'
alias yarn 'yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config'
alias mitmproxy "mitmproxy --set confdir=$XDG_CONFIG_HOME/mitmproxy"
alias mitmweb "mitmweb --set confdir=$XDG_CONFIG_HOME/mitmproxy"

# GPG and Editor
set -x GPG_TTY (tty)
set -x EDITOR nvim

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# PATH modifications
set -x PATH /usr/local/opt/llvm/bin $PATH
set -x PATH $HOME/.deno/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/Library/Android/sdk/platform-tools $PATH
set -x PATH $HOME/Library/Android/sdk/tools/bin $PATH

# XDG Base Directories
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_STATE_HOME "$HOME/.local/state"
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_RUNTIME_DIR "/tmp/run/user/$UID"

# Application-specific directories
set -x ANDROID_USER_HOME "$XDG_DATA_HOME/android"
set -x ANSIBLE_HOME "$XDG_DATA_HOME/ansible"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -x GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -x GOPATH "$XDG_DATA_HOME/go"
set -x TERMINFO "$XDG_DATA_HOME"/terminfo
set -x TERMINFO_DIRS "$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

# History files
set -x HISTFILE "$XDG_STATE_HOME/zsh/history"
set -x LESSHISTFILE "$XDG_STATE_HOME/less/history"

# Load functions
for file in (ls ~/.config/fish/functions/*.fish)
    source $file
end

# Remove welcome message
set -g fish_greeting ""

# Edit command
bind \cx\ce edit_command_buffer

# Fzf
fzf --fish | source
