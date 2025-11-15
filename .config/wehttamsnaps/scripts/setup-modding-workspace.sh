#!/bin/bash
# === WEHTTAMSNAPS - MODDING WORKSPACE SETUP ===
# Organize workspaces for optimal modding workflow

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}[INFO] Setting up WehttamSnaps modding workspace...${NC}"

# Create modding directories
create_directories() {
    echo -e "${YELLOW}[SETUP] Creating modding directories...${NC}"
    
    directories=(
        "$HOME/.local/share/modding"
        "$HOME/.local/share/modding/downloads"
        "$HOME/.local/share/modding/tools"
        "$HOME/.local/share/modding/backups"
        "$HOME/.local/share/modding/cache"
        "$HOME/.local/share/modding/profiles"
        "$HOME/.local/share/modding/logs"
        "$HOME/.local/share/modding/docs"
        "$HOME/.local/share/modding/scripts"
    )
    
    for dir in "${directories[@]}"; do
        mkdir -p "$dir"
        echo -e "${GREEN}[OK] Created $dir${NC}"
    done
}

# Set up workspace 3 for modding tools
setup_workspace3() {
    echo -e "${YELLOW}[SETUP] Configuring Workspace 3 - Modding Tools${NC}"
    
    # Open modding tools in workspace 3
    niri-msg action focus-workspace 3
    
    # Open primary modding tools
    if command -v steamtinkerlaunch &> /dev/null; then
        echo -e "${BLUE}[LAUNCH] Opening SteamTinkerLaunch...${NC}"
        steamtinkerlaunch &
        sleep 2
    fi
    
    if command -v vortex &> /dev/null; then
        echo -e "${BLUE}[LAUNCH] Opening Vortex...${NC}"
        vortex &
        sleep 2
    fi
    
    echo -e "${GREEN}[OK] Workspace 3 configured for modding tools${NC}"
}

# Set up workspace 4 for file management
setup_workspace4() {
    echo -e "${YELLOW}[SETUP] Configuring Workspace 4 - File Management${NC}"
    
    niri-msg action focus-workspace 4
    
    # Open modding directories in file manager
    echo -e "${BLUE}[LAUNCH] Opening modding file manager...${NC}"
    thunar "$HOME/.local/share/modding/" &
    sleep 1
    
    # Open downloads folder separately
    thunar "$HOME/.local/share/modding/downloads/" &
    sleep 1
    
    # Open tools folder
    thunar "$HOME/.local/share/modding/tools/" &
    
    echo -e "${GREEN}[OK] Workspace 4 configured for file management${NC}"
}

# Set up workspace 5 for web tools
setup_workspace5() {
    echo -e "${YELLOW}[SETUP] Configuring Workspace 5 - Web Tools${NC}"
    
    niri-msg action focus-workspace 5
    
    # Launch modding webapps
    echo -e "${BLUE}[LAUNCH] Opening modding web tools...${NC}"
    
    if [ -f "$HOME/.config/wehttamsnaps/webapps/nexusmods.sh" ]; then
        sh "$HOME/.config/wehttamsnaps/webapps/nexusmods.sh" &
        sleep 2
    fi
    
    if [ -f "$HOME/.config/wehttamsnaps/webapps/modding-discord.sh" ]; then
        sh "$HOME/.config/wehttamsnaps/webapps/modding-discord.sh" &
        sleep 2
    fi
    
    echo -e "${GREEN}[OK] Workspace 5 configured for web tools${NC}"
}

# Create workspace configuration file
create_workspace_config() {
    echo -e "${YELLOW}[SETUP] Creating workspace configuration...${NC}"
    
    cat > "$HOME/.config/wehttamsnaps/modding-workspaces.json" << 'EOF'
{
  "workspaces": {
    "3": {
      "name": "Modding Tools",
      "purpose": "SteamTinkerLaunch, Vortex, MO2, Wabbajack",
      "applications": ["steamtinkerlaunch", "vortex", "modorganizer2", "wabbajack"],
      "layout": "floating"
    },
    "4": {
      "name": "File Management", 
      "purpose": "Mod downloads, tools, backups",
      "applications": ["thunar"],
      "layout": "floating"
    },
    "5": {
      "name": "Web Tools",
      "purpose": "Nexus Mods, documentation, Discord",
      "applications": ["brave-browser"],
      "layout": "floating"
    }
  },
  "keybinds": {
    "Super+Ctrl+3": "Focus modding tools workspace",
    "Super+Ctrl+4": "Focus file management workspace", 
    "Super+Ctrl+5": "Focus web tools workspace",
    "Super+Alt+M": "Setup modding workspaces"
  }
}
EOF
    
    echo -e "${GREEN}[OK] Workspace configuration created${NC}"
}

# Create modding environment variables
create_environment() {
    echo -e "${YELLOW}[SETUP] Setting up modding environment...${NC}"
    
    cat > "$HOME/.config/wehttamsnaps/modding-env" << 'EOF'
# WehttamSnaps Modding Environment Variables
export MODDING_HOME="$HOME/.local/share/modding"
export MODDING_DOWNLOADS="$MODDING_HOME/downloads"
export MODDING_TOOLS="$MODDING_HOME/tools"
export MODDING_BACKUPS="$MODDING_HOME/backups"
export MODDING_CACHE="$MODDING_HOME/cache"
export MODDING_PROFILES="$MODDING_HOME/profiles"
export MODDING_LOGS="$MODDING_HOME/logs"

# SteamTinkerLaunch
export STL_HOME="$HOME/.config/steamtinkerlaunch"
export STL_LOGS="$STL_HOME/logs"

# Vortex
export VORTEX_HOME="$HOME/.config/vortex"
export VORTEX_GAMES="$VORTEX_HOME/games"

# Mod Organizer 2
export MO2_HOME="$HOME/.config/modorganizer2"
export MO2_PROFILES="$MO2_HOME/profiles"

# Wabbajack
export WABBAJACK_HOME="$HOME/.local/share/wabbajack"
export WABBAJACK_DOWNLOADS="$WABBAJACK_HOME/downloads"

# Game paths (adjust for your setup)
export SKYRIM_SE_HOME="$HOME/.local/share/Steam/steamapps/common/Skyrim Special Edition"
export FALLOUT4_HOME="$HOME/.local/share/Steam/steamapps/common/Fallout 4"
export SKYRIM_AE_HOME="$HOME/.local/share/Steam/steamapps/common/Skyrim"
EOF
    
    echo -e "${GREEN}[OK] Environment variables configured${NC}"
}

# Show setup summary
show_summary() {
    echo ""
    echo -e "${GREEN}🎮 WehttamSnaps Modding Workspace Setup Complete!${NC}"
    echo ""
    echo -e "${YELLOW}📋 Workspace Organization:${NC}"
    echo -e "   • Workspace 3: Modding Tools (STL, Vortex, MO2, Wabbajack)"
    echo -e "   • Workspace 4: File Management (Downloads, Tools, Backups)"
    echo -e "   • Workspace 5: Web Tools (Nexus Mods, Discord, Documentation)"
    echo ""
    echo -e "${YELLOW}🚀 Quick Access:${NC}"
    echo -e "   • Super+Ctrl+3/4/5: Switch to modding workspaces"
    echo -e "   • Super+Alt+M: Re-setup modding workspaces"
    echo -e "   • Super+Shift+T/V/M/W: Launch modding tools"
    echo ""
    echo -e "${YELLOW}📁 Modding Directories:${NC}"
    echo -e "   • ~/.local/share/modding/ - Main modding directory"
    echo -e "   • downloads/ - Mod downloads and archives"
    echo -e "   • tools/ - Modding utilities and CLI tools"
    echo -e "   • backups/ - Configuration and profile backups"
    echo -e "   • cache/ - Temporary files and caches"
    echo ""
    echo -e "${BLUE}💡 Tip: Use the modding keybinds help (Super+Shift+Alt+H) for quick reference!${NC}"
}

# Main function
main() {
    create_directories
    setup_workspace3
    setup_workspace4
    setup_workspace5
    create_workspace_config
    create_environment
    show_summary
}

# Run setup
main "$@"