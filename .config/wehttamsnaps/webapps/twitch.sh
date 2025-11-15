#!/bin/bash
# === WEHTTAMSNAPS TWITCH WEBAPP ===
# Streaming-optimized Twitch experience

# Check if Twitch webapp is already running
if pgrep -f "twitch-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "twitch-webapp"
    exit 0
fi

# Launch Twitch webapp with streaming optimizations
brave-browser \
    --app="https://www.twitch.tv" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/twitch" \
    --name="twitch-webapp" \
    --disable-features=TranslateUI \
    --enable-features=VaapiVideoDecoder \
    --disable-background-mode \
    --disable-background-timer-throttling \
    --disable-renderer-backgrounding \
    --force-device-scale-factor=1.0 \
    --disable-translate \
    --no-first-run \
    --no-default-browser-check \
    --disable-extensions \
    --enable-gpu-rasterization \
    --enable-zero-copy &