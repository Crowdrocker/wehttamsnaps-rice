#!/bin/bash
# === WEHTTAMSNAPS - MODDING BACKUP SCRIPT ===
# Backup modding configurations and profiles

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Directories to backup
BACKUP_DIR="$HOME/.local/share/modding/backups"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_NAME="modding-backup-$TIMESTAMP"

echo -e "${BLUE}[INFO] Creating WehttamSnaps modding backup...${NC}"

# Create backup directory
mkdir -p "$BACKUP_DIR/$BACKUP_NAME"

# Backup SteamTinkerLaunch
backup_stl() {
    echo -e "${YELLOW}[BACKUP] Backing up SteamTinkerLaunch...${NC}"
    
    if [ -d "$HOME/.config/steamtinkerlaunch" ]; then
        tar -czf "$BACKUP_DIR/$BACKUP_NAME/steamtinkerlaunch.tar.gz" \
            -C "$HOME/.config" "steamtinkerlaunch" \
            --exclude="*.log" \
            --exclude="*.tmp" \
            --exclude="cache"
        echo -e "${GREEN}[OK] SteamTinkerLaunch backed up${NC}"
    else
        echo -e "${YELLOW}[SKIP] SteamTinkerLaunch not found${NC}"
    fi
}

# Backup Vortex
backup_vortex() {
    echo -e "${YELLOW}[BACKUP] Backing up Vortex...${NC}"
    
    if [ -d "$HOME/.config/vortex" ]; then
        tar -czf "$BACKUP_DIR/$BACKUP_NAME/vortex.tar.gz" \
            -C "$HOME/.config" "vortex" \
            --exclude="*.log" \
            --exclude="downloads" \
            --exclude="temp"
        echo -e "${GREEN}[OK] Vortex backed up${NC}"
    else
        echo -e "${YELLOW}[SKIP] Vortex not found${NC}"
    fi
}

# Backup Mod Organizer 2
backup_mo2() {
    echo -e "${YELLOW}[BACKUP] Backing up Mod Organizer 2...${NC}"
    
    if [ -d "$HOME/.config/modorganizer2" ]; then
        tar -czf "$BACKUP_DIR/$BACKUP_NAME/modorganizer2.tar.gz" \
            -C "$HOME/.config" "modorganizer2" \
            --exclude="*.log" \
            --exclude="temp"
        echo -e "${GREEN}[OK] Mod Organizer 2 backed up${NC}"
    else
        echo -e "${YELLOW}[SKIP] Mod Organizer 2 not found${NC}"
    fi
}

# Backup Wabbajack
backup_wabbajack() {
    echo -e "${YELLOW}[BACKUP] Backing up Wabbajack...${NC}"
    
    if [ -d "$HOME/.local/share/wabbajack" ]; then
        tar -czf "$BACKUP_DIR/$BACKUP_NAME/wabbajack.tar.gz" \
            -C "$HOME/.local/share" "wabbajack" \
            --exclude="downloads" \
            --exclude="*.log" \
            --exclude="cache"
        echo -e "${GREEN}[OK] Wabbajack backed up${NC}"
    else
        echo -e "${YELLOW}[SKIP] Wabbajack not found${NC}"
    fi
}

# Backup game configurations
backup_game_configs() {
    echo -e "${YELLOW}[BACKUP] Backing up game configurations...${NC}"
    
    # Skyrim SE
    if [ -d "$HOME/.local/share/Steam/steamapps/common/Skyrim Special Edition" ]; then
        tar -czf "$BACKUP_DIR/$BACKUP_NAME/skyrim-se-configs.tar.gz" \
            -C "$HOME/.local/share/Steam/steamapps/common/Skyrim Special Edition" \
            "Data" "SKSE" \
            2>/dev/null || echo -e "${YELLOW}[SKIP] Skyrim SE mods folder not accessible${NC}"
        echo -e "${GREEN}[OK] Skyrim SE configs backed up${NC}"
    fi
    
    # Fallout 4
    if [ -d "$HOME/.local/share/Steam/steamapps/common/Fallout 4" ]; then
        tar -czf "$BACKUP_DIR/$BACKUP_NAME/fallout4-configs.tar.gz" \
            -C "$HOME/.local/share/Steam/steamapps/common/Fallout 4" \
            "Data" "F4SE" \
            2>/dev/null || echo -e "${YELLOW}[SKIP] Fallout 4 mods folder not accessible${NC}"
        echo -e "${GREEN}[OK] Fallout 4 configs backed up${NC}"
    fi
}

# Backup scripts and configurations
backup_scripts() {
    echo -e "${YELLOW}[BACKUP] Backing up WehttamSnaps modding scripts...${NC}"
    
    if [ -d "$HOME/.config/wehttamsnaps" ]; then
        tar -czf "$BACKUP_DIR/$BACKUP_NAME/wehttamsnaps-modding.tar.gz" \
            -C "$HOME/.config" "wehttamsnaps/scripts" "wehttamsnaps/webapps" \
            2>/dev/null || true
        echo -e "${GREEN}[OK] WehttamSnaps modding scripts backed up${NC}"
    fi
}

# Create backup manifest
create_manifest() {
    echo -e "${YELLOW}[BACKUP] Creating backup manifest...${NC}"
    
    cat > "$BACKUP_DIR/$BACKUP_NAME/MANIFEST.txt" << EOF
WehttamSnaps Modding Backup
Created: $(date)
Backup Name: $BACKUP_NAME

Contents:
$(ls -la "$BACKUP_DIR/$BACKUP_NAME/")

System Information:
OS: $(uname -a)
Kernel: $(uname -r)
Desktop: $XDG_CURRENT_DESKTOP

Modding Tools Status:
SteamTinkerLaunch: $(command -v steamtinkerlaunch &>/dev/null && echo "Installed" || echo "Not found")
Vortex: $(command -v vortex &>/dev/null && echo "Installed" || echo "Not found")
Mod Organizer 2: $(command -v modorganizer2 &>/dev/null && echo "Installed" || echo "Not found")
Wabbajack: $(command -v wabbajack &>/dev/null && echo "Installed" || echo "Not found")

Restore Instructions:
1. Extract the relevant tar.gz file to the appropriate location
2. For SteamTinkerLaunch: Extract to ~/.config/
3. For Vortex: Extract to ~/.config/
4. For Mod Organizer 2: Extract to ~/.config/
5. For Wabbajack: Extract to ~/.local/share/
6. For game configs: Extract to game directory

Notes:
- This backup preserves mod configurations and profiles
- Actual mod files are not included (too large)
- Scripts and custom configurations are included
- Cache files and logs are excluded to save space

WehttamSnaps - Professional Arch Linux Modding Setup
GitHub: https://github.com/Crowdrocker
EOF
    
    echo -e "${GREEN}[OK] Backup manifest created${NC}"
}

# Cleanup old backups (keep last 5)
cleanup_old_backups() {
    echo -e "${YELLOW}[CLEANUP] Cleaning up old backups...${NC}"
    
    cd "$BACKUP_DIR"
    ls -1t | tail -n +6 | xargs -r rm -rf
    
    echo -e "${GREEN}[OK] Old backups cleaned up${NC}"
}

# Show backup summary
show_summary() {
    echo ""
    echo -e "${GREEN}✅ WehttamSnaps Modding Backup Complete!${NC}"
    echo ""
    echo -e "${YELLOW}📦 Backup Details:${NC}"
    echo -e "   • Location: $BACKUP_DIR/$BACKUP_NAME/"
    echo -e "   • Size: $(du -sh "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)"
    echo -e "   • Files: $(find "$BACKUP_DIR/$BACKUP_NAME" -type f | wc -l)"
    echo ""
    echo -e "${YELLOW}📋 What was backed up:${NC}"
    echo -e "   • SteamTinkerLaunch configurations"
    echo -e "   • Vortex mod manager settings"
    echo -e "   • Mod Organizer 2 profiles"
    echo -e "   • Wabbajack configurations"
    echo -e "   • Game mod configurations"
    echo -e "   • WehttamSnaps custom scripts"
    echo ""
    echo -e "${BLUE}💡 Restore with: Super+Ctrl+Shift+R or run restore-modding-setup.sh${NC}"
}

# Main function
main() {
    backup_stl
    backup_vortex
    backup_mo2
    backup_wabbajack
    backup_game_configs
    backup_scripts
    create_manifest
    cleanup_old_backups
    show_summary
}

# Run backup
main "$@"