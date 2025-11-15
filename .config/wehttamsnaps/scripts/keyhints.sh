#!/bin/bash
# === WEHTTAMSNAPS KEYBINDING CHEAT SHEET ===
# GitHub: https://github.com/Crowdrocker
# Niri + Noctalia + Ghostty + WebApps

# Check if rofi or yad is running and kill them if they are
if pidof rofi > /dev/null; then
    pkill rofi
fi

if pidof yad > /dev/null; then
    pkill yad
fi

# Launch yad with WehttamSnaps theming
GDK_BACKEND=wayland yad \
    --center \
    --title="WehttamSnaps - Quick Cheat Sheet" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "close this app" "🗑️" \
"⊞ = Super (Windows Key)" "(SUPER KEY)" "(SUPER KEY)" \
"" "" "" \
"=== CORE APPLICATIONS ===" "" "" \
"⊞ ENTER" "Ghostty Terminal" "(Fira Code font)" \
"⊞ D" "App Launcher" "(Fuzzel)" \
"⊞ SPACE" "QuickShell Launcher" "(Noctalia Shell)" \
"⊞ B" "Brave Browser" "(Default browser)" \
"⊞ F" "File Manager" "(Thunar)" \
"⊞ E" "VS Code Editor" "(Development)" \
"⊞ Q" "Close active window" "(Not kill)" \
"⊞ SHIFT Q" "Kill active window" "(Force close)" \
"" "" "" \
"=== NOCTALIA SHELL ===" "" "" \
"⊞ S" "Control Center" "(Noctalia settings)" \
"⊞ COMMA" "Settings Panel" "(QuickShell config)" \
"⊞ H" "This Help Screen" "(Key hints)" \
"⊞ V" "Clipboard Manager" "(ClipHist)" \
"" "" "" \
"=== PHOTOGRAPHY & DESIGN ===" "" "" \
"⊞ SHIFT D" "Darktable" "(Photo editing)" \
"⊞ SHIFT R" "RawTherapee" "(RAW processing)" \
"⊞ SHIFT G" "GIMP" "(Image editing)" \
"⊞ SHIFT I" "Inkscape" "(Vector graphics)" \
"⊞ SHIFT K" "Krita" "(Digital painting)" \
"" "" "" \
"=== GAMING & STREAMING ===" "" "" \
"⊞ SHIFT G" "Toggle Game Mode" "(Performance mode)" \
"⊞ SHIFT S" "Steam" "(Gaming platform)" \
"⊞ SHIFT O" "OBS Studio" "(Streaming/recording)" \
"⊞ SHIFT L" "Lutris" "(Game launcher)" \
"" "" "" \
"=== WEBAPPS ===" "" "" \
"⊞ SHIFT Y" "YouTube WebApp" "(Focused experience)" \
"⊞ SHIFT T" "Twitch WebApp" "(Streaming platform)" \
"⊞ SHIFT M" "Music WebApp" "(Spotify/YouTube Music)" \
"⊞ SHIFT D" "Discord WebApp" "(Communication)" \
"⊞ SHIFT N" "Notion WebApp" "(Productivity)" \
"" "" "" \
"=== WINDOW MANAGEMENT ===" "" "" \
"⊞ F" "Toggle Fullscreen" "(Current window)" \
"⊞ SHIFT F" "Maximize Column" "(Current column)" \
"⊞ SPACE" "Toggle Float" "(Single window)" \
"⊞ SHIFT SPACE" "Toggle All Float" "(All windows)" \
"⊞ ALT TAB" "Switch Windows" "(Window switcher)" \
"⊞ ALT SHIFT TAB" "Reverse Switch" "(Opposite direction)" \
"" "" "" \
"=== WORKSPACE MANAGEMENT ===" "" "" \
"⊞ 1-9" "Switch to Workspace" "(Direct navigation)" \
"⊞ SHIFT 1-9" "Move to Workspace" "(Move current window)" \
"⊞ 0" "Switch to Workspace 10" "(Last workspace)" \
"⊞ ALT F4" "Close Workspace" "(Current workspace)" \
"" "" "" \
"=== SCREENSHOTS & RECORDING ===" "" "" \
"PRINT" "Screenshot All" "(Save to Pictures)" \
"⊞ PRINT" "Screenshot Region" "(Select area)" \
"SHIFT PRINT" "Start Recording" "(Save to Videos)" \
"CTRL PRINT" "Screenshot Timer (5s)" "(Delayed capture)" \
"CTRL SHIFT PRINT" "Screenshot Timer (10s)" "(Longer delay)" \
"ALT PRINT" "Active Window Shot" "(Current window)" \
"" "" "" \
"=== AUDIO CONTROLS (Noctalia) ===" "" "" \
"XF86AudioRaiseVolume" "Volume Up" "(System volume)" \
"XF86AudioLowerVolume" "Volume Down" "(System volume)" \
"XF86AudioMute" "Mute Output" "(Toggle mute)" \
"XF86AudioPlay" "Play/Pause" "(Media control)" \
"XF86AudioNext" "Next Track" "(Media control)" \
"XF86AudioPrev" "Previous Track" "(Media control)" \
"" "" "" \
"=== SYSTEM CONTROLS ===" "" "" \
"CTRL ALT L" "Lock Screen" "(Hyprlock)" \
"CTRL ALT DELETE" "Logout Menu" "(Wlogout)" \
"CTRL ALT B" "Toggle Bar" "(Noctalia visibility)" \
"CTRL ALT R" "Reload Config" "(Niri restart)" \
"CTRL ALT T" "Terminal (Advanced)" "(System tools)" \
"" "" "" \
"=== DISPLAY & BRIGHTNESS ===" "" "" \
"XF86MonBrightnessUp" "Brightness Up" "(Monitor control)" \
"XF86MonBrightnessDown" "Brightness Down" "(Monitor control)" \
"⊞ SHIFT W" "Choose Wallpaper" "(Wallpaper menu)" \
"CTRL ALT W" "Random Wallpaper" "(Swww daemon)" \
"" "" "" \
"=== GAMING OPTIMIZATIONS ===" "" "" \
"⊞ SHIFT G" "Game Mode ON/OFF" "(Performance toggles)" \
"⊞ CTRL G" "GPU Control" "(CoreCtrl for RX 580)" \
"⊞ ALT G" "Gamescope Launcher" "(Optimized gaming)" \
"" "" "" \
"=== PHOTOGRAPHY WORKFLOW ===" "" "" \
"⊞ SHIFT D" "Darktable" "(Professional editing)" \
"⊞ SHIFT R" "RawTherapee" "(RAW conversion)" \
"⊞ SHIFT F" "FastStone Viewer" "(Quick review)" \
"⊞ SHIFT P" "PhotoPea WebApp" "(Online editor)" \
"" "" "" \
"=== DEVELOPMENT SHORTCUTS ===" "" "" \
"⊞ E" "VS Code" "(Main editor)" \
"⊞ SHIFT E" "Neovim" "(Terminal editor)" \
"⊞ ALT E" "Ghostty (dev)" "(Dev terminal)" \
"⊞ G" "Git GUI" "(GitHub Desktop)" \
"" "" "" \
"=== MORE INFO ===" "" "" \
"WehttamSnaps GitHub" "https://github.com/Crowdrocker" "(Full documentation)" \
"WehttamSnaps YouTube" "https://youtube.com/@WehttamSnaps" "(Video tutorials)"