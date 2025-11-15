#!/bin/bash
# === WEHTTAMSNAPS DISCORD WEBAPP ===
# Communication webapp for streaming and community

# Check if Discord webapp is already running
if pgrep -f "discord-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "discord-webapp"
    exit 0
fi

# Launch Discord webapp with streaming optimizations
brave-browser \
    --app="https://discord.com/app" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/discord" \
    --name="discord-webapp" \
    --disable-features=TranslateUI,VizDisplayCompositor \
    --disable-background-mode \
    --disable-background-timer-throttling \
    --disable-renderer-backgrounding \
    --force-device-scale-factor=1.0 \
    --disable-translate \
    --no-first-run \
    --no-default-browser-check \
    --disable-extensions \
    --enable-hardware-overlays \
    --enable-gpu-rasterization \
    --enable-zero-copy \
    --use-gl=desktop \
    --enable-features=UseSkiaRenderer,CanvasOopRasterization \
    --disable-features=UseOzonePlatform \
    --enable-webrtc-stun-origin \
    --allow-running-insecure-content \
    --disable-web-security \
    --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" &