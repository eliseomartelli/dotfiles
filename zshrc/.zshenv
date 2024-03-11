export GPG_TTY=$(tty)
export EDITOR=nvim
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools/:$PATH"
export PATH="$HOME/Library/Android/sdk/tools/bin/:$PATH"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$UID"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export ZSH="$XDG_DATA_HOME"/oh-my-zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export ANSIBLE_HOME="$XDG_DATA_HOME"/ansible
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export LESSHISTFILE="$XDG_STATE_HOME"/less/history                        


