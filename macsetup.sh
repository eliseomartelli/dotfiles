#!/bin/bash

defaults write com.apple.dock "orientation" -string "left" && killall Dock
defaults write com.apple.dock "tilesize" -int "36" && killall Dock
defaults write com.apple.dock "autohide" -bool "true" && killall Dock
defaults write com.apple.dock "autohide-time-modifier" -float "0" && killall Dock
defaults write com.apple.dock "autohide-delay" -float "0" && killall Dock
defaults write com.apple.dock "show-recents" -bool "false" && killall Dock
defaults write com.apple.dock "static-only" -bool "true" && killall Dock
defaults write com.apple.dock "scroll-to-open" -bool "true" && killall Dock

defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" && killall Finder
defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv" && killall Finder
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" && killall Finder
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf" && killall Finder
defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true" && killall Finder
defaults write com.apple.finder "ShowStatusBar" -bool "true" && killall Finder

defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true" && killall Finder

defaults write NSGlobalDomain AppleKeyboardUIMode -int "2"

defaults write com.apple.TextEdit "RichText" -bool "false" && killall TextEdit

defaults write -g NSWindowShouldDragOnGesture -bool true

brew install \
	awscli \
	buildkit \
	cabextract \
	cmake \
	fish \
	fpp \
	fzf \
	git-absorb \
	go \
	golangci-lint \
	jira-cli \
	jj \
	jq \
	k6 \
	luarocks \
	mas \
	mise \
	neovim \
	node \
	patat \
	pinentry-mac \
	pnpm \
	prettier \
	prettierd \
	python \
	ripgrep-all \
	scc \
	sqlc \
	stow \
	tmux \
	tree-sitter \
	tree-sitter-cli \
	typescript \
	urlview \
	uv \
	webpack \
	yarn \
	zoxide \
;

brew install --cask \
	antigravity-cli \
	betterdisplay \
	claude-code \
	docker-desktop \
	font-meslo-lg-nerd-font \
	mactex-no-gui \
	obsidian \
	rapidapi \
	tg-pro \
	unsloth \
;

# Installed outside Homebrew:
#   rex      - https://rex.superlogical.com (config: dotfiles/rex)
uv tool install jiratui  # config (has API token) is machine-local: ~/.config/jiratui

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mas install 1518036000  # Sequel Ace
mas install 1662217862  # Wipr

# Machine-specific extras.
local_config="$(cd "$(dirname "$0")" && pwd)/macsetup.local.sh"

[ -f "$local_config" ] && . "$local_config"
