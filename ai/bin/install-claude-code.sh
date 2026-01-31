#!/usr/bin/env bash
# Install Claude Code CLI
# https://claude.ai/code

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../helpers/output.sh"

install_claude_code() {
    if command -v claude &> /dev/null; then
        local version
        version=$(claude --version 2>/dev/null || echo "unknown")
        success "Claude Code already installed ($version)"
        return 0
    fi

    info "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
    success "Claude Code installed successfully"
}

uninstall_claude_code() {
    if ! command -v claude &> /dev/null; then
        warn "Claude Code is not installed"
        return 0
    fi

    info "Uninstalling Claude Code..."
    
    # Remove the claude binary
    local install_dir="$HOME/.local/bin"
    if [ -f "$install_dir/claude" ]; then
        rm -f "$install_dir/claude"
        success "Removed claude binary from $install_dir"
    fi
    
    # Remove Claude config directory if it exists
    if [ -d "$HOME/.claude" ]; then
        warn "Claude configuration directory exists at ~/.claude"
        warn "Remove manually if desired: rm -rf ~/.claude"
    fi
    
    success "Claude Code uninstalled"
}

update_claude_code() {
    if ! command -v claude &> /dev/null; then
        warn "Claude Code is not installed. Run install first."
        return 1
    fi

    info "Updating Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
    success "Claude Code updated successfully"
}

case "${1:-install}" in
    install)
        install_claude_code
        ;;
    uninstall)
        uninstall_claude_code
        ;;
    update)
        update_claude_code
        ;;
    *)
        echo "Usage: $0 [install|uninstall|update]"
        echo ""
        echo "Commands:"
        echo "  install   Install Claude Code (default)"
        echo "  uninstall Remove Claude Code"
        echo "  update    Update Claude Code to latest version"
        exit 1
        ;;
esac
