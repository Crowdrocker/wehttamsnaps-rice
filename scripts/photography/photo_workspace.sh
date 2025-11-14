#!/bin/bash
# ===================================================================
# WehttamSnaps Photography Workspace Layout
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Creates optimal window layout for photo editing workflow
# ===================================================================

echo "📷 Setting up Photography Workspace..."

# Target workspace
WORKSPACE=2

# Switch to photography workspace
niri msg action focus-workspace "$WORKSPACE"

sleep 0.5

# ===================================================================
# CLOSE EXISTING WINDOWS ON WORKSPACE
# ===================================================================

# Get windows on current workspace and close them
# (Optional - uncomment if you want clean slate)
# niri msg action close-window --workspace "$WORKSPACE"

# ===================================================================
# LAUNCH PRIMARY EDITOR
# ===================================================================

# Detect which photo editor user prefers
PHOTO_EDITOR=""

if command -v darktable &>/dev/null; then
    PHOTO_EDITOR="darktable"
elif command -v rawtherapee &>/dev/null; then
    PHOTO_EDITOR="rawtherapee"
elif command -v gimp &>/dev/null; then
    PHOTO_EDITOR="gimp"
fi

if [ -n "$PHOTO_EDITOR" ]; then
    echo "  ✓ Launching $PHOTO_EDITOR..."
    $PHOTO_EDITOR &>/dev/null &
    EDITOR_PID=$!
    
    # Wait for window to appear
    sleep 2
    
    # Set window to 70% width
    niri msg action set-column-width --window-id="$EDITOR_PID" 70% 2>/dev/null
else
    echo "  ⚠ No photo editor found (darktable, rawtherapee, or gimp)"
fi

# ===================================================================
# LAUNCH FILE BROWSER
# ===================================================================

echo "  ✓ Launching file browser..."

# Open Pictures directory in Thunar
thunar "$HOME/Pictures" &>/dev/null &
THUNAR_PID=$!

sleep 1.5

# Position file browser (30% width, on the left)
niri msg action move-column-left 2>/dev/null
niri msg action set-column-width 30% 2>/dev/null

# ===================================================================
# OPTIONAL: LAUNCH REFERENCE IMAGE VIEWER
# ===================================================================

# If you have reference images, open them
REFERENCE_DIR="$HOME/Pictures/Reference"
if [ -d "$REFERENCE_DIR" ]; then
    # Check for image viewer
    if command -v nomacs &>/dev/null; then
        echo "  ✓ Launching reference image viewer..."
        nomacs "$REFERENCE_DIR" &>/dev/null &
        sleep 1
        # This will appear as a floating window
    fi
fi

# ===================================================================
# APPLY COLOR PROFILE
# ===================================================================

# If using color management, set display profile
if command -v colormgr &>/dev/null; then
    echo "  ✓ Applying color profile..."
    
    # Find sRGB profile (standard for most work)
    PROFILE=$(colormgr find-profile sRGB 2>/dev/null | head -n1)
    
    if [ -n "$PROFILE" ]; then
        # Get device ID
        DEVICE=$(colormgr find-device HDMI-A-1 2>/dev/null | head -n1)
        
        if [ -n "$DEVICE" ]; then
            colormgr device-add-profile "$DEVICE" "$PROFILE" 2>/dev/null
            colormgr device-make-profile-default "$DEVICE" "$PROFILE" 2>/dev/null
            echo "    → sRGB profile applied"
        fi
    fi
fi

# ===================================================================
# ADJUST SYSTEM SETTINGS FOR PHOTO WORK
# ===================================================================

echo "  ✓ Optimizing system for photo editing..."

# Disable notifications temporarily
qs -c noctalia-shell ipc call notifications toggleDND &>/dev/null

# Set night light OFF (for accurate colors)
if command -v wlsunset &>/dev/null; then
    pkill wlsunset 2>/dev/null
    echo "    → Night light disabled"
fi

# Increase screen brightness to 100% (for accurate color viewing)
if command -v brightnessctl &>/dev/null; then
    brightnessctl set 100% &>/dev/null
    echo "    → Brightness set to 100%"
fi

# ===================================================================
# NOTIFICATION
# ===================================================================

notify-send -u normal -t 5000 \
    -i "camera-photo" \
    "Photography Workspace" \
    "Workspace optimized for photo editing\n• Color profile: sRGB\n• DND: Enabled\n• Brightness: 100%"

# ===================================================================
# SAVE WORKSPACE STATE
# ===================================================================

# Save current state for restoration later
CONFIG_DIR="$HOME/.config/wehttamsnaps"
STATE_FILE="$CONFIG_DIR/photo-workspace.state"

cat > "$STATE_FILE" << EOF
# Photography Workspace State
# Created: $(date)

WORKSPACE=$WORKSPACE
EDITOR=$PHOTO_EDITOR
EDITOR_PID=$EDITOR_PID
THUNAR_PID=$THUNAR_PID
DND_ENABLED=true
BRIGHTNESS=100
EOF

echo ""
echo "✅ Photography workspace ready!"
echo ""
echo "Layout:"
echo "  • Left (30%):  File browser (Pictures)"
echo "  • Right (70%): $PHOTO_EDITOR"
echo ""
echo "Settings:"
echo "  • Do Not Disturb: ON"
echo "  • Color Profile: sRGB"
echo "  • Brightness: 100%"
echo ""
echo "Restore normal settings with:"
echo "  bash ~/.config/wehttamsnaps/scripts/photography/restore-normal.sh"
echo ""

# ===================================================================
# CREATE RESTORE SCRIPT
# ===================================================================

cat > "$HOME/.config/wehttamsnaps/scripts/photography/restore-normal.sh" << 'EOF'
#!/bin/bash
# Restore normal desktop settings after photo work

echo "Restoring normal settings..."

# Re-enable notifications
qs -c noctalia-shell ipc call notifications toggleDND &>/dev/null
echo "  ✓ Notifications enabled"

# Restore brightness to auto
if command -v brightnessctl &>/dev/null; then
    brightnessctl set 60% &>/dev/null
    echo "  ✓ Brightness restored"
fi

# Re-enable night light (if it was enabled before)
if command -v wlsunset &>/dev/null; then
    wlsunset -l 40.8 -L -96.7 &>/dev/null &  # Lincoln, NE coordinates
    echo "  ✓ Night light enabled"
fi

notify-send -u normal -t 3000 \
    "Normal Mode" \
    "Desktop settings restored"

echo "✓ Done"
EOF

chmod +x "$HOME/.config/wehttamsnaps/scripts/photography/restore-normal.sh"

exit 0