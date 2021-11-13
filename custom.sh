# From https://macos-defaults.com/

# Drag on cmd + click.
defaults write -g NSWindowShouldDragOnGesture -bool true

# Hide dock fast.
defaults write com.apple.dock autohide-delay -float 0

# Speed up animation of dock hiding.
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Show hidden apps on dock.
defaults write com.apple.Dock showhidden -bool yes

# Set screenshot location to ~/Screenshots.
mkdir -p ~/Screenshots
defaults write com.apple.screencapture "location" -string "~/Screenshots"

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Speed up Mission Control animations.
defaults write com.apple.dock expose-animation-duration -float 0.1

# Show finder path bar.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Scroll on dock icon to show open windows.
defaults write com.apple.dock scroll-to-open -bool true
