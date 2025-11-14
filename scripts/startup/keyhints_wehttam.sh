#!/bin/bash
# ===================================================================
# WehttamSnaps KeyHints - Interactive Keybind Reference
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
# ===================================================================

# GDK Backend
BACKEND=wayland

# Kill existing instances
pkill -f yad 2>/dev/null
pkill -f rofi 2>/dev/null

# Launch YAD with keybinds
GDK_BACKEND=$BACKEND yad \
    --center \
    --title="WehttamSnaps Keybinds" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Notes: \
    --timeout=60 \
    --timeout-indicator=bottom \
    --width=1000 \
    --height=700 \
    --search-column=2 \
    --print-all \
\
"" "=== WEHTTAMSNAPS NIRI + NOCTALIA SETUP ===" "" \
"ESC" "Close this window" "" \
"Mod" "Super/Windows Key" "" \
"" "" "" \
"" "=== CORE NOCTALIA SHELL ===" "" \
"Mod+Space" "Application Launcher" "Main app launcher" \
"Mod+S" "Control Center" "Quick settings & toggles" \
"Mod+Comma" "Settings Panel" "Full settings" \
"Mod+V" "Clipboard History" "Recent clipboard items" \
"Mod+C" "Calculator" "Quick calculator" \
"Mod+N" "Notification History" "View past notifications" \
"Mod+Shift+N" "Toggle Do Not Disturb" "Silence notifications" \
"Mod+L" "Lock Screen" "Hyprlock" \
"Mod+Shift+E" "Session Menu" "Logout/Reboot/Shutdown" \
"Mod+B" "Toggle Bar" "Show/Hide Noctalia bar" \
"Mod+T" "Toggle Dark/Light Mode" "Theme switcher" \
"Mod+W" "Wallpaper Selector" "Choose wallpaper" \
"Mod+Shift+W" "Random Wallpaper" "Set random wallpaper" \
"Mod+I" "Idle Inhibitor" "Prevent screen sleep" \
"Mod+H" "KeyHints (This Screen)" "Show all keybinds" \
"" "" "" \
"" "=== APPLICATIONS ===" "" \
"Mod+Return" "Terminal (Ghostty)" "Default terminal" \
"Mod+Shift+Return" "Floating Terminal" "Floating Ghostty" \
"Mod+Shift+B" "Browser (Brave)" "Web browser" \
"Mod+F" "File Manager (Thunar)" "Browse files" \
"Mod+E" "Code Editor (VSCode)" "Text/code editor" \
"" "" "" \
"" "=== SCREENSHOTS ===" "" \
"Print" "Full Screenshot" "Capture entire screen" \
"Mod+Print" "Region Screenshot" "Select area to capture" \
"Mod+Shift+Print" "Window Screenshot" "Capture active window" \
"" "" "" \
"" "=== WEBAPPS (Mod+Shift+[Key]) ===" "" \
"Mod+Shift+Y" "YouTube Webapp" "YouTube in webapp" \
"Mod+Shift+T" "Twitch Webapp" "Twitch in webapp" \
"Mod+Shift+S" "Spotify Webapp" "Spotify in webapp" \
"Mod+Shift+D" "Discord Webapp" "Discord in webapp" \
"" "" "" \
"" "=== PHOTOGRAPHY WORKFLOW ===" "" \
"Mod+P" "Photography Workspace" "Optimized photo layout" \
"Mod+Shift+G" "GIMP" "Photo editor" \
"Mod+Shift+R" "Darktable" "RAW processor" \
"Mod+Shift+A" "RawTherapee" "RAW editor" \
"Mod+Shift+K" "Krita" "Digital painting" \
"" "" "" \
"" "=== GAMING CONTROLS ===" "" \
"Mod+G" "Toggle Gamemode" "Performance mode ON/OFF" \
"Mod+Shift+G+S" "Steam" "Launch Steam" \
"Mod+Shift+G+L" "Lutris" "Launch Lutris" \
"Mod+Shift+G+C" "AMD GPU Control" "CoreCtrl for RX 580" \
"Mod+Shift+G+P" "Performance Profile" "Optimize for gaming" \
"" "" "" \
"" "=== AUDIO & MEDIA ===" "" \
"XF86AudioRaiseVolume" "Volume Up" "Increase volume" \
"XF86AudioLowerVolume" "Volume Down" "Decrease volume" \
"XF86AudioMute" "Mute Output" "Toggle audio mute" \
"XF86AudioMicMute" "Mute Input" "Toggle mic mute" \
"XF86AudioPlay" "Play/Pause" "Media control" \
"XF86AudioNext" "Next Track" "Skip forward" \
"XF86AudioPrev" "Previous Track" "Skip backward" \
"XF86AudioStop" "Stop" "Stop playback" \
"Mod+Up" "Play/Pause (Alt)" "Fallback media control" \
"Mod+Right" "Next (Alt)" "Fallback next" \
"Mod+Left" "Previous (Alt)" "Fallback previous" \
"Mod+Down" "Stop (Alt)" "Fallback stop" \
"Mod+WheelUp" "Volume Up (Mouse)" "Scroll volume up" \
"Mod+WheelDown" "Volume Down (Mouse)" "Scroll volume down" \
"" "" "" \
"" "=== BRIGHTNESS ===" "" \
"XF86MonBrightnessUp" "Brightness Up" "Increase brightness" \
"XF86MonBrightnessDown" "Brightness Down" "Decrease brightness" \
"" "" "" \
"" "=== SCREEN RECORDING ===" "" \
"Mod+Shift+R" "Toggle Recording" "Start/Stop screen record" \
"" "" "" \
"" "=== WINDOW MANAGEMENT ===" "" \
"Mod+Q" "Close Window" "Gentle close" \
"Mod+Shift+Q" "Kill Window" "Force close" \
"Mod+Shift+F" "Fullscreen" "Toggle fullscreen" \
"Mod+Shift+Space" "Toggle Float" "Float/Tile window" \
"Mod+C" "Center Window" "Center floating window" \
"Mod+M" "Maximize Column" "Full width" \
"Mod+Minus" "Decrease Width (-10%)" "Shrink column" \
"Mod+Equal" "Increase Width (+10%)" "Grow column" \
"Mod+Shift+Minus" "Width 33%" "1/3 screen" \
"Mod+Shift+Equal" "Width 50%" "1/2 screen" \
"Mod+Shift+Plus" "Width 67%" "2/3 screen" \
"" "" "" \
"" "=== WINDOW FOCUS ===" "" \
"Mod+Left / Mod+H" "Focus Left" "Move focus left" \
"Mod+Right / Mod+L" "Focus Right" "Move focus right" \
"Mod+Down / Mod+J" "Focus Down" "Move focus down" \
"Mod+Up / Mod+K" "Focus Up" "Move focus up" \
"Mod+Shift+Arrow" "Focus Monitor" "Multi-monitor focus" \
"" "" "" \
"" "=== WINDOW MOVEMENT ===" "" \
"Mod+Ctrl+Left / Mod+Ctrl+H" "Move Left" "Move window left" \
"Mod+Ctrl+Right / Mod+Ctrl+L" "Move Right" "Move window right" \
"Mod+Ctrl+Down / Mod+Ctrl+J" "Move Down" "Move window down" \
"Mod+Ctrl+Up / Mod+Ctrl+K" "Move Up" "Move window up" \
"Mod+Ctrl+Shift+Arrow" "Move to Monitor" "Multi-monitor move" \
"" "" "" \
"" "=== WORKSPACES ===" "" \
"Mod+1 to Mod+9" "Switch Workspace" "Go to workspace 1-9" \
"Mod+Tab" "Next Workspace" "Cycle workspaces down" \
"Mod+Shift+Tab" "Previous Workspace" "Cycle workspaces up" \
"Mod+Shift+1 to Mod+Shift+9" "Move to Workspace" "Send window to workspace" \
"Mod+Ctrl+Tab" "Move & Follow" "Move window & switch" \
"" "" "" \
"" "=== COMPOSITOR CONTROLS ===" "" \
"Mod+Shift+C" "Reload Config" "Reload Niri config" \
"Mod+Shift+Escape" "Quit Niri" "Exit compositor" \
"Mod+Ctrl+Shift+T" "Switch to TTY" "Console mode" \
"" "" "" \
"" "=== WORKSPACE ASSIGNMENTS ===" "" \
"Workspace 1" "General" "Default workspace" \
"Workspace 2" "Photography" "Photo editing apps" \
"Workspace 3" "Gaming" "Steam, Lutris, games" \
"Workspace 4" "Communication" "Discord, Telegram, Email" \
"Workspace 5" "Media" "Spotify, OBS, video editing" \
"Workspace 6" "Webapps" "YouTube, Twitch, etc." \
"" "" "" \
"" "=== HARDWARE INFO ===" "" \
"CPU" "Intel i7-4790 @ 4.0GHz" "4 cores, 8 threads" \
"GPU" "AMD Radeon RX 580" "8GB VRAM" \
"RAM" "16GB DDR3" "" \
"Display" "1920x1080 @ 60Hz" "Single monitor" \
"" "" "" \
"" "=== TIPS & TRICKS ===" "" \
"Tip" "Hold Mod and drag windows" "Move windows with mouse" \
"Tip" "Use Mod+H anytime" "View this help screen" \
"Tip" "Mod+G before gaming" "Enable performance mode" \
"Tip" "Mod+P for photo work" "Optimized photo layout" \
"Tip" "Check ~/.config/wehttamsnaps/" "All configs are there" \
"" "" "" \
"" "=== LINKS ===" "" \
"GitHub" "https://github.com/Crowdrocker/wehttamsnaps-dotfiles" "Source & docs" \
"Twitch" "https://twitch.tv/wehttamsnaps" "Live streams" \
"YouTube" "https://youtube.com/@wehttamsnaps" "Videos & tutorials"