#!/bin/bash
# === WEHTTAMSNAPS NEXUS MODS WEBAPP ===
# Dedicated Nexus Mods browsing experience

# Check if Nexus Mods webapp is already running
if pgrep -f "nexusmods-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "nexusmods-webapp"
    exit 0
fi

# Launch Nexus Mods webapp with modding optimizations
brave-browser \
    --app="https://www.nexusmods.com" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/nexusmods" \
    --name="nexusmods-webapp" \
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
    --enable-zero-copy \
    --enable-smooth-scrolling \
    --enable-pointer-events \
    --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 WehttamSnaps-Modding/1.0" &