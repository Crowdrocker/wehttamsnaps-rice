#!/bin/bash
# ===================================================================
# WehttamSnaps Webapp Creator
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Interactive script to create custom webapps
# ===================================================================

echo "🌐 WehttamSnaps Webapp Creator"
echo "=============================="
echo ""

# Check for required tools
if ! command -v gum &>/dev/null; then
    echo "❌ This script requires 'gum' for interactive prompts"
    echo "Install with: sudo pacman -S gum"
    exit 1
fi

CONFIG_DIR="$HOME/.config/wehttamsnaps/webapps"
SCRIPT_DIR="$HOME/.config/wehttamsnaps/scripts/webapps"
DESKTOP_DIR="$HOME/.local/share/applications"

mkdir -p "$CONFIG_DIR" "$DESKTOP_DIR"

# ===================================================================
# COLLECT WEBAPP INFORMATION
# ===================================================================

echo "Let's create a new webapp!"
echo ""

# Webapp name
WEBAPP_NAME=$(gum input --placeholder "Webapp name (e.g., netflix)")
if [ -z "$WEBAPP_NAME" ]; then
    echo "❌ Webapp name is required"
    exit 1
fi

# Convert to lowercase, remove spaces
WEBAPP_NAME=$(echo "$WEBAPP_NAME" | tr '[:upper:]' '[:lower:]' | tr -d ' ')

# Display name
DISPLAY_NAME=$(gum input --placeholder "Display name (e.g., Netflix)" --value "${WEBAPP_NAME^}")

# URL
URL=$(gum input --placeholder "URL (e.g., https://netflix.com)")
if [ -z "$URL" ]; then
    echo "❌ URL is required"
    exit 1
fi

# Icon name (optional)
ICON=$(gum input --placeholder "Icon name (optional, e.g., netflix)" --value "$WEBAPP_NAME")

# Keybind suggestion
echo ""
echo "Suggested keybind: Mod+Shift+${WEBAPP_NAME:0:1}"
ADD_KEYBIND=$(gum confirm "Add keybind to Niri config?" && echo "yes" || echo "no")

# ===================================================================
# CREATE DESKTOP FILE
# ===================================================================

DESKTOP_FILE="$DESKTOP_DIR/webapp-${WEBAPP_NAME}.desktop"

cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$DISPLAY_NAME
Comment=Webapp for $DISPLAY_NAME
Exec=bash $SCRIPT_DIR/webapp-launcher.sh $WEBAPP_NAME
Icon=$ICON
Terminal=false
Categories=Network;WebBrowser;
StartupWMClass=webapp-$WEBAPP_NAME
Keywords=$WEBAPP_NAME;webapp;
EOF

chmod +x "$DESKTOP_FILE"

echo "✓ Created desktop file: $DESKTOP_FILE"

# ===================================================================
# UPDATE LAUNCHER SCRIPT
# ===================================================================

LAUNCHER_SCRIPT="$SCRIPT_DIR/webapp-launcher.sh"

# Check if webapp already exists in launcher
if grep -q "\"$WEBAPP_NAME\")" "$LAUNCHER_SCRIPT"; then
    echo "⚠ Webapp '$WEBAPP_NAME' already exists in launcher"
else
    # Find the line before the default case (*)
    # Insert new webapp definition
    
    # Create temporary file with new webapp
    NEW_WEBAPP_CASE="    $WEBAPP_NAME)
        URL=\"$URL\"
        TITLE=\"$DISPLAY_NAME\"
        ICON=\"$ICON\"
        CLASS=\"webapp-$WEBAPP_NAME\"
        ;;"
    
    # Insert before the *) case
    sed -i "/    \*)/i\\$NEW_WEBAPP_CASE\n" "$LAUNCHER_SCRIPT"
    
    echo "✓ Added webapp to launcher script"
fi

# ===================================================================
# ADD KEYBIND (OPTIONAL)
# ===================================================================

if [ "$ADD_KEYBIND" = "yes" ]; then
    KEYBIND_FILE="$HOME/.config/niri/conf.d/10-keybinds.kdl"
    KEYBIND_CHAR=$(echo "${WEBAPP_NAME:0:1}" | tr '[:lower:]' '[:upper:]')
    
    if [ -f "$KEYBIND_FILE" ]; then
        # Check if keybind already exists
        if grep -q "webapp-launcher.sh $WEBAPP_NAME" "$KEYBIND_FILE"; then
            echo "⚠ Keybind already exists for $WEBAPP_NAME"
        else
            # Find the webapps section and add keybind
            KEYBIND_LINE="    Mod+Shift+$KEYBIND_CHAR { spawn \"bash\" \"$SCRIPT_DIR/webapp-launcher.sh\" \"$WEBAPP_NAME\"; }"
            
            # Insert in webapps section
            sed -i "/=== WEBAPPS/a\\$KEYBIND_LINE" "$KEYBIND_FILE"
            
            echo "✓ Added keybind: Mod+Shift+$KEYBIND_CHAR"
            echo "  → Reload Niri config: Mod+Shift+C"
        fi
    else
        echo "⚠ Niri keybind file not found: $KEYBIND_FILE"
    fi
fi

# ===================================================================
# SUMMARY
# ===================================================================

echo ""
echo "✅ Webapp '$DISPLAY_NAME' created successfully!"
echo ""
echo "Details:"
echo "  Name: $WEBAPP_NAME"
echo "  URL: $URL"
echo "  Class: webapp-$WEBAPP_NAME"
if [ "$ADD_KEYBIND" = "yes" ]; then
    echo "  Keybind: Mod+Shift+$KEYBIND_CHAR"
fi
echo ""
echo "Launch options:"
echo "  1. Use keybind (if added)"
echo "  2. Run: bash $SCRIPT_DIR/webapp-launcher.sh $WEBAPP_NAME"
echo "  3. Search in app launcher"
echo ""

# Ask if user wants to launch now
if gum confirm "Launch webapp now?"; then
    bash "$SCRIPT_DIR/webapp-launcher.sh" "$WEBAPP_NAME" &
    echo "✓ Launching $DISPLAY_NAME..."
fi

exit 0