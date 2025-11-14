#!/bin/bash
# ===================================================================
# WehttamSnaps Performance Profile Switcher
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Switch between different performance profiles for gaming
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
    echo "║   Performance Profile Switcher               ║"
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

PROFILE_DIR="$HOME/.config/wehttamsnaps/performance-profiles"
CURRENT_PROFILE_FILE="$HOME/.config/wehttamsnaps/.current_profile"

mkdir -p "$PROFILE_DIR"

# ===================================================================
# PROFILE DEFINITIONS
# ===================================================================

apply_performance_profile() {
    print_step "Applying Performance profile..."
    
    # CPU Governor
    if command -v cpupower &>/dev/null; then
        sudo cpupower frequency-set -g performance &>/dev/null
        print_success "CPU: Performance governor"
    fi
    
    # AMD GPU
    if [ -f "/sys/class/drm/card0/device/power_dpm_force_performance_level" ]; then
        echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
        print_success "GPU: High performance mode"
    fi
    
    # Disable compositor effects (if supported)
    qs -c noctalia-shell ipc call animations disable &>/dev/null 2>&1 || true
    print_success "Compositor: Animations disabled"
    
    # Enable DND
    qs -c noctalia-shell ipc call notifications toggleDND &>/dev/null 2>&1 || true
    print_success "Notifications: Do Not Disturb enabled"
    
    # Swappiness
    sudo sysctl -w vm.swappiness=10 &>/dev/null
    print_success "Memory: Swappiness set to 10"
    
    # Environment variables for next launch
    cat > /tmp/wehttamsnaps-perf-env << 'EOF'
export RADV_PERFTEST=aco,sam,nggc
export AMD_VULKAN_ICD=RADV
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1
export mesa_glthread=true
export vblank_mode=0
EOF
    
    echo "performance" > "$CURRENT_PROFILE_FILE"
}

apply_balanced_profile() {
    print_step "Applying Balanced profile..."
    
    # CPU Governor
    if command -v cpupower &>/dev/null; then
        sudo cpupower frequency-set -g schedutil &>/dev/null
        print_success "CPU: Schedutil governor"
    fi
    
    # AMD GPU
    if [ -f "/sys/class/drm/card0/device/power_dpm_force_performance_level" ]; then
        echo "auto" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
        print_success "GPU: Auto mode"
    fi
    
    # Enable compositor effects
    qs -c noctalia-shell ipc call animations enable &>/dev/null 2>&1 || true
    print_success "Compositor: Animations enabled"
    
    # Normal notifications
    # (Don't toggle DND, leave as is)
    
    # Swappiness
    sudo sysctl -w vm.swappiness=60 &>/dev/null
    print_success "Memory: Swappiness set to 60"
    
    # Environment variables
    cat > /tmp/wehttamsnaps-perf-env << 'EOF'
export RADV_PERFTEST=aco
export DXVK_ASYNC=1
EOF
    
    echo "balanced" > "$CURRENT_PROFILE_FILE"
}

apply_powersave_profile() {
    print_step "Applying Power Save profile..."
    
    # CPU Governor
    if command -v cpupower &>/dev/null; then
        sudo cpupower frequency-set -g powersave &>/dev/null
        print_success "CPU: Powersave governor"
    fi
    
    # AMD GPU
    if [ -f "/sys/class/drm/card0/device/power_dpm_force_performance_level" ]; then
        echo "low" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
        print_success "GPU: Low power mode"
    fi
    
    # Enable compositor effects
    qs -c noctalia-shell ipc call animations enable &>/dev/null 2>&1 || true
    print_success "Compositor: Animations enabled"
    
    # Swappiness
    sudo sysctl -w vm.swappiness=100 &>/dev/null
    print_success "Memory: Swappiness set to 100"
    
    # Clear environment variables
    rm -f /tmp/wehttamsnaps-perf-env
    
    echo "powersave" > "$CURRENT_PROFILE_FILE"
}

# ===================================================================
# GAME-SPECIFIC PROFILES
# ===================================================================

apply_cyberpunk_profile() {
    print_step "Applying Cyberpunk 2077 profile..."
    
    # Start with performance base
    apply_performance_profile
    
    # Cyberpunk-specific tweaks
    cat > /tmp/wehttamsnaps-perf-env << 'EOF'
export RADV_PERFTEST=aco,sam,nggc
export AMD_VULKAN_ICD=RADV
export DXVK_ASYNC=1
export PROTON_NO_ESYNC=1
export WINEDLLOVERRIDES="version.dll=n,b;winmm.dll=n,b"
EOF
    
    print_success "Cyberpunk optimizations applied"
    echo "cyberpunk" > "$CURRENT_PROFILE_FILE"
}

apply_fallout4_profile() {
    print_step "Applying Fallout 4 profile..."
    
    # Start with performance base
    apply_performance_profile
    
    # Fallout 4-specific tweaks
    cat > /tmp/wehttamsnaps-perf-env << 'EOF'
export RADV_PERFTEST=aco,sam,nggc
export DXVK_ASYNC=1
export PROTON_NO_ESYNC=1
export PROTON_USE_WINED3D=0
EOF
    
    print_success "Fallout 4 optimizations applied"
    echo "fallout4" > "$CURRENT_PROFILE_FILE"
}

apply_starfield_profile() {
    print_step "Applying Starfield profile..."
    
    # Start with performance base
    apply_performance_profile
    
    # Starfield-specific tweaks
    cat > /tmp/wehttamsnaps-perf-env << 'EOF'
export RADV_PERFTEST=aco,sam,nggc
export DXVK_ASYNC=1
export PROTON_NO_ESYNC=1
export PROTON_ENABLE_NVAPI=1
EOF
    
    print_success "Starfield optimizations applied"
    echo "starfield" > "$CURRENT_PROFILE_FILE"
}

# ===================================================================
# STATUS & INFO
# ===================================================================

show_current_profile() {
    print_header
    
    if [ -f "$CURRENT_PROFILE_FILE" ]; then
        local current=$(cat "$CURRENT_PROFILE_FILE")
        echo "Current profile: $current"
    else
        echo "No profile active"
    fi
    
    echo ""
    echo "System Status:"
    echo "───────────────────────────────────────"
    
    # CPU
    if command -v cpupower &>/dev/null; then
        local governor=$(cpupower frequency-info | grep "current policy" | awk '{print $NF}')
        echo "CPU Governor: $governor"
    fi
    
    # GPU
    if [ -f "/sys/class/drm/card0/device/power_dpm_force_performance_level" ]; then
        local gpu_mode=$(cat /sys/class/drm/card0/device/power_dpm_force_performance_level)
        echo "GPU Mode: $gpu_mode"
    fi
    
    # Swappiness
    local swappiness=$(cat /proc/sys/vm/swappiness)
    echo "Swappiness: $swappiness"
    
    # Gamemode
    if command -v gamemoded &>/dev/null; then
        if gamemoded -s 2>/dev/null | grep -q "gamemode is active"; then
            echo "Gamemode: Active"
        else
            echo "Gamemode: Inactive"
        fi
    fi
}

# ===================================================================
# LIST PROFILES
# ===================================================================

list_profiles() {
    print_header
    echo "Available profiles:"
    echo ""
    
    echo -e "${GREEN}General Profiles:${NC}"
    echo "  • performance    - Maximum performance (gaming)"
    echo "  • balanced       - Balanced (everyday use)"
    echo "  • powersave      - Power saving (battery/idle)"
    echo ""
    
    echo -e "${GREEN}Game-Specific Profiles:${NC}"
    echo "  • cyberpunk      - Optimized for Cyberpunk 2077"
    echo "  • fallout4       - Optimized for Fallout 4"
    echo "  • starfield      - Optimized for Starfield"
    echo ""
}

# ===================================================================
# AUTO-DETECT GAME
# ===================================================================

auto_detect_game() {
    print_header
    print_step "Auto-detecting running game..."
    
    # Check for running games
    if pgrep -f "Cyberpunk2077.exe" > /dev/null; then
        echo "Detected: Cyberpunk 2077"
        apply_cyberpunk_profile
    elif pgrep -f "Fallout4.exe" > /dev/null || pgrep -f "f4se_loader.exe" > /dev/null; then
        echo "Detected: Fallout 4"
        apply_fallout4_profile
    elif pgrep -f "Starfield.exe" > /dev/null || pgrep -f "sfse_loader.exe" > /dev/null; then
        echo "Detected: Starfield"
        apply_starfield_profile
    else
        print_warning "No supported game detected"
        print_warning "Applying balanced profile"
        apply_balanced_profile
    fi
}

# ===================================================================
# CREATE CUSTOM PROFILE
# ===================================================================

create_custom_profile() {
    local name=$1
    
    print_header
    print_step "Creating custom profile: $name"
    
    local profile_file="$PROFILE_DIR/$name.sh"
    
    cat > "$profile_file" << 'EOF'
#!/bin/bash
# Custom Performance Profile

# CPU Governor (performance/schedutil/powersave)
CPU_GOVERNOR="performance"

# GPU Mode (high/auto/low)
GPU_MODE="high"

# Swappiness (0-100)
SWAPPINESS=10

# Compositor animations (true/false)
ANIMATIONS_ENABLED=false

# Environment variables
export RADV_PERFTEST=aco,sam,nggc
export DXVK_ASYNC=1

# Add your custom settings here
EOF
    
    chmod +x "$profile_file"
    
    print_success "Custom profile created: $profile_file"
    echo "Edit with: nano $profile_file"
}

# ===================================================================
# HELP
# ===================================================================

show_help() {
    print_header
    echo "Usage: $0 <profile>"
    echo ""
    echo "Profiles:"
    echo "  performance      Maximum performance"
    echo "  balanced         Balanced mode"
    echo "  powersave        Power saving"
    echo "  cyberpunk        Cyberpunk 2077 optimized"
    echo "  fallout4         Fallout 4 optimized"
    echo "  starfield        Starfield optimized"
    echo ""
    echo "Commands:"
    echo "  status           Show current profile"
    echo "  list             List all profiles"
    echo "  auto             Auto-detect game"
    echo "  create <n>       Create custom profile"
    echo ""
    echo "Examples:"
    echo "  $0 performance   # Gaming mode"
    echo "  $0 balanced      # Normal mode"
    echo "  $0 cyberpunk     # Cyberpunk optimized"
    echo "  $0 auto          # Auto-detect game"
}

# ===================================================================
# MAIN
# ===================================================================

main() {
    case "${1:-}" in
        performance)
            print_header
            apply_performance_profile
            echo ""
            print_success "Performance profile active"
            ;;
        balanced)
            print_header
            apply_balanced_profile
            echo ""
            print_success "Balanced profile active"
            ;;
        powersave)
            print_header
            apply_powersave_profile
            echo ""
            print_success "Power save profile active"
            ;;
        cyberpunk|cp2077)
            print_header
            apply_cyberpunk_profile
            echo ""
            print_success "Cyberpunk profile active"
            ;;
        fallout4|fo4)
            print_header
            apply_fallout4_profile
            echo ""
            print_success "Fallout 4 profile active"
            ;;
        starfield|sf)
            print_header
            apply_starfield_profile
            echo ""
            print_success "Starfield profile active"
            ;;
        status)
            show_current_profile
            ;;
        list)
            list_profiles
            ;;
        auto)
            auto_detect_game
            ;;
        create)
            create_custom_profile "$2"
            ;;
        --help|-h|"")
            show_help
            ;;
        *)
            print_error "Unknown profile: $1"
            show_help
            exit 1
            ;;
    esac
}

main "$@"