#!/bin/bash
# === WEHTTAMSNAPS MUSIC WEBAPP ===
# Spotify/YouTube Music webapp with media controls

# Check if music webapp is already running
if pgrep -f "music-webapp" > /dev/null; then
    # Focus existing window
    niri-msg action focus-window-app-id "music-webapp"
    exit 0
fi

# Launch music webapp (YouTube Music by default)
brave-browser \
    --app="https://music.youtube.com" \
    --user-data-dir="$HOME/.config/wehttamsnaps/webapps/music" \
    --name="music-webapp" \
    --disable-features=TranslateUI \
    --disable-background-mode \
    --disable-background-timer-throttling \
    --disable-renderer-backgrounding \
    --force-device-scale-factor=1.0 \
    --disable-translate \
    --no-first-run \
    --no-default-browser-check \
    --disable-extensions \
    --enable-media-session \
    --enable-audio-service-sandbox &