#!/bin/bash
# ===================================================================
# WehttamSnaps Vortex Auto-Update Script
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Checks for and installs Vortex updates automatically
# ===================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════╗"
    echo "║   Vortex Auto-Update Script                  ║"
    echo "╚═══════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${GREEN}▶${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# ===================================================================
# CONFIGURATION
# ===================================================================

VORTEX_PREFIX="$HOME/.local/share/wineprefixes/vortex"
DOWNLOAD_DIR="$HOME/Downloads/vortex"
GITHUB_API="https://api.github.com/repos/Nexus-Mods/Vortex/releases/latest"
VERSION_FILE="$VORTEX_PREFIX/.vortex_version"

# ===================================================================
# FUNCTIONS
# ===================================================================

get_current_version() {
    if [ -f "$VERSION_FILE" ]; then
        cat "$VERSION_FILE"
    else
        echo "unknown"
    fi
}

get_latest_version() {
    curl -s "$GITHUB_API" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/'
}

download_latest() {
    local version=$1
    
    print_step "Downloading Vortex v$version..."
    
    mkdir -p "$DOWNLOAD_DIR"
    
    local url="https://github.com/Nexus-Mods/Vortex/releases/download/v${version}/vortex-setup-${version}.exe"
    
    if wget -O "$DOWNLOAD_DIR/vortex-setup-${version}.exe" "$url"; then
        print_success "Downloaded successfully"
        echo "$DOWNLOAD_DIR/vortex-setup-${version}.exe"
    else
        print_error "Download failed"
        return 1
    fi
}

backup_vortex_data() {
    print_step "Backing up Vortex data..."
    
    local backup_dir="$HOME/.local/share/vortex-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    
    # Backup mod staging folders
    if [ -d "$HOME/Games/VortexMods" ]; then
        print_step "Backing up mod staging folders..."
        cp -r "$HOME/Games/VortexMods" "$backup_dir/" 2>/dev/null || true
    fi
    
    # Backup Vortex settings
    local settings_dir="$VORTEX_PREFIX/drive_c/users/$USER/AppData/Roaming/Vortex"
    if [ -d "$settings_dir" ]; then
        print_step "Backing up Vortex settings..."
        cp -r "$settings_dir" "$backup_dir/" 2>/dev/null || true
    fi
    
    print_success "Backup saved to: $backup_dir"
    echo "$backup_dir"
}

check_vortex_running() {
    if pgrep -f "Vortex.exe" > /dev/null; then
        return 0
    else
        return 1
    fi
}

update_vortex() {
    local installer=$1
    local version=$2
    
    print_step "Installing Vortex v$version..."
    
    # Close Vortex if running
    if check_vortex_running; then
        print_warning "Vortex is running. Please close it."
        read -p "Press Enter when Vortex is closed..."
    fi
    
    # Run installer
    export WINEPREFIX="$VORTEX_PREFIX"
    wine "$installer" /S
    
    # Wait for installation
    sleep 5
    
    # Update version file
    echo "$version" > "$VERSION_FILE"
    
    print_success "Vortex updated to v$version"
}

# ===================================================================
# MAIN UPDATE PROCESS
# ===================================================================

check_for_updates() {
    print_header
    
    print_step "Checking for updates..."
    
    # Check if Vortex is installed
    if [ ! -d "$VORTEX_PREFIX" ]; then
        print_error "Vortex not found. Please install it first."
        exit 1
    fi
    
    # Get versions
    local current_version=$(get_current_version)
    local latest_version=$(get_latest_version)
    
    if [ -z "$latest_version" ]; then
        print_error "Could not fetch latest version from GitHub"
        exit 1
    fi
    
    echo ""
    echo "Current version: $current_version"
    echo "Latest version:  $latest_version"
    echo ""
    
    # Compare versions
    if [ "$current_version" = "$latest_version" ]; then
        print_success "Vortex is up to date!"
        exit 0
    fi
    
    if [ "$current_version" = "unknown" ]; then
        print_warning "Cannot determine current version"
        print_warning "Latest version available: v$latest_version"
        echo ""
        read -p "Install latest version? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 0
        fi
    else
        print_warning "Update available: v$current_version → v$latest_version"
        echo ""
        read -p "Update now? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 0
        fi
    fi
    
    echo ""
    
    # Backup first
    backup_vortex_data
    
    echo ""
    
    # Download update
    local installer=$(download_latest "$latest_version")
    
    if [ $? -ne 0 ] || [ -z "$installer" ]; then
        print_error "Download failed"
        exit 1
    fi
    
    echo ""
    
    # Install update
    update_vortex "$installer" "$latest_version"
    
    echo ""
    print_success "Update complete!"
    echo ""
    echo "Backup saved in: ~/.local/share/vortex-backup-*/"
}

# ===================================================================
# AUTO-UPDATE (SILENT MODE)
# ===================================================================

auto_update() {
    # Silent update for cron jobs
    
    if [ ! -d "$VORTEX_PREFIX" ]; then
        exit 0
    fi
    
    local current_version=$(get_current_version)
    local latest_version=$(get_latest_version)
    
    if [ -z "$latest_version" ]; then
        exit 0
    fi
    
    if [ "$current_version" != "$latest_version" ] && [ "$current_version" != "unknown" ]; then
        # Send notification
        notify-send "Vortex Update Available" "Version $latest_version is available\nRun: vortex-update" -u normal
    fi
}

# ===================================================================
# CHECK ONLY (NO INSTALL)
# ===================================================================

check_only() {
    print_header
    
    if [ ! -d "$VORTEX_PREFIX" ]; then
        print_error "Vortex not installed"
        exit 1
    fi
    
    local current_version=$(get_current_version)
    local latest_version=$(get_latest_version)
    
    echo "Current version: $current_version"
    echo "Latest version:  $latest_version"
    echo ""
    
    if [ "$current_version" = "$latest_version" ]; then
        print_success "Up to date"
    else
        print_warning "Update available: v$latest_version"
        echo "Run: vortex-update"
    fi
}

# ===================================================================
# SHOW CHANGELOG
# ===================================================================

show_changelog() {
    print_header
    
    print_step "Fetching changelog..."
    echo ""
    
    curl -s "$GITHUB_API" | jq -r '.body' | head -n 30
    
    echo ""
    echo "Full changelog: https://github.com/Nexus-Mods/Vortex/releases/latest"
}

# ===================================================================
# HELP
# ===================================================================

show_help() {
    print_header
    echo "Usage: $0 [option]"
    echo ""
    echo "Options:"
    echo "  (none)        Check and install updates interactively"
    echo "  --check       Check for updates only (no install)"
    echo "  --auto        Auto-update check (for cron, silent)"
    echo "  --changelog   Show latest changelog"
    echo "  --help        Show this help"
    echo ""
    echo "Examples:"
    echo "  $0                # Interactive update"
    echo "  $0 --check        # Just check version"
    echo "  $0 --changelog    # View what's new"
    echo ""
    echo "Cron Job (check daily at 10 AM):"
    echo "  0 10 * * * /path/to/vortex-update --auto"
}

# ===================================================================
# MAIN
# ===================================================================

main() {
    case "${1:-}" in
        --check)
            check_only
            ;;
        --auto)
            auto_update
            ;;
        --changelog)
            show_changelog
            ;;
        --help|-h)
            show_help
            ;;
        "")
            check_for_updates
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
}

main "$@"