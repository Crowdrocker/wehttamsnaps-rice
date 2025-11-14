#!/bin/bash
# ===================================================================
# WehttamSnaps Noctalia Widget Creator
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Interactive script to create custom Noctalia widgets
# ===================================================================

echo "🎨 WehttamSnaps Widget Creator"
echo "==============================="
echo ""

# Check for gum
if ! command -v gum &>/dev/null; then
    echo "❌ This script requires 'gum' for interactive prompts"
    echo "Install with: sudo pacman -S gum"
    exit 1
fi

WIDGETS_DIR="$HOME/.config/noctalia/widgets"
TEMPLATE_DIR="$HOME/.config/wehttamsnaps/scripts/widgets/widget-template"

mkdir -p "$WIDGETS_DIR"

# ===================================================================
# COLLECT WIDGET INFORMATION
# ===================================================================

echo "Let's create a new Noctalia widget!"
echo ""

# Widget name
WIDGET_NAME=$(gum input --placeholder "Widget name (e.g., my-widget)")
if [ -z "$WIDGET_NAME" ]; then
    echo "❌ Widget name is required"
    exit 1
fi

# Convert to proper case
WIDGET_NAME=$(echo "$WIDGET_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# Display name
DISPLAY_NAME=$(gum input --placeholder "Display name (e.g., My Widget)" --value "${WIDGET_NAME^}")

# Widget type
WIDGET_TYPE=$(gum choose "System Info" "Media Player" "Quick Action" "Custom Display")

# Bar section
BAR_SECTION=$(gum choose "Left" "Center" "Right")

# Icon (optional)
USE_ICON=$(gum confirm "Include an icon?" && echo "yes" || echo "no")
if [ "$USE_ICON" = "yes" ]; then
    ICON_NAME=$(gum input --placeholder "Icon name (from Lucide React)" --value "activity")
else
    ICON_NAME=""
fi

# Update interval (for dynamic widgets)
if [ "$WIDGET_TYPE" != "Quick Action" ]; then
    UPDATE_INTERVAL=$(gum input --placeholder "Update interval in ms (e.g., 1000)" --value "1000")
else
    UPDATE_INTERVAL="0"
fi

# ===================================================================
# CREATE WIDGET DIRECTORY
# ===================================================================

WIDGET_DIR="$WIDGETS_DIR/$WIDGET_NAME"

if [ -d "$WIDGET_DIR" ]; then
    echo "⚠ Widget '$WIDGET_NAME' already exists"
    if ! gum confirm "Overwrite existing widget?"; then
        exit 0
    fi
    rm -rf "$WIDGET_DIR"
fi

mkdir -p "$WIDGET_DIR"

echo "  ✓ Created widget directory: $WIDGET_DIR"

# ===================================================================
# GENERATE WIDGET QML FILE
# ===================================================================

cat > "$WIDGET_DIR/${WIDGET_NAME^}.qml" << EOF
import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Services

Rectangle {
    id: root

    // Provided by Bar.qml via NWidgetLoader
    property var screen
    property real scaling: 1.0
    property string widgetId: ""
    property string section: ""
    property int sectionWidgetIndex: -1
    property int sectionWidgetsCount: 0

    // Access metadata and settings
    property var widgetMetadata: BarWidgetRegistry.widgetMetadata[widgetId]
    property var widgetSettings: {
        if (section && sectionWidgetIndex >= 0) {
            var widgets = Settings.data.bar.widgets[section]
            if (widgets && sectionWidgetIndex < widgets.length) {
                return widgets[sectionWidgetIndex]
            }
        }
        return {}
    }

    // Widget state
    property string displayText: "$DISPLAY_NAME"
    property bool isActive: false

    // Styling
    implicitHeight: Math.round(Style.capsuleHeight * scaling)
    implicitWidth: Math.round(120 * scaling)
    radius: Math.round(Style.radiusS * scaling)
    color: isActive ? Color.mPrimaryContainer : Color.mSurfaceVariant
    border.width: Math.max(1, Style.borderS * scaling)
    border.color: isActive ? Color.mPrimary : Color.mOutline

    // Animations
    Behavior on color {
        ColorAnimation { duration: 200 }
    }

    Behavior on border.color {
        ColorAnimation { duration: 200 }
    }

    // Layout
    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: Style.marginXS * scaling
        spacing: Style.marginXS * scaling

EOF

if [ -n "$ICON_NAME" ]; then
    cat >> "$WIDGET_DIR/${WIDGET_NAME^}.qml" << EOF
        // Icon
        NIcon {
            icon: "$ICON_NAME"
            size: Style.iconSizeS * scaling
            color: isActive ? Color.mOnPrimaryContainer : Color.mOnSurfaceVariant
            Layout.alignment: Qt.AlignVCenter
        }

EOF
fi

cat >> "$WIDGET_DIR/${WIDGET_NAME^}.qml" << EOF
        // Text
        NText {
            text: displayText
            font.pointSize: Style.fontSizeXS * scaling
            font.weight: Style.fontWeightMedium
            color: isActive ? Color.mOnPrimaryContainer : Color.mOnSurfaceVariant
            Layout.alignment: Qt.AlignVCenter
        }
    }

    // Mouse interaction
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            root.color = Color.mSecondaryContainer
        }

        onExited: {
            root.color = isActive ? Color.mPrimaryContainer : Color.mSurfaceVariant
        }

        onClicked: {
            handleClick()
        }
    }

    // Update timer (for dynamic content)
EOF

if [ "$UPDATE_INTERVAL" != "0" ]; then
    cat >> "$WIDGET_DIR/${WIDGET_NAME^}.qml" << EOF
    Timer {
        id: updateTimer
        interval: $UPDATE_INTERVAL
        running: true
        repeat: true
        onTriggered: updateWidget()
    }

    function updateWidget() {
        // TODO: Implement widget update logic
        // Example: Read system info, check status, etc.
        
        // Update display text
        // displayText = "Updated: " + new Date().toLocaleTimeString()
        
        console.log("Widget updated: $WIDGET_NAME")
    }
EOF
fi

cat >> "$WIDGET_DIR/${WIDGET_NAME^}.qml" << EOF

    // Click handler
    function handleClick() {
        isActive = !isActive
        
        // TODO: Implement click action
        console.log("$DISPLAY_NAME clicked")
        
        // Example actions:
        // - Open application
        // - Toggle setting
        // - Run command
        // - Show popup
    }

    // Component initialization
    Component.onCompleted: {
        console.log("$DISPLAY_NAME widget loaded")
EOF

if [ "$UPDATE_INTERVAL" != "0" ]; then
    cat >> "$WIDGET_DIR/${WIDGET_NAME^}.qml" << EOF
        updateWidget()
EOF
fi

cat >> "$WIDGET_DIR/${WIDGET_NAME^}.qml" << EOF
    }
}
EOF

echo "  ✓ Created widget QML file"

# ===================================================================
# CREATE WIDGET MANIFEST
# ===================================================================

cat > "$WIDGET_DIR/manifest.json" << EOF
{
  "name": "$WIDGET_NAME",
  "displayName": "$DISPLAY_NAME",
  "description": "Custom widget created with WehttamSnaps widget creator",
  "version": "1.0.0",
  "author": "WehttamSnaps",
  "type": "$WIDGET_TYPE",
  "section": "$BAR_SECTION",
  "icon": "$ICON_NAME",
  "updateInterval": $UPDATE_INTERVAL,
  "settings": {
    "enabled": true,
    "position": "auto"
  },
  "created": "$(date -Iseconds)"
}
EOF

echo "  ✓ Created manifest file"

# ===================================================================
# CREATE README
# ===================================================================

cat > "$WIDGET_DIR/README.md" << EOF
# $DISPLAY_NAME Widget

**Type:** $WIDGET_TYPE  
**Section:** $BAR_SECTION  
**Update Interval:** ${UPDATE_INTERVAL}ms

## Description

Custom Noctalia widget for displaying $WIDGET_TYPE information.

## Installation

This widget is located at:
\`\`\`
$WIDGET_DIR
\`\`\`

## Configuration

Edit the widget settings in Noctalia settings panel or modify \`manifest.json\`.

## Customization

Edit \`${WIDGET_NAME^}.qml\` to customize:
- Display text
- Click actions
- Update logic
- Styling

## Usage

The widget will appear in the **$BAR_SECTION** section of your Noctalia bar.

EOF

if [ -n "$ICON_NAME" ]; then
    cat >> "$WIDGET_DIR/README.md" << EOF
Icon: \`$ICON_NAME\` from Lucide React

EOF
fi

cat >> "$WIDGET_DIR/README.md" << EOF
## Development

To test changes:
1. Edit the QML file
2. Reload Noctalia: \`Mod+Shift+C\`
3. Check console for errors: \`journalctl --user -f\`

## TODO

- [ ] Implement update logic in \`updateWidget()\`
- [ ] Add click action in \`handleClick()\`
- [ ] Customize styling
- [ ] Add tooltip
- [ ] Add context menu

---

Created with WehttamSnaps Widget Creator  
https://github.com/Crowdrocker/wehttamsnaps-dotfiles
EOF

echo "  ✓ Created README file"

# ===================================================================
# REGISTER WIDGET
# ===================================================================

echo ""
echo "To register this widget in Noctalia:"
echo "1. Open Services/BarWidgetRegistry.qml"
echo "2. Add widget to widgets map:"
echo "   \"${WIDGET_NAME^}\": ${WIDGET_NAME}Component,"
echo ""
echo "3. Add metadata:"
echo "   \"${WIDGET_NAME^}\": {"
echo "       \"allowUserSettings\": true,"
echo "       \"displayName\": \"$DISPLAY_NAME\""
echo "   },"
echo ""
echo "4. Add component:"
echo "   property Component ${WIDGET_NAME}Component: Component {"
echo "       ${WIDGET_NAME^} {}"
echo "   }"
echo ""

# ===================================================================
# SUMMARY
# ===================================================================

echo "✅ Widget '$DISPLAY_NAME' created successfully!"
echo ""
echo "Location: $WIDGET_DIR"
echo "Files created:"
echo "  • ${WIDGET_NAME^}.qml  - Widget implementation"
echo "  • manifest.json        - Widget metadata"
echo "  • README.md           - Documentation"
echo ""
echo "Next steps:"
echo "  1. Register widget in BarWidgetRegistry.qml"
echo "  2. Implement widget logic in ${WIDGET_NAME^}.qml"
echo "  3. Reload Noctalia to test"
echo ""

# Open widget directory
if gum confirm "Open widget directory in file manager?"; then
    xdg-open "$WIDGET_DIR" &
fi

exit 0