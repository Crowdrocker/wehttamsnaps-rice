#!/bin/bash
# === WEHTTAMSNAPS - MODDING KEYBINDS CHEAT SHEET ===
# Comprehensive keybinding reference for modding tools

# Check if yad is running and kill it if they are
if pidof yad > /dev/null; then
    pkill yad
fi

# Launch yad with modding theming
GDK_BACKEND=wayland yad \
    --center \
    --title="WehttamSnaps - Modding Keybinds" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Tool: \
    --column=Description: \
    --timeout-indicator=bottom \
"ESC" "close this app" "🗑️" \
"" "" "" \
"=== MODDING LAUNCHERS ===" "" "" \
"Super+Shift+T" "SteamTinkerLaunch" "Advanced Steam tool" \
"Super+Shift+V" "Vortex" "Mod manager" \
"Super+Shift+M" "Mod Organizer 2" "Alternative mod manager" \
"Super+Shift+W" "Wabbajack" "Modlist installer" \
"Super+Shift+L" "LOOT" "Load order optimizer" \
"Super+Shift+X" "xEdit" "TES/FO editing tools" \
"Super+Shift+C" "Creation Kit" "Bethesda editor" \
"Super+Shift+F" "FNIS/Nemesis" "Animation tools" \
"" "" "" \
"=== WORKSPACE MANAGEMENT ===" "" "" \
"Super+Ctrl+3" "Workspace 3" "Modding tools workspace" \
"Super+Ctrl+4" "Workspace 4" "File management workspace" \
"Super+Ctrl+5" "Workspace 5" "Web tools workspace" \
"Super+Ctrl+Shift+3" "Move to WS3" "Move window to modding tools" \
"Super+Ctrl+Shift+4" "Move to WS4" "Move window to file manager" \
"Super+Ctrl+Shift+5" "Move to WS5" "Move window to web tools" \
"Super+Alt+M" "Setup Workspaces" "Organize modding workspaces" \
"" "" "" \
"=== FILE MANAGEMENT ===" "" "" \
"Super+Ctrl+D" "Modding Directory" "~/.local/share/modding/" \
"Super+Ctrl+S" "Downloads Folder" "Mod downloads directory" \
"Super+Ctrl+R" "Tools Folder" "Modding utilities" \
"Super+Ctrl+G" "Game Directories" "Game mod folders" \
"Super+Ctrl+A" "Extract Archive" "Extract mod archives" \
"" "" "" \
"=== STEAMTINKERLAUNCH ===" "" "" \
"Super+Alt+T" "STL Quick Actions" "Launch common STL tasks" \
"Super+Alt+Shift+T" "STL Configuration" "Open STL settings" \
"Super+Ctrl+T" "STL Game Settings" "Per-game configurations" \
"Alt+Shift+Enter" "STL Terminal" "STL command line" \
"" "" "" \
"=== MOD ORGANIZER 2 ===" "" "" \
"Super+Alt+O" "MO2 Quick Launch" "Launch MO2 with game" \
"Super+Alt+Shift+O" "MO2 Mod Installer" "Open mod installer" \
"Super+Ctrl+O" "MO2 Profile Manager" "Switch profiles" \
"Super+Alt+Shift+Enter" "MO2 Terminal" "MO2 command line" \
"" "" "" \
"=== VORTEX ===" "" "" \
"Super+Alt+V" "Vortex Quick Actions" "Common Vortex tasks" \
"Super+Alt+Shift+V" "Vortex Deploy" "Deploy mods" \
"Super+Ctrl+V" "Vortex Games" "Manage game instances" \
"Shift+Enter" "Vortex Terminal" "Vortex command line" \
"" "" "" \
"=== WABBAJACK ===" "" "" \
"Super+Alt+W" "Wabbajack Quick Launch" "Launch Wabbajack" \
"Super+Alt+Shift+W" "Download Lists" "Update mod lists" \
"Super+Ctrl+W" "Wabbajack Installer" "Start installation" \
"" "" "" \
"=== WEB TOOLS ===" "" "" \
"Super+Alt+N" "Nexus Mods" "Nexus Mods webapp" \
"Super+Alt+L" "LOOT Web" "LOOT online tool" \
"Super+Alt+D" "Modding Discord" "Modding communities" \
"Super+Alt+W" "Modding Wiki" "Documentation webapp" \
"" "" "" \
"=== TERMINAL CONTROLS ===" "" "" \
"Super+Ctrl+Shift+Enter" "Modding Terminal" "Modding directory terminal" \
"Super+Alt+Shift+Enter" "STL Terminal" "SteamTinkerLaunch terminal" \
"Super+Shift+Enter" "Vortex Terminal" "Vortex directory terminal" \
"" "" "" \
"=== UTILITIES ===" "" "" \
"Super+Ctrl+Shift+B" "Backup Setup" "Backup modding configuration" \
"Super+Ctrl+Shift+R" "Restore Setup" "Restore from backup" \
"Super+Ctrl+Shift+C" "Clean Cache" "Clear modding caches" \
"Super+Ctrl+Shift+U" "Update Tools" "Update modding utilities" \
"" "" "" \
"=== MONITORING ===" "" "" \
"Super+Ctrl+Shift+P" "Process Monitor" "Monitor modding processes" \
"Super+Ctrl+Shift+D" "Disk Usage" "Check mod storage usage" \
"Super+Ctrl+Shift+N" "Download Monitor" "Watch download progress" \
"" "" "" \
"=== GAME LAUNCH ===" "" "" \
"Super+Ctrl+Shift+G" "Launch with Mods" "Start game with mod manager" \
"Super+Alt+Shift+G" "Launch Vanilla" "Start game without mods" \
"Super+Ctrl+Shift+S" "Switch Profiles" "Change mod profiles" \
"" "" "" \
"=== HELP ===" "" "" \
"Super+Shift+Alt+H" "This Help" "Show modding keybinds" \
"Super+Shift+Alt+D" "Documentation" "Open modding docs" \
"" "" "" \
"=== QUICK REFERENCE ===" "" "" \
"Workspace 3" "Modding Tools" "STL, Vortex, MO2, Wabbajack" \
"Workspace 4" "File Management" "Downloads, tools, backups" \
"Workspace 5" "Web Tools" "Nexus Mods, Discord, wiki" \
"" "" "" \
"=== MODDING DIRECTORIES ===" "" "" \
"~/.local/share/modding/" "Main Directory" "All modding files" \
"~/.local/share/modding/downloads/" "Downloads" "Mod archives" \
"~/.local/share/modding/tools/" "Tools" "CLI utilities" \
"~/.local/share/modding/backups/" "Backups" "Config backups" \
"" "" "" \
"=== LEARN MORE ===" "" "" \
"WehttamSnaps GitHub" "Documentation" "https://github.com/Crowdrocker" \
"WehttamSnaps YouTube" "Video Tutorials" "https://youtube.com/@WehttamSnaps"