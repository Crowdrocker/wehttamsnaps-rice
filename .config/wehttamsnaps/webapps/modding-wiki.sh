#!/bin/bash
# === WEHTTAMSNAPS MODDING WIKI WEBAPP ===
# Dedicated modding documentation and wiki browsing

# Check if Modding Wiki webapp is already running
if pgrep -f "modding-wiki-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "modding-wiki-webapp"
    exit 0
fi

# Launch Modding Wiki webapp with documentation optimizations
brave-browser \
    --app="https://wiki.bethesda.net" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/modding-wiki" \
    --name="modding-wiki-webapp" \
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
    --enable-reader-mode \
    --disable-devtools-context-menu \
    --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 WehttamSnaps-Modding/1.0" &

echo "Modding Wiki webapp launched"
echo "Quick access to:"
echo "- Bethesda Creation Kit Wiki"
echo "- Modding documentation"
echo "- Script references"
echo "- Troubleshooting guides"