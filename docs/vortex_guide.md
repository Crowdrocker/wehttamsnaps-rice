# Vortex Mod Manager Guide for WehttamSnaps

Complete guide for using Vortex Mod Manager on your Arch Linux gaming setup.

---

## 📦 Installation

Run the setup script:
```bash
chmod +x ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
```

**Installation time:** ~30-45 minutes (mostly .NET Framework)

---

## 🎮 First Launch Setup

### 1. Launch Vortex
```bash
vortex
```
Or use your app launcher to search for "Vortex"

### 2. Initial Configuration

1. **Log in to Nexus Mods**
   - Click "Login" in top right
   - Use your Nexus Mods account
   - Grant permissions

2. **Set Up Game Discovery**
   - Click "Games" tab
   - Click "Search for Games"
   - Common Steam game locations:
     - `~/.local/share/Steam/steamapps/common/`
     - `~/.steam/steam/steamapps/common/`

3. **Configure Staging Folder**
   - Settings → Mods
   - Default location is fine: `~/Documents/My Games/Vortex/`
   - Or change to: `~/Games/VortexMods/`

---

## 🎯 Game-Specific Setup

### Skyrim Special Edition / Anniversary Edition

**Steam Proton Setup:**
1. Right-click game in Steam → Properties → Compatibility
2. Select: `Proton Experimental` or `Proton-GE`

**Vortex Configuration:**
```
Game Path: ~/.local/share/Steam/steamapps/common/Skyrim Special Edition/
Mod Staging: ~/Games/VortexMods/skyrimse/
```

**Important Files:**
- Game executable: `SkyrimSELauncher.exe` (not the main exe)
- Data folder: `~/.local/share/Steam/steamapps/common/Skyrim Special Edition/Data/`

**SKSE (Skyrim Script Extender):**
1. Download SKSE from [skse.silverlock.org](https://skse.silverlock.org)
2. Extract to game directory
3. Launch via `skse64_loader.exe` (not the launcher)

**Steam Launch Options:**
```
PROTON_USE_WINED3D=0 WINEDLLOVERRIDES="d3d11=n,b;dxgi=n,b" %command%
```

---

### Fallout 4

**Steam Proton Setup:**
- Use `Proton-GE` for best compatibility

**Vortex Configuration:**
```
Game Path: ~/.local/share/Steam/steamapps/common/Fallout 4/
Mod Staging: ~/Games/VortexMods/fallout4/
```

**F4SE (Fallout 4 Script Extender):**
1. Download from [f4se.silverlock.org](https://f4se.silverlock.org)
2. Extract to game root
3. Launch via `f4se_loader.exe`

**Steam Launch Options:**
```
PROTON_NO_ESYNC=1 %command%
```

**Configuration Files:**
Edit these in Vortex → Settings → Plugins:
- `Fallout4.ini`
- `Fallout4Prefs.ini`
- `Fallout4Custom.ini`

---

### Cyberpunk 2077

**Steam Proton Setup:**
- Use `Proton Experimental` or `Proton 8.0+`

**Vortex Configuration:**
```
Game Path: ~/.local/share/Steam/steamapps/common/Cyberpunk 2077/
Mod Staging: ~/Games/VortexMods/cyberpunk2077/
```

**Important Notes:**
- Cyberpunk uses REDmod for official mod support
- Most mods go in: `archive/pc/mod/`
- Some script mods go in: `r6/scripts/`

**Steam Launch Options:**
```
gamemoderun PROTON_NO_ESYNC=1 DXVK_ASYNC=1 %command%
```

**Popular Mods:**
- Cyber Engine Tweaks (scripting framework)
- RED4ext (plugin framework)
- ArchiveXL (asset framework)

---

### The Witcher 3

**Steam Proton Setup:**
- Use `Proton 8.0+` or `Proton-GE`

**Vortex Configuration:**
```
Game Path: ~/.local/share/Steam/steamapps/common/The Witcher 3/
Mod Staging: ~/Games/VortexMods/witcher3/
```

**Mod Locations:**
- Most mods: `Mods/`
- DLC mods: `DLC/`

**Steam Launch Options:**
```
gamemoderun %command%
```

---

### Baldur's Gate 3

**Native Linux Version!**
- Use the native Linux version (no Proton needed)
- Better performance than Windows version

**Vortex Configuration:**
```
Game Path: ~/.local/share/Steam/steamapps/common/Baldurs Gate 3/
Mod Staging: ~/Games/VortexMods/baldursgate3/
```

**BG3 Mod Manager Alternative:**
- Consider using native [BG3 Mod Manager](https://github.com/LaughingLeader/BG3ModManager)
- Better Linux support than Vortex for BG3

---

## 🛠️ Common Vortex Operations

### Installing Mods

1. **From Nexus Mods:**
   - Click "Mod Manager Download" on any mod page
   - Vortex will automatically download and install

2. **Manual Installation:**
   - Download mod manually
   - Drag .zip/.7z/.rar into Vortex
   - Or: Mods tab → Install From File

### Managing Load Order

1. Go to "Plugins" tab
2. Use drag-and-drop to reorder
3. Enable/disable mods with checkboxes
4. Use "Auto Sort" for LOOT-based sorting (Bethesda games)

### Deploying Mods

**Important:** Mods must be deployed to work!

1. Mods tab → Deploy Mods button
2. Or: Vortex auto-deploys on game launch
3. Check deployment status in Mods tab

### Profiles

Create separate mod setups:
1. Profiles dropdown (top right)
2. Create New Profile
3. Switch between profiles
4. Each profile has own mod list and load order

---

## 🐛 Troubleshooting

### Vortex Won't Start

```bash
# Reset Wine prefix
rm -rf ~/.local/share/wineprefixes/vortex

# Run setup again
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
```

### Mods Not Appearing In-Game

1. **Check Deployment:**
   - Mods tab → green "Deployed" indicator
   - If red, click "Deploy Mods"

2. **Check Load Order:**
   - Plugins tab → ensure enabled
   - Resolve any conflicts (red lightning icon)

3. **Check Game Launch:**
   - Some games need script extenders (SKSE, F4SE)
   - Launch via extender, not base game

4. **Verify Installation Paths:**
   - Settings → Games
   - Ensure paths point to actual game directories
   - Watch for symlink issues

### Performance Issues

```bash
# Add to Vortex launcher
export DXVK_ASYNC=1
export RADV_PERFTEST=aco
```

### Mods Causing Crashes

1. **Disable Recently Added Mods:**
   - Mods tab → disable suspicious mods
   - Deploy and test

2. **Check Mod Requirements:**
   - Many mods need frameworks (SKSE, F4SE, etc.)
   - Read mod descriptions carefully

3. **Load Order Conflicts:**
   - Use LOOT (integrated in Vortex for Bethesda games)
   - Check for red warnings in Plugins tab

---

## 🚀 Performance Tips

### Wine/Proton Optimization

Add to `~/.local/bin/vortex`:
```bash
export DXVK_ASYNC=1
export RADV_PERFTEST=aco
export WINE_CPU_TOPOLOGY=8:4
```

### Game-Specific Launch Options

**For Better Stability:**
```
PROTON_NO_ESYNC=1 PROTON_NO_FSYNC=1 %command%
```

**For Better Performance:**
```
gamemoderun DXVK_ASYNC=1 mangohud %command%
```

**For Older Games:**
```
PROTON_USE_WINED3D=1 %command%
```

---

## 🔄 Alternative: Mod Organizer 2

**Better Linux Compatibility:**

Mod Organizer 2 often works better than Vortex on Linux:

1. **Install via ProtonUp-Qt:**
   ```bash
   paru -S protonup-qt
   protonup-qt
   ```

2. **Select Game in ProtonUp-Qt**
   - Choose your game
   - Install MO2 compatibility layer

3. **Launch MO2:**
   - Use ProtonUp-Qt's launch button
   - Or add to Steam as non-Steam game

**Advantages:**
- Better virtual file system (no deployment needed)
- More control over load order
- Better conflict resolution
- Native Linux versions for some games

---

## 📝 Vortex Keybind for Niri

Add to `~/.config/niri/conf.d/10-keybinds.kdl`:

```kdl
// Vortex Mod Manager
Mod+Shift+V { spawn "vortex"; }
```

Reload Niri config: `Mod+Shift+C`

---

## 🎮 Recommended Mod Collections

### Skyrim SE - Stability & Fixes
- Unofficial Skyrim Special Edition Patch (USSEP)
- SSE Engine Fixes
- SSE Display Tweaks
- Scrambled Bugs

### Fallout 4 - Essential Mods
- Unofficial Fallout 4 Patch (UFO4P)
- Buffout 4
- Weapon Debris Crash Fix
- Baka Scrap Heap

### Cyberpunk 2077 - Quality of Life
- Cyber Engine Tweaks
- RED4ext
- ArchiveXL
- TweakXL

---

## 📚 Resources

- **Nexus Mods:** [nexusmods.com](https://www.nexusmods.com)
- **Vortex Wiki:** [wiki.nexusmods.com/index.php/Vortex](https://wiki.nexusmods.com/index.php/Vortex)
- **ProtonDB:** [protondb.com](https://www.protondb.com) (for game compatibility)
- **r/linux_gaming:** [reddit.com/r/linux_gaming](https://www.reddit.com/r/linux_gaming/)

---

## ⚙️ Uninstall

```bash
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh --uninstall
```

---

**Happy Modding! 🎮**

*Part of WehttamSnaps Dotfiles*  
*https://github.com/Crowdrocker/wehttamsnaps-dotfiles*