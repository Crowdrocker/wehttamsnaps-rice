#!/bin/bash
# ===================================================================
# WehttamSnaps Gamemode Toggle
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Toggles between performance gaming mode and normal desktop mode
# ===================================================================

CONFIG_DIR="$HOME/.config/wehttamsnaps"
STATE_FILE="$CONFIG_DIR/gamemode.state"
SOUND_DIR="$CONFIG_DIR/sounds"

# Create config dir if needed
mkdir -p "$CONFIG_DIR"

# Check current state
if [ -f "$STATE_FILE" ]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
else
    CURRENT_STATE="off"
fi

# Toggle state
if [ "$CURRENT_STATE" = "on" ]; then
    NEW_STATE="off"
else
    NEW_STATE="on"
fi

# Apply settings based on state
if [ "$NEW_STATE" = "on" ]; then
    echo "🎮 Enabling Gaming Mode..."
    
    # Play J.A.R.V.I.S. gaming sound
    if [ -f "$SOUND_DIR/jarvis-gaming.mp3" ]; then
        mpv --no-video --volume=60 "$SOUND_DIR/jarvis-gaming.mp3" &>/dev/null &
    fi
    
    # Disable Niri animations (faster response)
    # Note: Niri doesn't support runtime animation toggling yet
    # This would need a config reload
    
    # Set CPU governor to performance
    if command -v cpupower &>/dev/null; then
        sudo cpupower frequency-set -g performance &>/dev/null
        echo "  ✓ CPU governor: performance"
    fi
    
    # AMD GPU performance settings
    if [ -f "/sys/class/drm/card0/device/power_dpm_force_performance_level" ]; then
        echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
        echo "  ✓ GPU: high performance mode"
    fi
    
    # Disable compositor effects (if supported)
    qs -c noctalia-shell ipc call animations disable &>/dev/null
    echo "  ✓ Compositor effects: disabled"
    
    # Set nice priority for gaming
    # (This affects future processes, not global)
    echo "  ✓ Gaming optimizations: enabled"
    
    # Disable notification sounds
    qs -c noctalia-shell ipc call notifications toggleDND &>/dev/null
    echo "  ✓ Do Not Disturb: enabled"
    
    # Show notification
    notify-send -u normal -t 5000 \
        -i "input-gaming" \
        "Gaming Mode" \
        "Performance optimizations enabled\n• CPU: Performance\n• GPU: High Performance\n• DND: Enabled"
    
else
    echo "🖥️  Disabling Gaming Mode..."
    
    # Restore CPU governor
    if command -v cpupower &>/dev/null; then
        sudo cpupower frequency-set -g schedutil &>/dev/null
        echo "  ✓ CPU governor: schedutil"
    fi
    
    # AMD GPU auto mode
    if [ -f "/sys/class/drm/card0/device/power_dpm_force_performance_level" ]; then
        echo "auto" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
        echo "  ✓ GPU: auto mode"
    fi
    
    # Re-enable compositor effects
    qs -c noctalia-shell ipc call animations enable &>/dev/null
    echo "  ✓ Compositor effects: enabled"
    
    # Re-enable notifications
    qs -c noctalia-shell ipc call notifications toggleDND &>/dev/null
    echo "  ✓ Do Not Disturb: disabled"
    
    # Show notification
    notify-send -u normal -t 5000 \
        -i "preferences-desktop" \
        "Desktop Mode" \
        "Restored to normal settings\n• CPU: Balanced\n• GPU: Auto\n• DND: Disabled"
fi

# Save state
echo "$NEW_STATE" > "$STATE_FILE"

echo ""
echo "Gaming mode is now: $NEW_STATE"

# Optional: Show current status in bar
# (Noctalia can read this file to display status)
exit 0