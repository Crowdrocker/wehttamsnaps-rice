#!/bin/bash
# === WEHTTAMSNAPS - LAUNCH GAME WITH MODS ===
# Smart game launcher that detects and launches with appropriate mod manager

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Game detection and launching
echo -e "${BLUE}[INFO] WehttamSnaps Game Launcher with Mods${NC}"

# Detect which mod managers are available
detect_mod_managers() {
    echo -e "${YELLOW}[DETECT] Scanning for mod managers...${NC}"
    
    MANAGERS=()
    
    if pgrep -f "vortex" > /dev/null || command -v vortex &> /dev/null; then
        MANAGERS+=("vortex")
        echo -e "${GREEN}[FOUND] Vortex mod manager${NC}"
    fi
    
    if [ -d "$HOME/.config/modorganizer2" ] || command -v modorganizer2 &> /dev/null; then
        MANAGERS+=("mo2")
        echo -e "${GREEN}[FOUND] Mod Organizer 2${NC}"
    fi
    
    if command -v steamtinkerlaunch &> /dev/null; then
        MANAGERS+=("stl")
        echo -e "${GREEN}[FOUND] SteamTinkerLaunch${NC}"
    fi
    
    if [ ${#MANAGERS[@]} -eq 0 ]; then
        echo -e "${RED}[ERROR] No mod managers found${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}[OK] Found ${#MANAGERS[@]} mod manager(s)${NC}"
}

# Detect recently played games
detect_games() {
    echo -e "${YELLOW}[DETECT] Finding recently played games...${NC}"
    
    GAMES=()
    
    # Check Steam recent games
    if [ -f "$HOME/.steam/steam/config/loginusers.vdf" ]; then
        # Extract recent game IDs (simplified)
        echo -e "${BLUE}[INFO] Checking Steam library...${NC}"
        
        # Common moddable games
        if [ -d "$HOME/.local/share/Steam/steamapps/common/Skyrim Special Edition" ]; then
            GAMES+=("Skyrim Special Edition:490")
        fi
        
        if [ -d "$HOME/.local/share/Steam/steamapps/common/Skyrim" ]; then
            GAMES+=("Skyrim AE:72850")
        fi
        
        if [ -d "$HOME/.local/share/Steam/steamapps/common/Fallout 4" ]; then
            GAMES+=("Fallout 4:377160")
        fi
        
        if [ -d "$HOME/.local/share/Steam/steamapps/common/Fallout 3" ]; then
            GAMES+=("Fallout 3:22300")
        fi
        
        if [ -d "$HOME/.local/share/Steam/steamapps/common/Morrowind" ]; then
            GAMES+=("Morrowind:22320")
        fi
        
        if [ -d "$HOME/.local/share/Steam/steamapps/common/Oblivion" ]; then
            GAMES+=("Oblivion:22330")
        fi
        
        echo -e "${GREEN}[OK] Found ${#GAMES[@]} moddable games${NC}"
    fi
}

# Show game selection menu
show_game_menu() {
    echo -e "${YELLOW}[SELECT] Choose game to launch:${NC}"
    
    local i=1
    for game in "${GAMES[@]}"; do
        local name=$(echo "$game" | cut -d: -f1)
        echo -e "   ${BLUE}$i)${NC} $name"
        ((i++))
    done
    
    echo -e "   ${BLUE}c)${NC} Custom game ID"
    echo -e "   ${BLUE}q)${NC} Quit"
    
    read -p "Select game [1-${#GAMES[@]},c,q]: " choice
    
    case "$choice" in
        [1-9]|[1-9][0-9])
            if [ "$choice" -le "${#GAMES[@]}" ]; then
                SELECTED_GAME="${GAMES[$((choice-1))]}"
            else
                echo -e "${RED}[ERROR] Invalid selection${NC}"
                exit 1
            fi
            ;;
        c|C)
            read -p "Enter custom game ID: " custom_id
            read -p "Enter game name: " custom_name
            SELECTED_GAME="$custom_name:$custom_id"
            ;;
        q|Q)
            echo -e "${YELLOW}[INFO] Exiting launcher${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}[ERROR] Invalid selection${NC}"
            exit 1
            ;;
    esac
}

# Show mod manager selection
show_mod_manager_menu() {
    echo -e "${YELLOW}[SELECT] Choose mod manager:${NC}"
    
    local i=1
    for manager in "${MANAGERS[@]}"; do
        case "$manager" in
            vortex)
                echo -e "   ${PURPLE}$i)${NC} Vortex (Recommended for beginners)"
                ;;
            mo2)
                echo -e "   ${GREEN}$i)${NC} Mod Organizer 2 (Advanced users)"
                ;;
            stl)
                echo -e "   ${BLUE}$i)${NC} SteamTinkerLaunch (Steam integration)"
                ;;
        esac
        ((i++))
    done
    
    echo -e "   ${BLUE}q)${NC} Quit"
    
    read -p "Select mod manager [1-${#MANAGERS[@]},q]: " choice
    
    case "$choice" in
        [1-9]|[1-9][0-9])
            if [ "$choice" -le "${#MANAGERS[@]}" ]; then
                SELECTED_MANAGER="${MANAGERS[$((choice-1))]}"
            else
                echo -e "${RED}[ERROR] Invalid selection${NC}"
                exit 1
            fi
            ;;
        q|Q)
            echo -e "${YELLOW}[INFO] Exiting launcher${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}[ERROR] Invalid selection${NC}"
            exit 1
            ;;
    esac
}

# Launch game with selected mod manager
launch_game() {
    local game_name=$(echo "$SELECTED_GAME" | cut -d: -f1)
    local game_id=$(echo "$SELECTED_GAME" | cut -d: -f2)
    
    echo -e "${BLUE}[LAUNCH] Starting $game_name with $SELECTED_MANAGER...${NC}"
    
    case "$SELECTED_MANAGER" in
        vortex)
            # Launch through Vortex
            echo -e "${YELLOW}[VORTEX] Launching through Vortex mod manager${NC}"
            vortex &
            sleep 3
            echo -e "${GREEN}[INFO] Use Vortex to deploy mods and launch game${NC}"
            ;;
        mo2)
            # Launch through Mod Organizer 2
            echo -e "${YELLOW}[MO2] Launching through Mod Organizer 2${NC}"
            modorganizer2 &
            sleep 3
            echo -e "${GREEN}[INFO] Use MO2 to manage mods and launch game${NC}"
            ;;
        stl)
            # Launch through SteamTinkerLaunch
            echo -e "${YELLOW}[STL] Launching through SteamTinkerLaunch${NC}"
            steamtinkerlaunch game "$game_id"
            ;;
    esac
    
    echo -e "${GREEN}🎮 Game launched with mods!${NC}"
}

# Enable GameMode for performance
enable_gamemode() {
    if command -v gamemoded &> /dev/null; then
        if ! gamemoded -s | grep -q "GameMode is active"; then
            echo -e "${YELLOW}[GAMEMODE] Activating GameMode for better performance...${NC}"
            export gamemoderun=1
        fi
    fi
}

# Main function
main() {
    enable_gamemode
    detect_mod_managers
    detect_games
    show_game_menu
    show_mod_manager_menu
    launch_game
}

# Run launcher
main "$@"