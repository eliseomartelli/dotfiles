# From https://macos-defaults.com/

# Drag on cmd + click.
defaults write -g NSWindowShouldDragOnGesture -bool true

# Hide dock fast.
defaults write com.apple.dock autohide-delay -float 0

# Speed up animation of dock hiding.
defaults write com.apple.dock autohide-time-modifier -float 0.25

# Set dock icon size.
defaults write com.apple.dock tilesize -int 32

# Show hidden apps on dock.
defaults write com.apple.Dock showhidden -bool yes

# Set dock autohide.
defaults write com.apple.dock autohide -bool true

# Set screenshot location to ~/Pictures/Screenshots.
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture "location" -string "~/Pictures/Screenshots"

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

# Set plain text default textedit file.
defaults write com.apple.TextEdit RichText -bool false

# Set default search scope of finder to current folder.
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

# Remove items from trash after 30 day.
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool true

# Disable delay in Finder Toolbar to show icon.
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"

# Set date in menubar.
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d\""
