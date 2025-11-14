#!/bin/bash
# ===================================================================
# WehttamSnaps Dotfiles Installer
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Interactive installer for WehttamSnaps Niri setup
# ===================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/wehttamsnaps"
BACKUP_DIR="$HOME/.config/wehttamsnaps-backup-$(date +%Y%m%d-%H%M%S)"

# ===================================================================
# HELPER FUNCTIONS
# ===================================================================

print_header() {
    echo -e "${PURPLE}"
    cat << 'EOF'
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
EOF
    echo -e "${NC}"
    echo -e "${CYAN}Niri + Noctalia Setup for Photography & Gaming${NC}"
    echo -e "${CYAN}https://github.com/Crowdrocker/wehttamsnaps-dotfiles${NC}"
    echo ""
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

# Check if running as root
check_root() {
    if [ "$EUID" -eq 0 ]; then
        print_error "Do not run this script as root"
        exit 1
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Backup existing configs
backup_configs() {
    print_step "Backing up existing configs..."
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup Niri config
    if [ -d "$HOME/.config/niri" ]; then
        cp -r "$HOME/.config/niri" "$BACKUP_DIR/"
        print_success "Backed up Niri config"
    fi
    
    # Backup Noctalia config
    if [ -d "$HOME/.config/noctalia" ]; then
        cp -r "$HOME/.config/noctalia" "$BACKUP_DIR/"
        print_success "Backed up Noctalia config"
    fi
    
    # Backup Ghostty config
    if [ -d "$HOME/.config/ghostty" ]; then
        cp -r "$HOME/.config/ghostty" "$BACKUP_DIR/"
        print_success "Backed up Ghostty config"
    fi
    
    print_success "Backup saved to: $BACKUP_DIR"
    echo ""
}

# ===================================================================
# INSTALLATION MODES
# ===================================================================

install_core() {
    print_step "Installing core packages..."
    
    # Install from package list
    if [ -f "$SCRIPT_DIR/packages/core.list" ]; then
        # Remove comments and empty lines
        packages=$(grep -v '^#' "$SCRIPT_DIR/packages/core.list" | grep -v '^$' | tr '\n' ' ')
        
        if command_exists pacman; then
            print_step "Installing pacman packages..."
            sudo pacman -S --needed $packages
        fi
    fi
    
    # Install AUR packages
    if [ -f "$SCRIPT_DIR/packages/aur.list" ]; then
        if command_exists paru; then
            print_step "Installing AUR packages..."
            packages=$(grep -v '^#' "$SCRIPT_DIR/packages/aur.list" | grep -v '^$' | tr '\n' ' ')
            paru -S --needed $packages
        elif command_exists yay; then
            print_step "Installing AUR packages..."
            packages=$(grep -v '^#' "$SCRIPT_DIR/packages/aur.list" | grep -v '^$' | tr '\n' ' ')
            yay -S --needed $packages
        else
            print_warning "No AUR helper found (paru/yay)"
            print_warning "Install manually: sudo pacman -S paru"
        fi
    fi
    
    print_success "Core packages installed"
    echo ""
}

install_photography() {
    print_step "Installing photography packages..."
    
    if [ -f "$SCRIPT_DIR/packages/photography.list" ]; then
        packages=$(grep -v '^#' "$SCRIPT_DIR/packages/photography.list" | grep -v '^$' | tr '\n' ' ')
        sudo pacman -S --needed $packages
        print_success "Photography packages installed"
    fi
    
    echo ""
}

install_gaming() {
    print_step "Installing gaming packages..."
    
    if [ -f "$SCRIPT_DIR/packages/gaming.list" ]; then
        packages=$(grep -v '^#' "$SCRIPT_DIR/packages/gaming.list" | grep -v '^$' | tr '\n' ' ')
        sudo pacman -S --needed $packages
        print_success "Gaming packages installed"
    fi
    
    # Enable multilib (for 32-bit gaming libraries)
    if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
        print_step "Enabling multilib repository..."
        sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
        sudo pacman -Sy
        print_success "Multilib enabled"
    fi
    
    echo ""
}

install_configs() {
    print_step "Installing configs..."
    
    mkdir -p "$CONFIG_DIR"
    
    # Copy configs
    if [ -d "$SCRIPT_DIR/configs" ]; then
        cp -r "$SCRIPT_DIR/configs/"* "$HOME/.config/"
        print_success "Configs copied"
    fi
    
    # Copy scripts
    if [ -d "$SCRIPT_DIR/scripts" ]; then
        cp -r "$SCRIPT_DIR/scripts" "$CONFIG_DIR/"
        chmod +x "$CONFIG_DIR/scripts"/**/*.sh
        print_success "Scripts installed"
    fi
    
    # Copy themes
    if [ -d "$SCRIPT_DIR/themes" ]; then
        cp -r "$SCRIPT_DIR/themes" "$CONFIG_DIR/"
        print_success "Themes installed"
    fi
    
    # Copy wallpapers
    if [ -d "$SCRIPT_DIR/wallpapers" ]; then
        mkdir -p "$HOME/Pictures/Wallpapers"
        cp -r "$SCRIPT_DIR/wallpapers/"* "$HOME/Pictures/Wallpapers/"
        print_success "Wallpapers installed"
    fi
    
    # Copy sounds
    if [ -d "$SCRIPT_DIR/sounds" ]; then
        cp -r "$SCRIPT_DIR/sounds" "$CONFIG_DIR/"
        print_success "Sounds installed"
    fi
    
    # Copy webapps
    if [ -d "$SCRIPT_DIR/webapps" ]; then
        mkdir -p "$HOME/.local/share/applications"
        cp "$SCRIPT_DIR/webapps/"*.desktop "$HOME/.local/share/applications/"
        print_success "Webapps installed"
    fi
    
    echo ""
}

configure_system() {
    print_step "Configuring system..."
    
    # Enable services
    if command_exists systemctl; then
        systemctl --user enable --now pipewire pipewire-pulse wireplumber
        print_success "PipeWire services enabled"
    fi
    
    # Set up audio routing
    if [ -f "$CONFIG_DIR/scripts/audio/audio-routing.sh" ]; then
        print_step "Setting up audio routing..."
        bash "$CONFIG_DIR/scripts/audio/audio-routing.sh"
    fi
    
    # Apply gaming optimizations
    if [ -f "$CONFIG_DIR/scripts/gaming/optimize-performance.sh" ]; then
        print_step "Applying gaming optimizations..."
        bash "$CONFIG_DIR/scripts/gaming/optimize-performance.sh"
    fi
    
    # Set default shell (optional)
    if command_exists zsh && [ "$SHELL" != "$(which zsh)" ]; then
        print_warning "Would you like to set Zsh as default shell?"
        read -p "Change shell to Zsh? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            chsh -s "$(which zsh)"
            print_success "Default shell changed to Zsh (logout required)"
        fi
    fi
    
    echo ""
}

install_plymouth() {
    print_step "Installing Plymouth boot theme..."
    
    if [ -d "$SCRIPT_DIR/themes/wehttamsnaps/plymouth" ]; then
        sudo cp -r "$SCRIPT_DIR/themes/wehttamsnaps/plymouth" /usr/share/plymouth/themes/wehttamsnaps
        sudo plymouth-set-default-theme wehttamsnaps
        
        # Rebuild initramfs
        if command_exists mkinitcpio; then
            sudo mkinitcpio -P
            print_success "Plymouth theme installed"
        fi
    else
        print_warning "Plymouth theme not found"
    fi
    
    echo ""
}

# ===================================================================
# INTERACTIVE MENU
# ===================================================================

show_menu() {
    print_header
    
    echo "Select installation option:"
    echo ""
    echo "1) Full Install (Everything)"
    echo "2) Core Only (Minimal setup)"
    echo "3) Core + Photography"
    echo "4) Core + Gaming"
    echo "5) Configs Only (No packages)"
    echo "6) Photography Packages Only"
    echo "7) Gaming Packages Only"
    echo "8) Exit"
    echo ""
    
    read -p "Enter choice [1-8]: " choice
    
    case $choice in
        1)
            backup_configs
            install_core
            install_photography
            install_gaming
            install_configs
            configure_system
            install_plymouth
            ;;
        2)
            backup_configs
            install_core
            install_configs
            configure_system
            ;;
        3)
            backup_configs
            install_core
            install_photography
            install_configs
            configure_system
            ;;
        4)
            backup_configs
            install_core
            install_gaming
            install_configs
            configure_system
            ;;
        5)
            backup_configs
            install_configs
            configure_system
            ;;
        6)
            install_photography
            ;;
        7)
            install_gaming
            ;;
        8)
            print_success "Exiting installer"
            exit 0
            ;;
        *)
            print_error "Invalid option"
            exit 1
            ;;
    esac
}

# ===================================================================
# POST-INSTALL
# ===================================================================

post_install() {
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  Installation Complete!${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
    echo ""
    
    print_step "Next Steps:"
    echo ""
    echo "1. Logout and select 'Niri' from your display manager"
    echo "2. First boot will show welcome screen"
    echo "3. Press Mod+H to see all keybinds"
    echo ""
    
    print_step "Quick Start:"
    echo "  • Mod+Space     → App Launcher"
    echo "  • Mod+Return    → Terminal"
    echo "  • Mod+H         → KeyHints"
    echo "  • Mod+S         → Control Center"
    echo ""
    
    print_step "Documentation:"
    echo "  • Keybinds: $CONFIG_DIR/docs/KEYBINDS.md"
    echo "  • Gaming:   $CONFIG_DIR/docs/GAMING.md"
    echo "  • Photos:   $CONFIG_DIR/docs/PHOTOGRAPHY.md"
    echo ""
    
    print_step "Support:"
    echo "  • GitHub: https://github.com/Crowdrocker/wehttamsnaps-dotfiles"
    echo "  • Issues: https://github.com/Crowdrocker/wehttamsnaps-dotfiles/issues"
    echo ""
    
    print_warning "Backup saved to: $BACKUP_DIR"
    echo ""
}

# ===================================================================
# MAIN
# ===================================================================

main() {
    check_root
    
    # Handle command line args
    case "${1:-}" in
        --core)
            backup_configs
            install_core
            install_configs
            configure_system
            post_install
            ;;
        --photography)
            backup_configs
            install_core
            install_photography
            install_configs
            configure_system
            post_install
            ;;
        --gaming)
            backup_configs
            install_core
            install_gaming
            install_configs
            configure_system
            post_install
            ;;
        --all)
            backup_configs
            install_core
            install_photography
            install_gaming
            install_configs
            configure_system
            install_plymouth
            post_install
            ;;
        --help|-h)
            print_header
            echo "Usage: $0 [option]"
            echo ""
            echo "Options:"
            echo "  --core          Install core packages only"
            echo "  --photography   Install core + photography"
            echo "  --gaming        Install core + gaming"
            echo "  --all           Install everything"
            echo "  --help          Show this help"
            echo ""
            echo "Without options, interactive menu will be shown"
            exit 0
            ;;
        *)
            show_menu
            post_install
            ;;
    esac
}

main "$@"
