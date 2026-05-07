#!/bin/bash

echo "Installing.."

# 1. Check for Homebrew
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed."
fi

# 2. Install Core Dependencies
echo "Installing terminal utilities and core packages..."
brew install stow jq starship lazygit
brew install zsh-autosuggestions zsh-syntax-highlighting

# 3. Tap and Install Custom macOS Tools
echo "Installing Yabai, Skhd, and SketchyBar..."
brew tap koekeishiya/formulae
brew install yabai skhd
brew tap FelixKratz/formulae
brew install sketchybar

# 4. Deploy Dotfiles with Stow
echo "Stowing configurations into the home directory..."
cd ~/dotfiles ||
  {
    echo "The folder does not exist, exiting..."
    exit
  }

stow kitty nvim sketchybar skhd starship tmux yabai zsh lazygit

# 5. Start Services
echo "Starting background services..."
yabai --start-service
skhd --start-service
brew services start sketchybar

echo "Setup complete! Please open a new terminal window or run 'source ~/.zshrc'."
