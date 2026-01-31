#!/usr/bin/env bash
#
# VS Code/Cursor/Windsurf Extension Sync
# Usage: sync-extensions [compare|merge|install [editor]]

set -uo pipefail

SCRIPT_NAME="sync-extensions"
EXTENSIONS_FILE="${HOME}/dotfiles/vscode/extensions.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Timeout function for macOS compatibility
timeout_cmd() {
    local seconds=$1
    shift
    if command -v gtimeout >/dev/null 2>&1; then
        gtimeout "$seconds" "$@"
    elif command -v timeout >/dev/null 2>&1; then
        timeout "$seconds" "$@"
    else
        # Fallback: run command without timeout
        "$@"
    fi
}

usage() {
    cat << EOF
$SCRIPT_NAME - Sync VS Code extensions across editors

USAGE:
    $SCRIPT_NAME compare                    Show diff across all editors
    $SCRIPT_NAME merge                      Union all installed into master list
    $SCRIPT_NAME install [cursor|windsurf|vscode]  Install to specific editor

EXAMPLES:
    $SCRIPT_NAME compare
    $SCRIPT_NAME merge
    $SCRIPT_NAME install cursor
EOF
}

get_installed_extensions() {
    local editor="$1"
    local bin=""
    
    case "$editor" in
        cursor) bin="cursor" ;;
        windsurf) bin="windsurf" ;;
        vscode|code) bin="code" ;;
    esac
    
    if command -v "$bin" &> /dev/null; then
        "$bin" --list-extensions 2>/dev/null | sort || echo ""
    else
        echo ""
    fi
}

compare() {
    echo -e "${BLUE}Comparing extensions across editors...${NC}\n"
    
    # Get extensions from each editor
    local cursor_exts=$(get_installed_extensions cursor)
    local windsurf_exts=$(get_installed_extensions windsurf)
    local vscode_exts=$(get_installed_extensions vscode)
    
    # Get master list
    local master_exts=$(jq -r '.recommendations[]' "$EXTENSIONS_FILE" 2>/dev/null | sort || echo "")
    
    # Collect all unique extensions
    local all_exts=$(echo -e "${cursor_exts}\n${windsurf_exts}\n${vscode_exts}\n${master_exts}" | grep -v '^$' | sort -u)
    
    # Print header
    printf "%-40s %-10s %-10s %-10s %-10s\n" "Extension" "Cursor" "Windsurf" "VS Code" "Master"
    echo "─────────────────────────────────────────────────────────────────────────────"
    
    # Print each extension
    while IFS= read -r ext; do
        [ -z "$ext" ] && continue
        
        local in_cursor=""
        local in_windsurf=""
        local in_vscode=""
        local in_master=""
        
        echo "$cursor_exts" | grep -q "^${ext}$" && in_cursor="✓"
        echo "$windsurf_exts" | grep -q "^${ext}$" && in_windsurf="✓"
        echo "$vscode_exts" | grep -q "^${ext}$" && in_vscode="✓"
        echo "$master_exts" | grep -q "^${ext}$" && in_master="✓"
        
        local color="$NC"
        if [ -z "$in_master" ] && ([ -n "$in_cursor" ] || [ -n "$in_windsurf" ] || [ -n "$in_vscode" ]); then
            color="$YELLOW"  # Missing from master but installed somewhere
        fi
        
        printf "${color}%-40s${NC} %-10s %-10s %-10s %-10s\n" "$ext" "$in_cursor" "$in_windsurf" "$in_vscode" "$in_master"
    done <<< "$all_exts"
    
    echo ""
    echo -e "${YELLOW}Yellow${NC} = installed in an editor but not in master list (run 'merge' to add)"
}

merge() {
    echo -e "${BLUE}Merging all installed extensions into master list...${NC}\n"
    
    # Get extensions from each editor
    local cursor_exts=$(get_installed_extensions cursor)
    local windsurf_exts=$(get_installed_extensions windsurf)
    local vscode_exts=$(get_installed_extensions vscode)
    
    # Union all extensions
    local all_exts=$(echo -e "${cursor_exts}\n${windsurf_exts}\n${vscode_exts}" | grep -v '^$' | sort -u)
    
    # Create new JSON
    local json='{"recommendations":['
    local first=true
    
    while IFS= read -r ext; do
        [ -z "$ext" ] && continue
        
        if [ "$first" = true ]; then
            first=false
        else
            json+=","
        fi
        json+="\"$ext\""
    done <<< "$all_exts"
    
    json+=']}'
    
    # Write to file
    echo "$json" | jq '.' > "$EXTENSIONS_FILE"
    
    local count=$(echo "$all_exts" | grep -c '^' || echo "0")
    echo -e "${GREEN}✓ Merged $count extensions into $EXTENSIONS_FILE${NC}"
}

install_vsix() {
    local bin="$1"
    local ext="$2"
    local publisher="${ext%%.*}"
    local name="${ext#*.}"
    local tmpgz tmpvsix
    tmpgz=$(mktemp "/tmp/${ext}.XXXXXX.vsix.gz")
    tmpvsix="${tmpgz%.gz}"

    local url="https://marketplace.visualstudio.com/_apis/public/gallery/publishers/${publisher}/vsextensions/${name}/latest/vspackage"
    local http_code
    http_code=$(curl -sL -o "$tmpgz" -w "%{http_code}" "$url")

    if [ "$http_code" = "200" ] && [ -s "$tmpgz" ]; then
        # Marketplace returns gzip-compressed VSIX, decompress first
        gunzip -c "$tmpgz" > "$tmpvsix" 2>/dev/null || cp "$tmpgz" "$tmpvsix"
        local output
        output=$(timeout_cmd 30 "$bin" --install-extension "$tmpvsix" --force 2>&1)
        local exit_code=$?
        rm -f "$tmpgz" "$tmpvsix"
        if [ $exit_code -eq 0 ]; then
            echo -e "${GREEN}✓ (vsix)${NC}"
            return 0
        else
            echo -e "${RED}✗ (vsix install failed)${NC}"
            return 1
        fi
    else
        rm -f "$tmpgz" "$tmpvsix"
        echo -e "${RED}✗ (vsix download failed: HTTP $http_code)${NC}"
        return 1
    fi
}

install() {
    local target="${1:-vscode}"
    local bin=""

    case "$target" in
        cursor) bin="cursor" ;;
        windsurf) bin="windsurf" ;;
        vscode|code) bin="code" ;;
        *)
            echo -e "${RED}Error: Unknown editor '$target'${NC}"
            usage
            exit 1
            ;;
    esac

    if ! command -v "$bin" &> /dev/null; then
        echo -e "${RED}Error: $bin not found in PATH${NC}"
        exit 1
    fi

    echo -e "${BLUE}Installing extensions to $target...${NC}\n"

    # Get already-installed extensions to skip redundant installs
    local installed_exts
    installed_exts=$("$bin" --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]')

    local installed_count=0
    local skipped_count=0
    local failed_count=0

    while IFS= read -r ext; do
        [ -z "$ext" ] && continue

        # Skip if already installed (case-insensitive)
        local ext_lower
        ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
        if echo "$installed_exts" | grep -qx "$ext_lower"; then
            printf "Installing: %s ... ${GREEN}✓ (already installed)${NC}\n" "$ext"
            ((skipped_count++))
            continue
        fi

        printf "Installing: %s ... " "$ext"

        local output
        output=$(timeout_cmd 10 "$bin" --install-extension "$ext" --force 2>&1)
        local exit_code=$?

        if [ $exit_code -eq 0 ]; then
            echo -e "${GREEN}✓${NC}"
            ((installed_count++))
        elif echo "$output" | grep -qi "not found"; then
            printf "${YELLOW}not found, trying vsix${NC} ... "
            if install_vsix "$bin" "$ext"; then
                ((installed_count++))
            else
                ((failed_count++))
            fi
        else
            echo -e "${RED}✗${NC}"
            ((failed_count++))
        fi
    done < <(jq -r '.recommendations[]' "$EXTENSIONS_FILE")

    echo ""
    echo -e "${GREEN}✓ Installed: $installed_count${NC}"
    [ $skipped_count -gt 0 ] && echo -e "${GREEN}✓ Already installed: $skipped_count${NC}"
    [ $failed_count -gt 0 ] && echo -e "${RED}✗ Failed: $failed_count${NC}"
}

main() {
    if [ $# -eq 0 ]; then
        usage
        exit 1
    fi
    
    case "$1" in
        compare)
            compare
            ;;
        merge)
            merge
            ;;
        install)
            install "${2:-}"
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown command: $1${NC}"
            usage
            exit 1
            ;;
    esac
}

main "$@"
