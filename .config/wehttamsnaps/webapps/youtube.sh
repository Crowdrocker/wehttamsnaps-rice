#!/bin/bash
# === WEHTTAMSNAPS YOUTUBE WEBAPP ===
# Minimal YouTube experience without distractions

# Check if YouTube webapp is already running
if pgrep -f "youtube-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "youtube-webapp"
    exit 0
fi

# Launch YouTube webapp with specific settings
brave-browser \
    --app="https://www.youtube.com" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/youtube" \
    --name="youtube-webapp" \
    --disable-features=TranslateUI \
    --disable-background-mode \
    --disable-background-timer-throttling \
    --disable-renderer-backgrounding \
    --force-device-scale-factor=1.0 \
    --disable-translate \
    --no-first-run \
    --no-default-browser-check \
    --disable-extensions \
    --disable-plugins-discovery \
    --disable-default-apps \
    --hide-crash-restore-bubble &