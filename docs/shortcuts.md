# Complete Shortcuts Guide

A comprehensive reference for all shortcuts: custom dotfiles shortcuts, macOS system shortcuts, and development tools.

---

## Table of Contents
- [Dotfiles Shortcuts](#dotfiles-shortcuts)
  - [Shell Aliases (zsh)](#shell-aliases-zsh)
  - [Shell Functions](#shell-functions-zsh)
  - [Git Aliases](#git-aliases-gitconfig)
  - [Tmux Keybindings](#tmux-keybindings)
- [macOS System Shortcuts](#macos-system-shortcuts)
  - [Window & App Control](#window--app-control)
  - [Universal Editing](#universal-editing)
  - [Text Navigation](#text-navigation)
  - [Terminal Shortcuts](#terminal-shortcuts)
  - [Finder Shortcuts](#finder-shortcuts)
  - [Browser Shortcuts](#browser-shortcuts)
  - [System-Level Power Shortcuts](#system-level-power-shortcuts)
  - [IDE Shortcuts](#ide-agnostic-engineer-meta-shortcuts)

---

# Dotfiles Shortcuts

## Shell Aliases (zsh)

### Navigation & Defaults
| Alias | Command | Usage |
|-------|---------|-------|
| `ll` | `ls -lah` | List files with details and hidden files |
| `la` | `ls -A` | List all files except `.` and `..` |
| `..` | `cd ..` | Go up one directory |
| `...` | `cd ../..` | Go up two directories |

### Git
| Alias | Command | Usage |
|-------|---------|-------|
| `g` | `git` | Short git command |
| `gs` | `git status` | Show repo status |
| `gl` | `git log --oneline --decorate --graph -n 25` | Pretty log (last 25) |
| `gd` | `git diff` | Show unstaged changes |
| `gds` | `git diff --staged` | Show staged changes |
| `gc` | `git commit` | Commit |
| `gca` | `git commit --amend` | Amend last commit |
| `gp` | `git push` | Push changes |
| `gpo` | `git push -u origin HEAD` | Push & set upstream |
| `ga` | `git add` | Stage files |
| `gaa` | `git add -A` | Stage all changes |
| `grh` | `git reset --hard` | Hard reset |

### Tmux
| Alias | Command | Usage |
|-------|---------|-------|
| `tm` | `tmux` | Start tmux |
| `tma` | `tmux attach -t` | Attach to session, e.g. `tma mysession` |
| `tml` | `tmux ls` | List sessions |

### Tools & Maintenance
| Alias | Command | Usage |
|-------|---------|-------|
| `brewu` | `brew update && upgrade && cleanup` | Update all Homebrew packages |
| `asdfu` | `asdf plugin update --all` | Update all asdf plugins |
| `zshrc` | `$EDITOR ~/.zshrc` | Edit zshrc |
| `dots` | `cd ~/dotfiles` | Go to dotfiles |
| `ext-compare` | Compare IDE extensions | Compare VS Code/Cursor/Windsurf extensions |
| `ext-merge` | Merge IDE extensions | Merge extension lists |
| `ext-install` | Install IDE extensions | Install missing extensions |
| `disk-check` | Check disk space | Run disk space checker |
| `disk-cleanup` | Cleanup disk | Run disk cleanup script |
| `claude-session` | Claude session manager | Manage Claude Code sessions |

## Shell Functions (zsh)

| Function | Usage |
|----------|-------|
| `mkcd <dir>` | Create directory and cd into it |
| `myip` | Show your public IP address |
| `gclean` | Delete local branches merged into main/master/develop |

## Git Aliases (gitconfig)

| Alias | Command | Usage |
|-------|---------|-------|
| `git st` | `status` | Show status |
| `git co` | `checkout` | Checkout branch |
| `git br` | `branch` | List/manage branches |
| `git cm` | `commit` | Commit |
| `git ca` | `commit --amend` | Amend last commit |
| `git lg` | Pretty log (30 commits) | Visual commit history |
| `git unstage` | `restore --staged .` | Unstage all files |
| `git discard` | `restore .` | Discard all changes |
| `git last` | `log -1 HEAD` | Show last commit |
| `git bclean` | Clean merged branches | Delete merged local branches |
| `git bdone` | Checkout default + pull + clean | Finish feature workflow |
| `git sync` | `pull --rebase && push` | Sync with remote |
| `git wip` | `commit -am "WIP"` | Quick WIP commit |
| `git save` | Add all + commit "SAVEPOINT" | Quick savepoint |
| `git gone` | List branches with deleted remotes | Find stale branches |
| `git browse` | Open repo in browser | Open GitHub page |
| `git pr` | Open PR creation page | Start a pull request |
| `git fp` | Safe force push | Force push with lease |

## Tmux Keybindings

*Prefix is `Ctrl+b` by default*

| Binding | Action |
|---------|--------|
| `prefix + \|` | Split window horizontally |
| `prefix + -` | Split window vertically |
| `prefix + r` | Reload tmux config |

**Settings:** Mouse enabled, vi mode keys, 50k line history, windows/panes start at index 1.

---

# macOS System Shortcuts

## Window & App Control

These should be muscle memory.

| Shortcut | Action |
|----------|--------|
| `⌘ + Space` | Spotlight (apps, files, calculations, unit conversions) |
| `⌘ + Tab` | Switch apps |
| `⌘ + \`` | Switch windows within the same app (criminally underrated) |
| `⌘ + H` | Hide app (clean workspace fast) |
| `⌘ + Q` | Quit app |
| `⌘ + M` | Minimize window |
| `⌘ + W` | Close window/tab |

## Universal Editing

| Shortcut | Action |
|----------|--------|
| `⌘ + C / V / X` | Copy / Paste / Cut |
| `⌘ + Z / ⇧⌘ + Z` | Undo / Redo |
| `⌘ + A` | Select all |
| `⌘ + F` | Find |
| `⌘ + S` | Save |

## Text Navigation

These work everywhere: editors, terminals, browsers, Slack, Notion.

| Shortcut | Action |
|----------|--------|
| `⌥ + ← / →` | Jump word by word |
| `⌘ + ← / →` | Start / end of line |
| `⌥ + ↑ / ↓` | Jump by paragraph / block |
| `⌘ + ↑ / ↓` | Top / bottom of document |

### Deleting Like a Pro

| Shortcut | Action |
|----------|--------|
| `⌥ + Delete` | Delete previous word |
| `⌘ + Delete` | Delete entire line (or to line start) |
| `Fn + Delete` | Forward delete |

## Terminal Shortcuts

If you live in iTerm / Terminal / Warp, these are gold.

### Navigation

| Shortcut | Action |
|----------|--------|
| `Ctrl + A` | Beginning of line |
| `Ctrl + E` | End of line |
| `Ctrl + U` | Clear line (before cursor) |
| `Ctrl + K` | Clear line (after cursor) |
| `Ctrl + W` | Delete last word |

### Power Moves

| Shortcut | Action |
|----------|--------|
| `Ctrl + R` | Reverse search command history 🔥 |
| `Ctrl + L` | Clear screen |
| `Ctrl + C` | Kill process |
| `Ctrl + D` | Exit shell / send EOF |

## Finder Shortcuts

Stop fighting Finder.

| Shortcut | Action |
|----------|--------|
| `⌘ + N` | New Finder window |
| `⌘ + ⇧ + N` | New folder |
| `⌘ + ⇧ + .` | Toggle hidden files (engineers' secret door) |
| `⌘ + ⌥ + V` | Move file (cut + paste) |
| `Space` | Quick Look (underrated magic) |

### Jump Locations

| Shortcut | Action |
|----------|--------|
| `⌘ + ⇧ + G` | Go to folder (paste paths instantly) |
| `⌘ + ⇧ + A` | Applications folder |
| `⌘ + ⌥ + L` | Downloads |
| `⌘ + ⌥ + H` | Home |

## Browser Shortcuts

Chrome / Arc / Safari

### Tabs & Navigation

| Shortcut | Action |
|----------|--------|
| `⌘ + T` | New tab |
| `⌘ + W` | Close tab |
| `⌘ + ⇧ + T` | Reopen closed tab |
| `⌘ + ⌥ + ← / →` | Back / Forward |
| `⌘ + L` | Focus address bar |

### DevTools

| Shortcut | Action |
|----------|--------|
| `⌘ + ⌥ + I` | DevTools |
| `⌘ + ⌥ + C` | Inspect element |
| `⌘ + ⌥ + J` | Console |

## System-Level Power Shortcuts

These make macOS feel designed for engineers.

| Shortcut | Action |
|----------|--------|
| `⌘ + ⇧ + 5` | Screenshots & screen recording |
| `⌘ + ⇧ + 4` | Area screenshot |
| `⌘ + ⇧ + 3` | Full screenshot |
| `⌘ + ⌥ + Esc` | Force quit |
| `⌘ + Control + Q` | Lock screen instantly |

## IDE-Agnostic Shortcuts

These work in VS Code, IntelliJ, WebStorm, etc.

| Shortcut | Action |
|----------|--------|
| `⌘ + P` | Quick file open |
| `⌘ + ⇧ + P` | Command palette |
| `⌘ + /` | Toggle comment |
| `⌘ + D` | Select next occurrence |
| `⌘ + ⇧ + L` | Multi-cursor all occurrences |
| `⌥ + Click` | Add cursor |
| `⌘ + ⌥ + ↑ / ↓` | Duplicate line |

---

## Pro Tips


1. **Remap Caps Lock → Control**
   - Life-changing for terminal + Vim muscle memory
   - System Settings → Keyboard → Modifier Keys

2. **Learn These Three Cold**
   - If you learn only three today, pick:
     - `Ctrl + R` (terminal history)
     - `⌘ + \`` (same-app window switching)
     - `⌥ + Delete` (word delete)

3. **Additional Power Shortcuts**
   - `Ctrl + T` (terminal): Swap last two characters (quick typo fix)
   - `⌘ + ⇧ + [/]`: Switch tabs in most apps
   - `Ctrl + Tab`: Next tab (browser/IDE)

---

## Quick Reference Card

**Most Impactful Shortcuts:**
- `Ctrl + R` — Search command history
- `⌘ + \`` — Same-app window switch
- `⌥ + Delete` — Delete word
- `⌘ + ⇧ + .` — Toggle hidden files
- `⌘ + ⇧ + G` — Go to folder path
- `Space` — Quick Look files

**Most Used Dotfile Aliases:**
- `gs` — Git status
- `gl` — Git log (pretty)
- `gaa` — Git add all
- `dots` — Go to dotfiles
- `..` / `...` — Navigate up
