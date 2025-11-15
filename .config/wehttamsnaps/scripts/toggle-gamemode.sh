#!/bin/bash
# === WEHTTAMSNAPS GAMEMODE TOGGLER ===
# Switch between performance and normal modes

GAMING_CONFIG="$HOME/.config/wehttamsnaps/gaming-mode"
NIRI_CONFIG="$HOME/.config/niri/config.kdl"
EFFECTS_CONFIG="$HOME/.config/easyeffects/output.json"

# Check current gaming mode state
if [ -f "$GAMING_CONFIG" ]; then
    # Turn OFF gaming mode
    echo "🎮 Turning OFF gaming mode..."
    
    # Remove gaming config indicator
    rm -f "$GAMING_CONFIG"
    
    # Restore normal animations
    sed -i 's/enable false/enable true/g' "$HOME/.config/niri/conf.d/40-gaming.kdl"
    
    # Reset CPU governor
    sudo cpupower frequency-set -g ondemand
    
    # Reset GPU profile
    corectrl --set-profile "default" 2>/dev/null || true
    
    # Enable EasyEffects
    easyeffects --gapplication-service &
    
    # Restore normal gaps
    sed -i 's/gaps 8/gaps 16/g' "$HOME/.config/niri/conf.d/40-gaming.kdl"
    
    # Restart Niri to apply changes
    niri-msg action quit
    
    # Show notification
    notify-send "WehttamSnaps" "Gaming mode OFF - Performance normal" -u normal -i applications-games
    
else
    # Turn ON gaming mode
    echo "🚀 Turning ON gaming mode..."
    
    # Create gaming config indicator
    touch "$GAMING_CONFIG"
    
    # Disable animations for better performance
    sed -i 's/enable true/enable false/g' "$HOME/.config/niri/conf.d/40-gaming.kdl"
    
    # Set CPU governor to performance
    sudo cpupower frequency-set -g performance
    
    # Set GPU to performance mode
    corectrl --set-profile "performance" 2>/dev/null || true
    
    # Disable EasyEffects for lower latency
    pkill easyeffects
    
    # Reduce gaps for better game visibility
    sed -i 's/gaps 16/gaps 8/g' "$HOME/.config/niri/conf.d/40-gaming.kdl"
    
    # Restart Niri to apply changes
    niri-msg action quit
    
    # Show notification
    notify-send "WehttamSnaps" "Gaming mode ON - Maximum performance!" -u critical -i applications-games
fi