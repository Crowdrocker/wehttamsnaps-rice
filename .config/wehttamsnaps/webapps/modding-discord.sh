#!/bin/bash
# === WEHTTAMSNAPS MODDING DISCORD WEBAPP ===
# Dedicated Discord for modding communities

# Check if Modding Discord webapp is already running
if pgrep -f "modding-discord-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "modding-discord-webapp"
    exit 0
fi

# Launch Modding Discord webapp with community optimizations
brave-browser \
    --app="https://discord.com/app" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/modding-discord" \
    --name="modding-discord-webapp" \
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
    --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 WehttamSnaps-Modding/1.0" &

# Focus on modding channels after a short delay
sleep 5
echo "Discord webapp launched. Join modding communities like:"
echo "- Nexus Mods Discord"
echo "- Skyrim/Fallout Modding Communities" 
echo "- Wabbajack Support Server"
echo "- Vortex Mod Manager Discord"