# dotfiles (macOS + zsh + brew + asdf + starship)

## Install
```bash
git clone <your-repo> ~/dotfiles
```


# Put files in ~/dotfiles (or clone your repo there)
cd ~/dotfiles
chmod +x bootstrap.sh
./bootstrap.sh

# Install dependencies
brew bundle --file ~/dotfiles/brew/Brewfile

# (Optional) macOS defaults
~/dotfiles/macos/defaults.sh

# Restart terminal
