#!/bin/bash
# ===================================================================
# WehttamSnaps Game Saves Backup Script
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Backs up save files for Cyberpunk 2077, Fallout 4, and Starfield
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
    echo "║   WehttamSnaps Game Saves Backup            ║"
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

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_BASE=~/Documents/Game_Saves_Backup
BACKUP_DIR="$BACKUP_BASE/$TIMESTAMP"

# Game save paths
CYBERPUNK_SAVES=~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/Saved\ Games/CD\ Projekt\ Red/Cyberpunk\ 2077
FALLOUT4_SAVES=~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My\ Games/Fallout4
STARFIELD_SAVES=~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My\ Games/Starfield

# ===================================================================
# FUNCTIONS
# ===================================================================

get_dir_size() {
    if [ -d "$1" ]; then
        du -sh "$1" 2>/dev/null | cut -f1
    else
        echo "N/A"
    fi
}

count_files() {
    if [ -d "$1" ]; then
        find "$1" -type f 2>/dev/null | wc -l
    else
        echo "0"
    fi
}

backup_game() {
    local game_name=$1
    local source_dir=$2
    local dest_name=$3
    
    if [ ! -d "$source_dir" ]; then
        print_warning "$game_name: No saves found"
        return 1
    fi
    
    local file_count=$(count_files "$source_dir")
    local dir_size=$(get_dir_size "$source_dir")
    
    print_step "Backing up $game_name ($file_count files, $dir_size)..."
    
    # Create destination directory
    mkdir -p "$BACKUP_DIR/$dest_name"
    
    # Copy files
    if cp -r "$source_dir"/* "$BACKUP_DIR/$dest_name/" 2>/dev/null; then
        print_success "$game_name backed up successfully"
        echo "$BACKUP_DIR/$dest_name"
        return 0
    else
        print_error "$game_name backup failed"
        return 1
    fi
}

# ===================================================================
# BACKUP INDIVIDUAL GAME
# ===================================================================

backup_single_game() {
    local game=$1
    
    case $game in
        cyberpunk|cp|cp2077)
            print_header
            backup_game "Cyberpunk 2077" "$CYBERPUNK_SAVES" "Cyberpunk2077"
            ;;
        fallout|fallout4|fo4)
            print_header
            backup_game "Fallout 4" "$FALLOUT4_SAVES" "Fallout4"
            ;;
        starfield|sf)
            print_header
            backup_game "Starfield" "$STARFIELD_SAVES" "Starfield"
            ;;
        *)
            print_error "Unknown game: $game"
            echo "Usage: $0 [cyberpunk|fallout4|starfield]"
            exit 1
            ;;
    esac
}

# ===================================================================
# BACKUP ALL GAMES
# ===================================================================

backup_all_games() {
    print_header
    
    echo "Starting backup of all game saves..."
    echo "Backup location: $BACKUP_DIR"
    echo ""
    
    # Create main backup directory
    mkdir -p "$BACKUP_DIR"
    
    local success_count=0
    local total_count=0
    
    # Backup each game
    backup_game "Cyberpunk 2077" "$CYBERPUNK_SAVES" "Cyberpunk2077" && ((success_count++))
    ((total_count++))
    echo ""
    
    backup_game "Fallout 4" "$FALLOUT4_SAVES" "Fallout4" && ((success_count++))
    ((total_count++))
    echo ""
    
    backup_game "Starfield" "$STARFIELD_SAVES" "Starfield" && ((success_count++))
    ((total_count++))
    echo ""
    
    # Summary
    echo -e "${CYAN}═══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}Backup Complete!${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════${NC}"
    echo ""
    echo "Games backed up: $success_count/$total_count"
    echo "Backup location: $BACKUP_DIR"
    echo ""
    
    # Calculate total backup size
    if [ -d "$BACKUP_DIR" ]; then
        local total_size=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
        echo "Total backup size: $total_size"
    fi
    
    # Create backup log
    cat > "$BACKUP_DIR/backup_info.txt" << EOF
WehttamSnaps Game Saves Backup
==============================

Date: $(date)
Location: $BACKUP_DIR
Success: $success_count/$total_count games

Games Backed Up:
EOF
    
    [ -d "$BACKUP_DIR/Cyberpunk2077" ] && echo "- Cyberpunk 2077 ($(count_files "$BACKUP_DIR/Cyberpunk2077") files)" >> "$BACKUP_DIR/backup_info.txt"
    [ -d "$BACKUP_DIR/Fallout4" ] && echo "- Fallout 4 ($(count_files "$BACKUP_DIR/Fallout4") files)" >> "$BACKUP_DIR/backup_info.txt"
    [ -d "$BACKUP_DIR/Starfield" ] && echo "- Starfield ($(count_files "$BACKUP_DIR/Starfield") files)" >> "$BACKUP_DIR/backup_info.txt"
    
    print_success "Backup log saved: $BACKUP_DIR/backup_info.txt"
    echo ""
}

# ===================================================================
# LIST BACKUPS
# ===================================================================

list_backups() {
    print_header
    
    if [ ! -d "$BACKUP_BASE" ] || [ -z "$(ls -A "$BACKUP_BASE" 2>/dev/null)" ]; then
        print_warning "No backups found in $BACKUP_BASE"
        exit 0
    fi
    
    echo "Available backups:"
    echo ""
    
    local count=1
    for backup_dir in "$BACKUP_BASE"/*/; do
        if [ -d "$backup_dir" ]; then
            local backup_name=$(basename "$backup_dir")
            local backup_size=$(du -sh "$backup_dir" 2>/dev/null | cut -f1)
            local backup_date=$(stat -c %y "$backup_dir" 2>/dev/null | cut -d' ' -f1,2 | cut -d. -f1)
            
            echo -e "${GREEN}$count.${NC} $backup_name"
            echo "   Date: $backup_date"
            echo "   Size: $backup_size"
            echo "   Path: $backup_dir"
            
            # List games in backup
            echo "   Games:"
            [ -d "$backup_dir/Cyberpunk2077" ] && echo "     - Cyberpunk 2077"
            [ -d "$backup_dir/Fallout4" ] && echo "     - Fallout 4"
            [ -d "$backup_dir/Starfield" ] && echo "     - Starfield"
            
            echo ""
            ((count++))
        fi
    done
    
    echo "Total backups: $((count-1))"
}

# ===================================================================
# RESTORE BACKUP
# ===================================================================

restore_backup() {
    local backup_timestamp=$1
    
    print_header
    
    if [ -z "$backup_timestamp" ]; then
        print_error "Please specify backup timestamp"
        echo "Usage: $0 --restore YYYYMMDD-HHMMSS"
        echo ""
        echo "Available backups:"
        list_backups
        exit 1
    fi
    
    local restore_dir="$BACKUP_BASE/$backup_timestamp"
    
    if [ ! -d "$restore_dir" ]; then
        print_error "Backup not found: $restore_dir"
        list_backups
        exit 1
    fi
    
    print_warning "This will overwrite current save files!"
    echo "Restoring from: $restore_dir"
    echo ""
    
    read -p "Continue? (yes/no): " -r
    if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        echo "Restore cancelled"
        exit 0
    fi
    
    echo ""
    
    # Restore Cyberpunk
    if [ -d "$restore_dir/Cyberpunk2077" ]; then
        print_step "Restoring Cyberpunk 2077..."
        rm -rf "$CYBERPUNK_SAVES"
        mkdir -p "$(dirname "$CYBERPUNK_SAVES")"
        cp -r "$restore_dir/Cyberpunk2077" "$CYBERPUNK_SAVES"
        print_success "Cyberpunk 2077 restored"
    fi
    
    # Restore Fallout 4
    if [ -d "$restore_dir/Fallout4" ]; then
        print_step "Restoring Fallout 4..."
        rm -rf "$FALLOUT4_SAVES"
        mkdir -p "$(dirname "$FALLOUT4_SAVES")"
        cp -r "$restore_dir/Fallout4" "$FALLOUT4_SAVES"
        print_success "Fallout 4 restored"
    fi
    
    # Restore Starfield
    if [ -d "$restore_dir/Starfield" ]; then
        print_step "Restoring Starfield..."
        rm -rf "$STARFIELD_SAVES"
        mkdir -p "$(dirname "$STARFIELD_SAVES")"
        cp -r "$restore_dir/Starfield" "$STARFIELD_SAVES"
        print_success "Starfield restored"
    fi
    
    echo ""
    print_success "Restore complete!"
}

# ===================================================================
# AUTO BACKUP (for cron)
# ===================================================================

auto_backup() {
    # Silent backup for cron jobs
    mkdir -p "$BACKUP_DIR"
    
    cp -r "$CYBERPUNK_SAVES" "$BACKUP_DIR/Cyberpunk2077" 2>/dev/null || true
    cp -r "$FALLOUT4_SAVES" "$BACKUP_DIR/Fallout4" 2>/dev/null || true
    cp -r "$STARFIELD_SAVES" "$BACKUP_DIR/Starfield" 2>/dev/null || true
    
    # Keep only last 10 backups
    cd "$BACKUP_BASE"
    ls -t | tail -n +11 | xargs -r rm -rf
}

# ===================================================================
# CLEAN OLD BACKUPS
# ===================================================================

clean_old_backups() {
    local keep_count=${1:-10}
    
    print_header
    print_step "Cleaning old backups (keeping $keep_count newest)..."
    
    if [ ! -d "$BACKUP_BASE" ]; then
        print_warning "No backups directory found"
        exit 0
    fi
    
    cd "$BACKUP_BASE"
    
    local total=$(ls -1 | wc -l)
    local to_delete=$((total - keep_count))
    
    if [ $to_delete -le 0 ]; then
        print_success "No old backups to clean ($total backups)"
        exit 0
    fi
    
    print_warning "Will delete $to_delete old backup(s)"
    
    ls -t | tail -n +$((keep_count + 1)) | while read -r dir; do
        echo "  Deleting: $dir"
        rm -rf "$dir"
    done
    
    print_success "Cleaned $to_delete old backup(s)"
}

# ===================================================================
# MAIN
# ===================================================================

show_help() {
    print_header
    echo "Usage: $0 [option] [game]"
    echo ""
    echo "Options:"
    echo "  (none)              Backup all games"
    echo "  --game GAME         Backup specific game"
    echo "  --list              List available backups"
    echo "  --restore DATE      Restore backup from specific date"
    echo "  --auto              Auto backup (for cron)"
    echo "  --clean [N]         Clean old backups (keep N newest, default 10)"
    echo "  --help              Show this help"
    echo ""
    echo "Games:"
    echo "  cyberpunk, cp2077   Cyberpunk 2077"
    echo "  fallout4, fo4       Fallout 4"
    echo "  starfield, sf       Starfield"
    echo ""
    echo "Examples:"
    echo "  $0                           # Backup all games"
    echo "  $0 --game cyberpunk          # Backup only Cyberpunk"
    echo "  $0 --list                    # List backups"
    echo "  $0 --restore 20250109-143022 # Restore specific backup"
    echo "  $0 --clean 5                 # Keep only 5 newest backups"
    echo ""
}

main() {
    case "${1:-}" in
        --game)
            backup_single_game "$2"
            ;;
        --list)
            list_backups
            ;;
        --restore)
            restore_backup "$2"
            ;;
        --auto)
            auto_backup
            ;;
        --clean)
            clean_old_backups "${2:-10}"
            ;;
        --help|-h)
            show_help
            ;;
        "")
            backup_all_games
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
}

main "$@"