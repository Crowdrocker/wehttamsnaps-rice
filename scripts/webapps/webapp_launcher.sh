#!/bin/bash
# ===================================================================
# WehttamSnaps Webapp Launcher
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Launches webapps in dedicated browser windows
# ===================================================================

WEBAPP_NAME="$1"
CONFIG_DIR="$HOME/.config/wehttamsnaps/webapps"

# Browser preference order
BROWSERS=("brave" "chromium" "firefox" "zen-browser")

# Find available browser
find_browser() {
    for browser in "${BROWSERS[@]}"; do
        if command -v "$browser" &>/dev/null; then
            echo "$browser"
            return 0
        fi
    done
    echo "none"
    return 1
}

BROWSER=$(find_browser)

if [ "$BROWSER" = "none" ]; then
    notify-send -u critical "Webapp Error" "No supported browser found"
    exit 1
fi

# ===================================================================
# WEBAPP DEFINITIONS
# ===================================================================

case "$WEBAPP_NAME" in
    youtube)
        URL="https://www.youtube.com"
        TITLE="YouTube"
        ICON="youtube"
        CLASS="webapp-youtube"
        ;;
    twitch)
        URL="https://www.twitch.tv"
        TITLE="Twitch"
        ICON="twitch"
        CLASS="webapp-twitch"
        ;;
    spotify)
        URL="https://open.spotify.com"
        TITLE="Spotify"
        ICON="spotify"
        CLASS="webapp-spotify"
        ;;
    discord)
        URL="https://discord.com/app"
        TITLE="Discord"
        ICON="discord"
        CLASS="webapp-discord"
        ;;
    gmail)
        URL="https://mail.google.com"
        TITLE="Gmail"
        ICON="gmail"
        CLASS="webapp-gmail"
        ;;
    calendar)
        URL="https://calendar.google.com"
        TITLE="Calendar"
        ICON="calendar"
        CLASS="webapp-calendar"
        ;;
    notion)
        URL="https://www.notion.so"
        TITLE="Notion"
        ICON="notion"
        CLASS="webapp-notion"
        ;;
    chatgpt)
        URL="https://chat.openai.com"
        TITLE="ChatGPT"
        ICON="chatgpt"
        CLASS="webapp-chatgpt"
        ;;
    *)
        notify-send -u normal "Webapp" "Unknown webapp: $WEBAPP_NAME"
        exit 1
        ;;
esac

# ===================================================================
# CHECK IF ALREADY RUNNING
# ===================================================================

# Check if webapp is already running
if pgrep -f "$CLASS" > /dev/null; then
    # Try to focus existing window (Niri-specific)
    niri msg action focus-window --app-id="$CLASS" 2>/dev/null
    exit 0
fi

# ===================================================================
# LAUNCH WEBAPP
# ===================================================================

notify-send -u low -t 2000 -i "$ICON" "Launching $TITLE" "Opening webapp..."

case "$BROWSER" in
    brave|chromium)
        # Chromium-based browsers
        $BROWSER \
            --app="$URL" \
            --class="$CLASS" \
            --user-data-dir="$HOME/.local/share/webapps/$WEBAPP_NAME" \
            --no-first-run \
            --no-default-browser-check \
            --disable-background-mode \
            --enable-features=WebUIDarkMode,VaapiVideoDecoder,VaapiVideoEncoder \
            --force-dark-mode \
            --enable-gpu-rasterization \
            --enable-zero-copy \
            &>/dev/null &
        ;;
    
    firefox)
        # Firefox
        firefox \
            --new-window "$URL" \
            --class="$CLASS" \
            --profile "$HOME/.local/share/webapps/$WEBAPP_NAME" \
            &>/dev/null &
        ;;
    
    zen-browser)
        # Zen Browser
        zen-browser \
            --new-window "$URL" \
            --class="$CLASS" \
            &>/dev/null &
        ;;
esac

# Wait a moment for window to appear
sleep 1

# Set window class using xprop (for X11/XWayland apps)
# For Wayland apps, the --class flag should work

exit 0