# Temi's dotfiles

## Install

```bash
git clone <your-repo> ~/dotfiles
cd ~/dotfiles
chmod +x bootstrap.sh
./bootstrap.sh

# Install Homebrew dependencies
brew bundle --file ~/dotfiles/brew/Brewfile

# Install Claude Code AI tools
~/dotfiles/ai/install.sh --cli

# (Optional) Apply macOS defaults
~/dotfiles/macos/defaults.sh

# (Optional) Sync VSCode/Cursor/Windsurf extensions
~/dotfiles/vscode/sync-extensions.sh install vscode
~/dotfiles/vscode/sync-extensions.sh install windsurf

# Restart terminal
exec zsh
```

## AI Tools Options

The `ai/install.sh` script supports selective installation:

```bash
~/dotfiles/ai/install.sh              # Install everything (default)
~/dotfiles/ai/install.sh --cli        # Also install Claude Code CLI
~/dotfiles/ai/install.sh --agents-only    # Only agent files
~/dotfiles/ai/install.sh --commands-only  # Only slash commands
~/dotfiles/ai/install.sh --mcp-only       # Only MCP servers
~/dotfiles/ai/install.sh --hooks-only     # Only hooks
~/dotfiles/ai/install.sh --permissions-only # Only tool permissions

# Skip specific components
~/dotfiles/ai/install.sh --no-mcp --no-hooks

# Maintenance
~/dotfiles/ai/install.sh --uninstall      # Remove all symlinks
~/dotfiles/ai/install.sh --cleanup        # Clean up settings.local.json
```

## VSCode/Cursor/Windsurf Extension Sync

Sync extensions across editors (VSCode, Cursor, Windsurf):

```bash
~/dotfiles/vscode/sync-extensions.sh compare              # Show diff across all editors
~/dotfiles/vscode/sync-extensions.sh merge                # Union all installed into master list
~/dotfiles/vscode/sync-extensions.sh install vscode       # Install to VSCode
~/dotfiles/vscode/sync-extensions.sh install cursor       # Install to Cursor
~/dotfiles/vscode/sync-extensions.sh install windsurf     # Install to Windsurf
```

## Credits

Inspired by [dmarticus/dotfiles](https://github.com/dmarticus/dotfiles)
