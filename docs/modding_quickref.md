# WehttamSnaps Modding Quick Reference Card

Quick reference for modding your three main games with Vortex on Linux.

---

## 🎮 Launch Commands

### Cyberpunk 2077
```bash
RADV_PERFTEST=aco DXVK_ASYNC=1 PROTON_NO_ESYNC=1 gamemoderun %command%
```

### Fallout 4 (with F4SE)
```bash
RADV_PERFTEST=aco DXVK_ASYNC=1 PROTON_NO_ESYNC=1 gamemoderun bash -c 'cd "$STEAM_COMPAT_INSTALL_PATH" && exec "$STEAM_COMPAT_TOOL_PATHS"/proton run ./f4se_loader.exe'
```

### Starfield (with SFSE)
```bash
RADV_PERFTEST=aco DXVK_ASYNC=1 PROTON_NO_ESYNC=1 gamemoderun bash -c 'cd "$STEAM_COMPAT_INSTALL_PATH" && exec "$STEAM_COMPAT_TOOL_PATHS"/proton run ./sfse_loader.exe'
```

---

## 📦 Essential Frameworks

| Game | Script Extender | Must-Have Mods |
|------|----------------|----------------|
| **Cyberpunk** | ❌ None | CET, RED4ext, ArchiveXL, TweakXL |
| **Fallout 4** | ✅ F4SE | UFO4P, Buffout 4, Boston FPS Fix |
| **Starfield** | ✅ SFSE | Plugins.txt Enabler, StarUI Bundle |

---

## 🚀 Performance Targets (RX 580 @ 1080p)

| Game | Settings | Expected FPS | With Mods |
|------|----------|--------------|-----------|
| **Cyberpunk** | High + FSR Quality | 45-60 | 40-55 |
| **Fallout 4** | High + Perf Mods | 50-60 | 55-65 |
| **Starfield** | Medium + FSR Balanced | 35-50 | 45-60 |

---

## 🔧 Console Commands

### Verify Script Extenders

**Cyberpunk (CET):**
```
~ (console)
Game.GetPlayer():GetDisplayName()
```

**Fallout 4 (F4SE):**
```
~ (console)
GetF4SEVersion
```

**Starfield (SFSE):**
```
~ (console)
GetSFSEVersion
```

---

## 📂 Important Paths

### Game Directories
```bash
# Cyberpunk 2077
~/.local/share/Steam/steamapps/common/Cyberpunk 2077/

# Fallout 4
~/.local/share/Steam/steamapps/common/Fallout 4/

# Starfield
~/.local/share/Steam/steamapps/common/Starfield/
```

### Save Files
```bash
# Cyberpunk 2077
~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/Saved Games/CD Projekt Red/Cyberpunk 2077/

# Fallout 4
~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My Games/Fallout4/

# Starfield
~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My Games/Starfield/
```

---

## 🐛 Quick Troubleshooting

### Game Won't Launch
```bash
# 1. Disable all mods in Vortex
# 2. Verify game files
# 3. Check script extender installation
# 4. Check launch options

# Verify game files:
# Steam → Right-click game → Properties → Local Files → Verify Integrity
```

### Mods Not Loading

**Cyberpunk:**
```bash
# Check logs
cat ~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/AppData/Local/Cyberpunk\ 2077/cyber_engine_tweaks.log
```

**Fallout 4:**
```bash
# Check Buffout crash logs
cat ~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My\ Games/Fallout4/F4SE/Logs/Buffout4/crash-*.log
```

**Starfield:**
```bash
# Check plugins.txt
cat ~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/AppData/Local/Starfield/plugins.txt
```

### Low FPS

**All Games:**
```bash
# Enable gamemode
gamemoderun

# Check if gamemode is active
gamemoded -s

# Monitor performance
mangohud
```

---

## 💾 Backup Commands

### Quick Backup Script
```bash
#!/bin/bash
# Save to: ~/.local/bin/backup-saves

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_BASE=~/Documents/Game_Saves_Backup

# Cyberpunk
cp -r ~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/Saved\ Games/CD\ Projekt\ Red/Cyberpunk\ 2077/ \
    $BACKUP_BASE/Cyberpunk_$TIMESTAMP/

# Fallout 4
cp -r ~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My\ Games/Fallout4/ \
    $BACKUP_BASE/Fallout4_$TIMESTAMP/

# Starfield
cp -r ~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My\ Games/Starfield/ \
    $BACKUP_BASE/Starfield_$TIMESTAMP/

echo "Backups saved to: $BACKUP_BASE"
```

Make executable:
```bash
chmod +x ~/.local/bin/backup-saves
```

---

## 🔑 Keyboard Shortcuts

### Vortex
- `Ctrl+M` - Enable/Disable mod
- `Ctrl+D` - Deploy mods
- `Ctrl+P` - Purge mods
- `F5` - Refresh

### In-Game Consoles
- `~` (Tilde) - Open console (all games)
- `Page Up/Down` - Scroll console
- `Esc` - Close console

---

## 📊 Mod Limits

| Game | Plugin Limit | Notes |
|------|-------------|-------|
| **Cyberpunk** | ~500 | Archive files (.archive) |
| **Fallout 4** | 255 | .esp/.esm files (use ESL!) |
| **Starfield** | 256 | .esm/.esp files |

---

## 🎯 RX 580 Optimization Settings

### Cyberpunk 2077
- Ray Tracing: **OFF**
- FSR 2.1: **Quality**
- Texture Quality: **High**
- Volumetric Fog: **Low**

### Fallout 4
- Shadow Distance: **Medium**
- Godrays: **LOW or OFF**
- TAA: **ON**
- Shadow Resolution: **2048**

### Starfield
- Volumetric Lighting: **OFF**
- Contact Shadows: **OFF**
- FSR 2: **Balanced or Performance**
- Motion Blur: **OFF**

---

## 🆘 Emergency Recovery

**Nuclear option if everything is broken:**

```bash
#!/bin/bash
# Reset modding setup for a game
# Usage: ./reset-game.sh [cyberpunk|fallout4|starfield]

GAME=$1

case $GAME in
    cyberpunk)
        APPID=1091500
        GAME_NAME="Cyberpunk 2077"
        ;;
    fallout4)
        APPID=377160
        GAME_NAME="Fallout 4"
        ;;
    starfield)
        APPID=1716740
        GAME_NAME="Starfield"
        ;;
    *)
        echo "Usage: $0 [cyberpunk|fallout4|starfield]"
        exit 1
        ;;
esac

echo "Resetting $GAME_NAME..."

# 1. Disable all mods in Vortex (manual step)
echo "1. Open Vortex and disable all mods for $GAME_NAME"
read -p "Press Enter when done..."

# 2. Purge mods (manual step)
echo "2. Click 'Purge Mods' in Vortex"
read -p "Press Enter when done..."

# 3. Delete shader cache
rm -rf ~/.local/share/Steam/steamapps/shadercache/$APPID/
echo "✓ Shader cache deleted"

# 4. Reset Proton prefix
rm -rf ~/.local/share/Steam/steamapps/compatdata/$APPID/
echo "✓ Proton prefix deleted (will regenerate on next launch)"

# 5. Verify files in Steam
echo "3. Go to Steam → Right-click $GAME_NAME → Properties → Local Files → Verify Integrity"
read -p "Press Enter when done..."

echo "✓ $GAME_NAME reset complete!"
echo "Reinstall script extender if needed, then add mods back one by one"
```

---

## 📱 Quick Commands Cheatsheet

```bash
# Launch Vortex
vortex

# Start game with optimizations (from terminal)
cd ~/.local/share/Steam/steamapps/common/[GAME]/
RADV_PERFTEST=aco DXVK_ASYNC=1 gamemoderun ./[game].exe

# Monitor FPS
mangohud [game_command]

# Check if gamemode is running
gamemoded -s

# View game logs (Proton)
cat ~/.local/share/Steam/steamapps/compatdata/[APPID]/pfx/steam.log

# Clear shader cache (if stuttering)
rm -rf ~/.local/share/Steam/steamapps/shadercache/[APPID]/

# Increase virtual memory (if crashes)
sudo sysctl -w vm.max_map_count=1048576
```

---

## 🔗 Essential Links

**Nexus Mods:**
- Cyberpunk: [nexusmods.com/cyberpunk2077](https://www.nexusmods.com/cyberpunk2077)
- Fallout 4: [nexusmods.com/fallout4](https://www.nexusmods.com/fallout4)
- Starfield: [nexusmods.com/starfield](https://www.nexusmods.com/starfield)

**Script Extenders:**
- CET (Cyber Engine Tweaks): [Nexus](https://www.nexusmods.com/cyberpunk2077/mods/107)
- F4SE: [f4se.silverlock.org](https://f4se.silverlock.org)
- SFSE: [GitHub](https://github.com/ianpatt/sfse)

**ProtonDB (Compatibility):**
- Cyberpunk: [protondb.com/app/1091500](https://www.protondb.com/app/1091500)
- Fallout 4: [protondb.com/app/377160](https://www.protondb.com/app/377160)
- Starfield: [protondb.com/app/1716740](https://www.protondb.com/app/1716740)

---

**Keep this card handy while modding! 🎮**

*Part of WehttamSnaps Dotfiles*  
*https://github.com/Crowdrocker/wehttamsnaps-dotfiles*