# Show indicators of open applications
defaults write com.apple.dock show-process-indicators -bool true
# Autohide dock with no delay time and fast animations
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.7
# Dock icon sizes
defaults write com.apple.dock tilesize -float 47
# Restart dock
killall Dock
