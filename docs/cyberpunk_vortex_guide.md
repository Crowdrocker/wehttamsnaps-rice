# Cyberpunk 2077 Modding Guide with Vortex

Complete guide for modding Cyberpunk 2077 on Linux using Vortex, with working CET, REDx, and TweakXL.

---

## 🎮 Initial Game Setup

### Steam Proton Configuration

1. **Right-click Cyberpunk 2077 in Steam → Properties**
2. **Compatibility tab:**
   - ☑ Force the use of a specific Steam Play compatibility tool
   - Select: `Proton Experimental` or `Proton 8.0-5+`

3. **Launch Options:**
   ```
   gamemoderun PROTON_NO_ESYNC=1 DXVK_ASYNC=1 %command%
   ```

### Verify Game Installation

**Game Path:**
```
~/.local/share/Steam/steamapps/common/Cyberpunk 2077/
```

**Key Directories:**
- `bin/x64/` - Game executable
- `archive/pc/mod/` - Most mods go here
- `r6/scripts/` - Script mods
- `red4ext/plugins/` - REDx plugins

---

## 🔧 Essential Framework Installation Order

**CRITICAL:** Install these in this exact order!

### 1. Cyber Engine Tweaks (CET)

**Why it's essential:** Required for almost all script mods, console commands, and many gameplay tweaks.

**Installation:**

1. **Download from Nexus:**
   - [Cyber Engine Tweaks](https://www.nexusmods.com/cyberpunk2077/mods/107)
   - Use "Mod Manager Download" button

2. **Vortex Installation:**
   - Vortex will detect and install automatically
   - Files go to: `bin/x64/plugins/cyber_engine_tweaks/`

3. **Verify Installation:**
   - Launch game
   - Press `~` (tilde) or `Home` key
   - CET console should appear
   - Type: `Game.GetPlayer():GetDisplayName()`
   - Should show "V"

**Troubleshooting CET on Linux:**

If console doesn't appear:

```bash
# Check if CET loaded
cd ~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/AppData/Local/Cyberpunk\ 2077/

# Look for cyber_engine_tweaks.log
cat cyber_engine_tweaks.log
```

**Common fix:**
```bash
# Steam launch options - add this:
WINEDLLOVERRIDES="version.dll=n,b;winmm.dll=n,b" gamemoderun PROTON_NO_ESYNC=1 DXVK_ASYNC=1 %command%
```

### 2. RED4ext

**Why it's essential:** Native code plugin framework, required for many advanced mods.

**Installation:**

1. **Download from Nexus:**
   - [RED4ext](https://www.nexusmods.com/cyberpunk2077/mods/2380)
   - Manual download (important!)

2. **Manual Installation via Vortex:**
   - Drag .zip file into Vortex
   - Install as usual
   - Files go to: `red4ext/`

3. **Verify Installation:**
   - Launch game
   - Open CET console (`~`)
   - Type: `print("RED4ext loaded")`
   - Should work without errors

**Linux-Specific RED4ext Setup:**

Create/edit: `red4ext/config.ini`
```ini
[Logging]
Enabled=1
Flush=1
Level=Info

[Developer]
RemoveDeadMods=1
```

### 3. ArchiveXL

**Why it's essential:** Allows loading custom items, vehicles, and assets.

**Installation:**

1. **Download from Nexus:**
   - [ArchiveXL](https://www.nexusmods.com/cyberpunk2077/mods/4198)

2. **Vortex Installation:**
   - Install normally
   - Files go to: `red4ext/plugins/ArchiveXL/`

3. **Verify Installation:**
   - CET console: `print(GetVersion("ArchiveXL"))`

### 4. TweakXL

**Why it's essential:** Allows mods to modify game tweaks without conflicts.

**Installation:**

1. **Download from Nexus:**
   - [TweakXL](https://www.nexusmods.com/cyberpunk2077/mods/4197)

2. **Vortex Installation:**
   - Install normally
   - Files go to: `red4ext/plugins/TweakXL/`

3. **Verify Installation:**
   - CET console: `print(GetVersion("TweakXL"))`

### 5. Codeware

**Why it's essential:** Required for many quality-of-life mods.

**Installation:**

1. **Download from Nexus:**
   - [Codeware](https://www.nexusmods.com/cyberpunk2077/mods/7780)

2. **Vortex Installation:**
   - Install normally
   - Files go to: `red4ext/plugins/Codeware/`

---

## 🎯 Vortex Configuration for Cyberpunk

### Game Settings in Vortex

1. **Open Vortex → Games tab**
2. **Find Cyberpunk 2077**
3. **Click gear icon → Edit**

**Game Discovery Path:**
```
~/.local/share/Steam/steamapps/common/Cyberpunk 2077/
```

**Mod Staging Folder:**
```
~/Games/VortexMods/cyberpunk2077/
```

### Deployment Settings

1. **Vortex → Settings → Mods**
2. **Deployment Method:** Hardlink Deployment (default)
3. ☑ **Deploy mods when enabled**
4. ☑ **Start deployment on game launch**

### Load Order

Cyberpunk mods don't have a traditional load order like Bethesda games. However:

1. **Framework mods load first** (CET, RED4ext, etc.)
2. **TweakXL handles conflicts** automatically
3. **CET mods can have priority** in `init.lua`

---

## 📦 Essential Mods (Tested & Working)

### Quality of Life

**[Native Settings UI](https://www.nexusmods.com/cyberpunk2077/mods/3518)**
- Adds in-game settings menu for mods
- Requires: CET

**[Enhanced Craft](https://www.nexusmods.com/cyberpunk2077/mods/4378)**
- Better crafting system
- Requires: TweakXL

**[Let There Be Flight](https://www.nexusmods.com/cyberpunk2077/mods/5876)**
- Flying cars!
- Requires: CET, RED4ext, Codeware

**[Vehicle Combat](https://www.nexusmods.com/cyberpunk2077/mods/3815)**
- Shoot from vehicles
- Requires: CET, RED4ext

### Visual Enhancements

**[Nova LUT](https://www.nexusmods.com/cyberpunk2077/mods/1772)**
- Better color grading
- No requirements

**[HD Reworked Project](https://www.nexusmods.com/cyberpunk2077/mods/7935)**
- High-res textures
- RX 580: Use "Performance" version

**[Weather Probability Rebalance](https://www.nexusmods.com/cyberpunk2077/mods/3196)**
- More varied weather
- Requires: TweakXL

### Gameplay

**[Full Gameplay Rebalance](https://www.nexusmods.com/cyberpunk2077/mods/4378)**
- Complete combat overhaul
- Requires: TweakXL, RED4ext

**[Equipment-EX](https://www.nexusmods.com/cyberpunk2077/mods/6945)**
- Transmog system
- Requires: RED4ext, TweakXL, ArchiveXL

**[Lifepath Bonuses and Challenges](https://www.nexusmods.com/cyberpunk2077/mods/2217)**
- Meaningful lifepath choices
- Requires: TweakXL

---

## 🐛 Troubleshooting

### CET Console Not Opening

**Solution 1: Check Key Bindings**
```
CET Config: ~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/AppData/Local/Cyberpunk 2077/cyber_engine_tweaks/config.json
```

Change:
```json
{
  "console_key": "192"  // Tilde key
}
```

**Solution 2: DLL Overrides**
```bash
# Steam launch options:
WINEDLLOVERRIDES="version.dll=n,b;winmm.dll=n,b;d3d11.dll=n,b" gamemoderun PROTON_NO_ESYNC=1 DXVK_ASYNC=1 %command%
```

**Solution 3: Check CET Version**
- Update to latest CET
- Verify game version compatibility
- Check: CET releases page

### RED4ext Plugins Not Loading

**Check RED4ext.log:**
```bash
cd ~/.local/share/Steam/steamapps/common/Cyberpunk\ 2077/red4ext/logs/
cat RED4ext.log
```

**Common Issues:**

1. **Missing dependencies:**
   ```
   Error: Could not find plugin dependency: XYZ
   ```
   → Install missing plugin

2. **Wrong game version:**
   ```
   Error: Plugin compiled for different game version
   ```
   → Update plugin or wait for update

3. **File permissions:**
   ```bash
   chmod -R 755 ~/.local/share/Steam/steamapps/common/Cyberpunk\ 2077/red4ext/
   ```

### Mods Not Working After Update

1. **Disable all mods in Vortex**
2. **Launch game to verify it works**
3. **Enable frameworks only:** CET, RED4ext, ArchiveXL, TweakXL
4. **Test again**
5. **Enable other mods one by one**

### Game Crashes on Launch

**RX 580 Specific Fix:**
```bash
# Steam launch options:
RADV_PERFTEST=aco DXVK_ASYNC=1 PROTON_NO_ESYNC=1 gamemoderun %command%
```

**Memory Issues:**
```bash
# Increase virtual memory
sudo sysctl -w vm.max_map_count=1048576

# Make permanent
echo "vm.max_map_count=1048576" | sudo tee -a /etc/sysctl.conf
```

### Save Game Corruption

**Backup saves before modding:**
```bash
cp -r ~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/Saved\ Games/CD\ Projekt\ Red/Cyberpunk\ 2077/ ~/Documents/Cyberpunk_Saves_Backup/
```

**Automatic backup script:**
```bash
#!/bin/bash
BACKUP_DIR=~/Documents/Cyberpunk_Saves_Backup/$(date +%Y%m%d-%H%M%S)
SAVE_DIR=~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/Saved\ Games/CD\ Projekt\ Red/Cyberpunk\ 2077/
cp -r "$SAVE_DIR" "$BACKUP_DIR"
echo "Backup saved to: $BACKUP_DIR"
```

---

## 🚀 Performance Optimization for RX 580

### In-Game Settings

**Graphics Preset:** High (not Ultra)

**Key Settings:**
- Ray Tracing: OFF (RX 580 doesn't support RT)
- DLSS/FSR: FSR 2.1 Quality
- Resolution: 1920x1080
- VSync: OFF
- FPS Limit: 60

### AMD-Specific Launch Options

**Best performance:**
```bash
RADV_PERFTEST=aco,sam,nggc DXVK_ASYNC=1 PROTON_NO_ESYNC=1 gamemoderun mangohud %command%
```

### Config File Tweaks

**Edit:** `~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/AppData/Local/CD Projekt Red/Cyberpunk 2077/UserSettings.json`

```json
{
  "rendering": {
    "DynamicDecals": false,
    "MaxDynamicDecals": "Low",
    "ScreenSpaceReflection": false
  }
}
```

### Expected Performance

**RX 580 (8GB) @ 1080p:**
- High Settings + FSR Quality: 45-60 FPS
- Medium Settings + FSR Balanced: 55-65 FPS
- Low Settings + FSR Performance: 60+ FPS

---

## 📋 Mod Installation Checklist

**Before installing ANY mod:**

- [ ] Framework mods installed (CET, RED4ext, ArchiveXL, TweakXL)
- [ ] All frameworks verified working
- [ ] Game launches without mods
- [ ] Backup save created
- [ ] Check mod requirements on Nexus page
- [ ] Check mod compatibility with current game version
- [ ] Deploy mods in Vortex
- [ ] Test in-game

---

## 🔄 Updating Mods

### When Game Updates:

1. **Disable all mods in Vortex**
2. **Launch game to verify update**
3. **Wait for framework updates:**
   - CET usually updates first
   - RED4ext within 24-48 hours
   - Other plugins follow
4. **Update mods in Vortex:**
   - Check notifications for updates
   - Update frameworks first
   - Then update other mods
5. **Re-enable mods one by one**

### Checking for Updates

**In Vortex:**
- Mods tab → notification bell icon
- Shows available updates

**Manually:**
- Track mods on Nexus
- Enable email notifications

---

## 💾 Recommended Mod Loadout for RX 580

**Performance-Friendly Mod List:**

**Frameworks (Required):**
- Cyber Engine Tweaks
- RED4ext
- ArchiveXL
- TweakXL
- Codeware

**Visual (Light):**
- Nova LUT
- Better Headlights
- Preem Clutter Remover (improves FPS!)

**Gameplay:**
- Native Settings UI
- Enhanced Craft
- Lifepath Bonuses
- Better Loot

**Quality of Life:**
- Quickhack Hotkeys
- Simple Menu
- Stash Anywhere

**Total FPS Impact:** -5 to -10 FPS

---

## 🆘 Emergency Mod Removal

**If game won't launch:**

1. **Disable all mods in Vortex**
2. **Purge deployment:**
   - Vortex → Mods tab → Purge Mods
3. **Verify game files in Steam:**
   - Right-click game → Properties → Local Files → Verify Integrity
4. **Clear shader cache:**
   ```bash
   rm -rf ~/.local/share/Steam/steamapps/shadercache/1091500/
   ```

---

## 📚 Resources

- **Nexus Mods:** [nexusmods.com/cyberpunk2077](https://www.nexusmods.com/cyberpunk2077)
- **CET Wiki:** [wiki.redmodding.org/cyber-engine-tweaks](https://wiki.redmodding.org/cyber-engine-tweaks)
- **RED4ext Docs:** [docs.red4ext.com](https://docs.red4ext.com)
- **r/LowSodiumCyberpunk:** [reddit.com/r/LowSodiumCyberpunk](https://www.reddit.com/r/LowSodiumCyberpunk)
- **ProtonDB:** [protondb.com/app/1091500](https://www.protondb.com/app/1091500)

---

## 🎮 Quick Reference Commands

**Launch game with mods:**
```bash
# From terminal (with optimizations)
cd ~/.local/share/Steam/steamapps/common/Cyberpunk\ 2077/bin/x64/
RADV_PERFTEST=aco DXVK_ASYNC=1 gamemoderun ./Cyberpunk2077.exe
```

**Check CET console:**
- In-game: Press `~` or `Home`
- Commands:
  - `print(GetVersion("CET"))` - Check CET version
  - `print(GetVersion("RED4ext"))` - Check RED4ext
  - `Game.GetPlayer():GetDisplayName()` - Test CET

**View logs:**
```bash
# CET log
cat ~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/AppData/Local/Cyberpunk\ 2077/cyber_engine_tweaks.log

# RED4ext log
cat ~/.local/share/Steam/steamapps/common/Cyberpunk\ 2077/red4ext/logs/RED4ext.log
```

---

**Happy modding, Choom! 🤖**

*Part of WehttamSnaps Dotfiles*  
*https://github.com/Crowdrocker/wehttamsnaps-dotfiles*