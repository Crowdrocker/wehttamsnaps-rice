#!/bin/bash
# ===================================================================
# WehttamSnaps Gaming Performance Optimizer
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Applies system-wide gaming optimizations for RX 580
# Run once before gaming session
# ===================================================================

echo "🎮 WehttamSnaps Gaming Optimizer"
echo "=================================="
echo ""

# Check if running as root for some operations
NEEDS_SUDO=false

# ===================================================================
# AMD RX 580 OPTIMIZATIONS
# ===================================================================

echo "📊 AMD RX 580 Optimizations..."

# Enable AMD GPU optimizations
export RADV_PERFTEST=aco,sam,nggc
export AMD_VULKAN_ICD=RADV
export RADV_DEBUG=zerovram

# Mesa optimizations
export mesa_glthread=true
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi

# DRI optimizations
export vblank_mode=0

echo "  ✓ RADV optimizations enabled"
echo "  ✓ ACO compiler enabled"
echo "  ✓ SAM (Smart Access Memory) enabled"
echo "  ✓ NGG culling enabled"
echo ""

# ===================================================================
# PROTON OPTIMIZATIONS
# ===================================================================

echo "🎯 Proton/Wine Optimizations..."

# Proton optimizations
export PROTON_USE_WINED3D=0
export PROTON_NO_ESYNC=0
export PROTON_NO_FSYNC=0
export PROTON_FORCE_LARGE_ADDRESS_AWARE=1

# DXVK optimizations
export DXVK_HUD=fps,devinfo,gpuload
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1
export DXVK_LOG_LEVEL=none

# VKD3D optimizations
export VKD3D_CONFIG=dxr
export VKD3D_SHADER_DEBUG=none

# Wine optimizations
export WINE_CPU_TOPOLOGY=8:4  # 4 cores, 8 threads for i7-4790
export WINEDEBUG=-all
export STAGING_SHARED_MEMORY=1

echo "  ✓ DXVK async enabled"
echo "  ✓ State cache enabled"
echo "  ✓ CPU topology configured"
echo ""

# ===================================================================
# SYSTEM OPTIMIZATIONS
# ===================================================================

echo "⚙️  System Optimizations..."

# CPU governor (needs sudo)
if command -v cpupower &>/dev/null; then
    if sudo -n cpupower frequency-set -g performance &>/dev/null 2>&1; then
        echo "  ✓ CPU governor: performance"
    else
        echo "  ⚠ CPU governor: needs sudo"
        NEEDS_SUDO=true
    fi
fi

# Disable CPU mitigations for performance (check current)
MITIGATIONS=$(cat /proc/cmdline | grep -o 'mitigations=[^ ]*')
if [ -n "$MITIGATIONS" ]; then
    echo "  ℹ CPU mitigations: $MITIGATIONS"
else
    echo "  ℹ CPU mitigations: default (consider disabling for more FPS)"
fi

# I/O scheduler for gaming
if [ -f /sys/block/sda/queue/scheduler ]; then
    CURRENT_SCHED=$(cat /sys/block/sda/queue/scheduler | grep -o '\[.*\]' | tr -d '[]')
    echo "  ℹ I/O scheduler: $CURRENT_SCHED (mq-deadline recommended for SSD)"
fi

# Swappiness for gaming (lower = less swapping)
CURRENT_SWAP=$(cat /proc/sys/vm/swappiness)
if [ "$CURRENT_SWAP" -gt 10 ]; then
    if sudo -n sysctl -w vm.swappiness=10 &>/dev/null 2>&1; then
        echo "  ✓ Swappiness: 10 (reduced)"
    else
        echo "  ℹ Swappiness: $CURRENT_SWAP (10 recommended)"
        NEEDS_SUDO=true
    fi
else
    echo "  ✓ Swappiness: $CURRENT_SWAP (optimal)"
fi

echo ""

# ===================================================================
# GAMEMODE
# ===================================================================

echo "🚀 GameMode Setup..."

if command -v gamemoderun &>/dev/null; then
    echo "  ✓ GameMode available"
    echo "  → Use: gamemoderun %command% in Steam launch options"
else
    echo "  ✗ GameMode not installed"
    echo "  → Install: sudo pacman -S gamemode"
fi

echo ""

# ===================================================================
# MANGOHUD
# ===================================================================

echo "📈 MangoHud Setup..."

if command -v mangohud &>/dev/null; then
    echo "  ✓ MangoHud available"
    echo "  → Use: mangohud %command% in Steam launch options"
    
    # Create MangoHud config if it doesn't exist
    MANGOHUD_CONFIG="$HOME/.config/MangoHud/MangoHud.conf"
    if [ ! -f "$MANGOHUD_CONFIG" ]; then
        mkdir -p "$(dirname "$MANGOHUD_CONFIG")"
        cat > "$MANGOHUD_CONFIG" << 'EOF'
# WehttamSnaps MangoHud Config
fps_limit=0
vsync=0
gl_vsync=0

# Display
position=top-right
width=280
height=140
background_alpha=0.5
font_size=20

# Metrics
fps
frametime
cpu_temp
gpu_temp
vram
ram
cpu_stats
gpu_stats

# Colors (WehttamSnaps theme)
text_color=cdd6f4
gpu_color=89b4fa
cpu_color=a6e3a1
vram_color=f9e2af
ram_color=f5c2e7
engine_color=94e2d5
io_color=fab387
frametime_color=89b4fa
background_color=1e1e2e
media_player_color=cdd6f4
EOF
        echo "  ✓ MangoHud config created"
    else
        echo "  ✓ MangoHud config exists"
    fi
else
    echo "  ✗ MangoHud not installed"
    echo "  → Install: sudo pacman -S mangohud"
fi

echo ""

# ===================================================================
# GAME-SPECIFIC FIXES
# ===================================================================

echo "🎯 Game-Specific Optimization Tips..."
echo ""
echo "Division 2 (fixes crashes):"
echo "  PROTON_USE_WINED3D=1 DXVK_ASYNC=1 gamemoderun %command%"
echo ""
echo "Cyberpunk 2077 (fixes crashes):"
echo "  gamemoderun PROTON_NO_ESYNC=1 DXVK_ASYNC=1 %command%"
echo ""
echo "General (best compatibility):"
echo "  gamemoderun mangohud DXVK_ASYNC=1 %command%"
echo ""

# ===================================================================
# STEAM LAUNCH OPTIONS TEMPLATES
# ===================================================================

echo "🎮 Recommended Steam Launch Options:"
echo "───────────────────────────────────────"
echo ""
echo "For most games:"
echo "  gamemoderun mangohud DXVK_ASYNC=1 %command%"
echo ""
echo "For older/problematic games (like Division 2):"
echo "  PROTON_USE_WINED3D=1 DXVK_ASYNC=1 gamemoderun %command%"
echo ""
echo "For FSR upscaling (AMD):"
echo "  WINE_FULLSCREEN_FSR=1 gamemoderun mangohud %command%"
echo ""
echo "With Gamescope (for better compatibility):"
echo "  gamescope -w 1920 -h 1080 -f -- gamemoderun %command%"
echo ""

# ===================================================================
# FINAL TIPS
# ===================================================================

echo "💡 Additional Tips:"
echo "──────────────────"
echo "1. Update GPU drivers: sudo pacman -S mesa vulkan-radeon"
echo "2. Use Proton-GE for better game compatibility"
echo "3. Enable Steam shader pre-caching in settings"
echo "4. Close unnecessary background apps (browsers, etc.)"
echo "5. Use Mod+G to toggle gaming mode before playing"
echo "6. Check ProtonDB for game-specific fixes"
echo ""

if [ "$NEEDS_SUDO" = true ]; then
    echo "⚠️  Some optimizations need sudo access"
    echo "   Run: sudo $0"
    echo ""
fi

# ===================================================================
# EXPORT VARIABLES TO ENVIRONMENT
# ===================================================================

# Save environment for current session
cat > /tmp/wehttamsnaps-gaming-env << EOF
export RADV_PERFTEST=aco,sam,nggc
export AMD_VULKAN_ICD=RADV
export RADV_DEBUG=zerovram
export mesa_glthread=true
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi
export vblank_mode=0
export DXVK_HUD=fps,devinfo,gpuload
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1
export PROTON_FORCE_LARGE_ADDRESS_AWARE=1
export WINE_CPU_TOPOLOGY=8:4
EOF

echo "✓ Environment variables set for this session"
echo ""
echo "To apply these settings permanently, add them to ~/.profile or ~/.zshrc"
echo ""
echo "Gaming optimization complete! 🎮"
echo ""

exit 0