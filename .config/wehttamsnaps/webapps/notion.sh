#!/bin/bash
# === WEHTTAMSNAPS NOTION WEBAPP ===
# Productivity and organization webapp

# Check if Notion webapp is already running
if pgrep -f "notion-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "notion-webapp"
    exit 0
fi

# Launch Notion webapp with productivity optimizations
brave-browser \
    --app="https://www.notion.so" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/notion" \
    --name="notion-webapp" \
    --disable-features=TranslateUI \
    --disable-background-mode \
    --disable-background-timer-throttling \
    --disable-renderer-backgrounding \
    --force-device-scale-factor=1.0 \
    --disable-translate \
    --no-first-run \
    --no-default-browser-check \
    --disable-extensions \
    --enable-smooth-scrolling \
    --enable-pointer-events \
    --disable-devtools-context-menu &