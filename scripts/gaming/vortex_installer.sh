#!/bin/bash
# ===================================================================
# WehttamSnaps Vortex Mod Manager Setup
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Installs and configures Vortex Mod Manager for Linux gaming
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
    echo "║   Vortex Mod Manager Setup for Linux         ║"
    echo "║   WehttamSnaps Dotfiles                      ║"
    echo "╚═══════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${GREEN}▶${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

# ===================================================================
# CHECK PREREQUISITES
# ===================================================================

check_prerequisites() {
    print_step "Checking prerequisites..."
    echo ""
    
    # Check for Wine
    if ! command -v wine &>/dev/null; then
        print_error "Wine not found"
        echo "Install with: sudo pacman -S wine-staging"
        exit 1
    else
        WINE_VERSION=$(wine --version)
        print_success "Wine found: $WINE_VERSION"
    fi
    
    # Check for Winetricks
    if ! command -v winetricks &>/dev/null; then
        print_error "Winetricks not found"
        echo "Install with: sudo pacman -S winetricks"
        exit 1
    else
        print_success "Winetricks found"
    fi
    
    # Check for .NET support
    print_success "Prerequisites OK"
    echo ""
}

# ===================================================================
# DOWNLOAD VORTEX
# ===================================================================

download_vortex() {
    print_step "Downloading Vortex Mod Manager..."
    
    DOWNLOAD_DIR="$HOME/Downloads/vortex"
    mkdir -p "$DOWNLOAD_DIR"
    
    # Vortex download URL (latest version)
    VORTEX_URL="https://github.com/Nexus-Mods/Vortex/releases/latest/download/vortex-setup.exe"
    
    if [ -f "$DOWNLOAD_DIR/vortex-setup.exe" ]; then
        print_warning "Installer already exists: $DOWNLOAD_DIR/vortex-setup.exe"
        read -p "Re-download? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_success "Using existing installer"
            return
        fi
    fi
    
    print_step "Downloading from GitHub..."
    wget -O "$DOWNLOAD_DIR/vortex-setup.exe" "$VORTEX_URL"
    
    if [ $? -eq 0 ]; then
        print_success "Downloaded Vortex installer"
    else
        print_error "Download failed"
        exit 1
    fi
    
    echo ""
}

# ===================================================================
# CREATE WINE PREFIX
# ===================================================================

setup_wine_prefix() {
    print_step "Setting up Wine prefix for Vortex..."
    
    VORTEX_PREFIX="$HOME/.local/share/wineprefixes/vortex"
    
    if [ -d "$VORTEX_PREFIX" ]; then
        print_warning "Wine prefix already exists"
        read -p "Delete and recreate? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$VORTEX_PREFIX"
        else
            print_success "Using existing prefix"
            export WINEPREFIX="$VORTEX_PREFIX"
            return
        fi
    fi
    
    mkdir -p "$VORTEX_PREFIX"
    export WINEPREFIX="$VORTEX_PREFIX"
    
    print_step "Initializing Wine prefix (this may take a few minutes)..."
    WINEARCH=win64 wineboot -u
    
    print_success "Wine prefix created: $VORTEX_PREFIX"
    echo ""
}

# ===================================================================
# INSTALL DEPENDENCIES
# ===================================================================

install_dependencies() {
    print_step "Installing Wine dependencies..."
    
    export WINEPREFIX="$HOME/.local/share/wineprefixes/vortex"
    
    # Install .NET Framework 4.8 (required for Vortex)
    print_step "Installing .NET Framework 4.8 (this takes a while)..."
    winetricks -q dotnet48
    
    # Install Visual C++ redistributables
    print_step "Installing Visual C++ 2019 redistributables..."
    winetricks -q vcrun2019
    
    # Install other dependencies
    print_step "Installing additional dependencies..."
    winetricks -q corefonts
    
    # Configure Wine
    print_step "Configuring Wine..."
    winetricks -q dxvk  # DirectX to Vulkan
    
    print_success "Dependencies installed"
    echo ""
}

# ===================================================================
# INSTALL VORTEX
# ===================================================================

install_vortex() {
    print_step "Installing Vortex Mod Manager..."
    
    export WINEPREFIX="$HOME/.local/share/wineprefixes/vortex"
    DOWNLOAD_DIR="$HOME/Downloads/vortex"
    
    # Run installer
    print_step "Running Vortex installer..."
    print_warning "Follow the installation wizard (use default settings)"
    
    wine "$DOWNLOAD_DIR/vortex-setup.exe"
    
    # Wait for installer to finish
    print_step "Waiting for installer to complete..."
    sleep 5
    
    print_success "Vortex installed"
    echo ""
}

# ===================================================================
# CREATE LAUNCHER SCRIPT
# ===================================================================

create_launcher() {
    print_step "Creating launcher script..."
    
    VORTEX_PREFIX="$HOME/.local/share/wineprefixes/vortex"
    LAUNCHER_DIR="$HOME/.local/bin"
    LAUNCHER_FILE="$LAUNCHER_DIR/vortex"
    
    mkdir -p "$LAUNCHER_DIR"
    
    cat > "$LAUNCHER_FILE" << 'EOF'
#!/bin/bash
# Vortex Mod Manager Launcher

export WINEPREFIX="$HOME/.local/share/wineprefixes/vortex"
export WINEARCH=win64

# AMD GPU optimizations
export RADV_PERFTEST=aco
export DXVK_ASYNC=1

# Start Vortex
VORTEX_EXE="$WINEPREFIX/drive_c/Program Files/Black Tree Gaming Ltd/Vortex/Vortex.exe"

if [ -f "$VORTEX_EXE" ]; then
    wine "$VORTEX_EXE" "$@"
else
    echo "Error: Vortex not found at: $VORTEX_EXE"
    echo "Please check your installation"
    exit 1
fi
EOF
    
    chmod +x "$LAUNCHER_FILE"
    
    print_success "Launcher created: $LAUNCHER_FILE"
    echo ""
}

# ===================================================================
# CREATE DESKTOP ENTRY
# ===================================================================

create_desktop_entry() {
    print_step "Creating desktop entry..."
    
    DESKTOP_DIR="$HOME/.local/share/applications"
    DESKTOP_FILE="$DESKTOP_DIR/vortex.desktop"
    
    mkdir -p "$DESKTOP_DIR"
    
    # Download Vortex icon
    ICON_DIR="$HOME/.local/share/icons"
    mkdir -p "$ICON_DIR"
    
    wget -O "$ICON_DIR/vortex.png" "https://raw.githubusercontent.com/Nexus-Mods/Vortex/master/assets/images/vortex.png" 2>/dev/null || true
    
    cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Vortex Mod Manager
Comment=Nexus Mods Vortex Mod Manager
Exec=$HOME/.local/bin/vortex %U
Icon=$ICON_DIR/vortex.png
Terminal=false
Categories=Game;Utility;
Keywords=mods;nexus;gaming;
StartupWMClass=vortex.exe
EOF
    
    chmod +x "$DESKTOP_FILE"
    
    print_success "Desktop entry created"
    echo ""
}

# ===================================================================
# CONFIGURE FOR STEAM GAMES
# ===================================================================

configure_steam_integration() {
    print_step "Configuring Steam integration..."
    
    # Find Steam installation
    STEAM_ROOT=""
    
    if [ -d "$HOME/.local/share/Steam" ]; then
        STEAM_ROOT="$HOME/.local/share/Steam"
    elif [ -d "$HOME/.steam" ]; then
        STEAM_ROOT="$HOME/.steam/steam"
    fi
    
    if [ -z "$STEAM_ROOT" ]; then
        print_warning "Steam not found - you'll need to configure game paths manually"
    else
        print_success "Steam found: $STEAM_ROOT"
        echo "Configure game paths in Vortex settings:"
        echo "  → $STEAM_ROOT/steamapps/common/"
    fi
    
    echo ""
}

# ===================================================================
# TIPS AND CONFIGURATION
# ===================================================================

show_usage_tips() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════╗"
    echo "║   Vortex Setup Complete!                     ║"
    echo "╚═══════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    
    print_step "Launch Vortex:"
    echo "  • Terminal: vortex"
    echo "  • App Launcher: Search for 'Vortex'"
    echo "  • Keybind: Add to Niri config if desired"
    echo ""
    
    print_step "First-Time Setup in Vortex:"
    echo "  1. Log in with Nexus Mods account"
    echo "  2. Set game discovery paths (usually ~/.local/share/Steam/steamapps/common/)"
    echo "  3. Configure mod staging folder (default is fine)"
    echo "  4. Enable automatic deployment"
    echo ""
    
    print_step "Supported Games:"
    echo "  • Skyrim SE/AE"
    echo "  • Fallout 4"
    echo "  • Cyberpunk 2077"
    echo "  • The Witcher 3"
    echo "  • Baldur's Gate 3"
    echo "  • Starfield"
    echo "  • And 100+ more"
    echo ""
    
    print_step "Important Notes:"
    echo "  • Vortex runs in Wine - some features may be slower"
    echo "  • Use native Linux tools when possible (MO2 via Proton)"
    echo "  • Always deploy mods before launching games"
    echo "  • Keep Vortex updated from Settings → About"
    echo ""
    
    print_step "Troubleshooting:"
    echo "  • If Vortex won't start: rm -rf ~/.local/share/wineprefixes/vortex && run setup again"
    echo "  • If mods don't apply: Check deployment in Vortex → Mods tab"
    echo "  • For Proton games: Set WINEDLLOVERRIDES in Steam launch options"
    echo ""
    
    print_step "Alternative: Mod Organizer 2"
    echo "  For better Linux compatibility, consider MO2:"
    echo "  → Install via ProtonUp-Qt"
    echo "  → Use with Steam Proton"
    echo "  → Better native Linux performance"
    echo ""
    
    print_step "Add to WehttamSnaps Config:"
    echo "  Add this keybind to ~/.config/niri/conf.d/10-keybinds.kdl:"
    echo "  Mod+Shift+V { spawn \"vortex\"; }"
    echo ""
    
    print_success "Vortex Mod Manager is ready to use!"
    echo ""
}

# ===================================================================
# MAIN INSTALLATION
# ===================================================================

main() {
    print_header
    
    echo "This script will install Vortex Mod Manager on your system."
    echo "Installation takes ~30-45 minutes due to .NET Framework installation."
    echo ""
    
    read -p "Continue with installation? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled"
        exit 0
    fi
    
    echo ""
    
    check_prerequisites
    download_vortex
    setup_wine_prefix
    install_dependencies
    install_vortex
    create_launcher
    create_desktop_entry
    configure_steam_integration
    show_usage_tips
}

# ===================================================================
# UNINSTALL FUNCTION
# ===================================================================

uninstall_vortex() {
    print_header
    print_warning "This will remove Vortex Mod Manager and its Wine prefix"
    echo ""
    
    read -p "Are you sure? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Uninstall cancelled"
        exit 0
    fi
    
    print_step "Removing Vortex..."
    
    # Remove Wine prefix
    rm -rf "$HOME/.local/share/wineprefixes/vortex"
    
    # Remove launcher
    rm -f "$HOME/.local/bin/vortex"
    
    # Remove desktop entry
    rm -f "$HOME/.local/share/applications/vortex.desktop"
    
    # Remove icon
    rm -f "$HOME/.local/share/icons/vortex.png"
    
    # Remove download
    rm -rf "$HOME/Downloads/vortex"
    
    print_success "Vortex uninstalled"
}

# ===================================================================
# SCRIPT ENTRY POINT
# ===================================================================

case "${1:-}" in
    --uninstall)
        uninstall_vortex
        ;;
    --help|-h)
        print_header
        echo "Usage: $0 [option]"
        echo ""
        echo "Options:"
        echo "  (none)        Install Vortex Mod Manager"
        echo "  --uninstall   Remove Vortex completely"
        echo "  --help        Show this help"
        echo ""
        exit 0
        ;;
    *)
        main
        ;;
esac