#!/bin/sh

set -e

which -s brew || (echo "Homebrew is required: http://brew.sh/" && exit 1)

brew bundle check || brew bundle

# Prepare custom settings for Karabiner-Elements
# https://github.com/tekezo/Karabiner-Elements/issues/597#issuecomment-282760186
mkdir -p ~/.config
ln -sfn $PWD/karabiner ~/.config/

# Prepare custom settings for Hammerspoon
mkdir -p ~/.hammerspoon
if ! grep -sq "require('keyboard')" ~/.hammerspoon/init.lua; then
  echo "require('keyboard') -- Load Hammerspoon bits from https://github.com/lubiksss/keyboard" >> ~/.hammerspoon/init.lua
fi
ln -sfn $PWD/hammerspoon ~/.hammerspoon/keyboard

# If Hammerspoon is already running, kill it so we can pick up the new config
# when opening Hammerspoon below
killall Hammerspoon || true

# Open Apps
open /Applications/Hammerspoon.app
open /Applications/Karabiner-Elements.app

# Enable apps at startup
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:true}' > /dev/null
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Karabiner-Elements.app", hidden:true}' > /dev/null

echo "Done! Remember to enable Accessibility for Hammerspoon."
