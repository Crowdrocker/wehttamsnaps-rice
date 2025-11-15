#!/bin/bash
# === WEHTTAMSNAPS LOOT WEBAPP ===
# Dedicated LOOT (Load Order Optimization Tool) webapp

# Check if LOOT webapp is already running
if pgrep -f "loot-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "loot-webapp"
    exit 0
fi

# Launch LOOT webapp with modding optimizations
brave-browser \
    --app="https://loot.github.io" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/loot" \
    --name="loot-webapp" \
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
    --disable-devtools-context-menu \
    --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 WehttamSnaps-Modding/1.0" &

echo "LOOT webapp launched for load order optimization"
echo "Remember to also install LOOT locally for full functionality"