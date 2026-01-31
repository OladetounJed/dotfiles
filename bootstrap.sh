#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

info() { printf "\033[1;34m==>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m⚠\033[0m  %s\n" "$*"; }

link_file () {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    if [ "$(readlink "$dst" 2>/dev/null || true)" = "$src" ]; then
      info "Already linked: $dst"
      return 0
    fi
    warn "Backing up existing: $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  ln -s "$src" "$dst"
  info "Linked: $dst -> $src"
}

info "Linking dotfiles..."

# Zsh
link_file "$DOTFILES_DIR/zsh/zshenv" "$HOME/.zshenv"
link_file "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/zsh_aliases" "$HOME/.zsh_aliases"
link_file "$DOTFILES_DIR/zsh/zsh_functions" "$HOME/.zsh_functions"

# Git
link_file "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

# Tmux
link_file "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Starship
mkdir -p "$HOME/.config"
link_file "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# VS Code extensions list
mkdir -p "$HOME/.vscode"
link_file "$DOTFILES_DIR/vscode/extensions.json" "$HOME/.vscode/extensions.json"

info "Done linking."

info "Next:"
echo "  1) Install brew deps:  brew bundle --file \"$DOTFILES_DIR/brew/Brewfile\""
echo "  2) Add to PATH:  export PATH=\"$DOTFILES_DIR/bin:\$PATH\""
echo "  3) Apply macOS defaults (optional):  \"$DOTFILES_DIR/macos/defaults.sh\""
echo "  4) Restart terminal"
