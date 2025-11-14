# Fallout 4 Modding Guide with Vortex

Complete guide for modding Fallout 4 on Linux using Vortex, optimized for your i7-4790 + RX 580 setup.

---

## 🎮 Initial Game Setup

### Steam Proton Configuration

1. **Right-click Fallout 4 in Steam → Properties**
2. **Compatibility tab:**
   - ☑ Force the use of a specific Steam Play compatibility tool
   - Select: `Proton-GE Latest` (best for Fallout 4)
   - Alternative: `Proton 8.0-5+`

3. **Launch Options:**
   ```
   PROTON_NO_ESYNC=1 PROTON_USE_WINED3D=0 gamemoderun %command%
   ```

### Game Paths

**Installation Directory:**
```
~/.local/share/Steam/steamapps/common/Fallout 4/
```

**Important Directories:**
- `Data/` - All mods go here
- `Fallout4.exe` - Main executable
- `F4SE/` - Script Extender (after installation)

**Save Files:**
```
~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My Games/Fallout4/
```

---

## 🔧 Essential Setup: F4SE (Fallout 4 Script Extender)

**CRITICAL:** F4SE must be installed before ANY script-based mods!

### Installing F4SE

1. **Download F4SE:**
   - Visit: [f4se.silverlock.org](https://f4se.silverlock.org)
   - Download: **Current Build** (not VR version)

2. **Extract to Game Directory:**
   ```bash
   cd ~/Downloads
   7z x f4se_*.7z
   cp -r f4se_*/* ~/.local/share/Steam/steamapps/common/Fallout\ 4/
   ```

3. **Verify Files:**
   ```bash
   ls ~/.local/share/Steam/steamapps/common/Fallout\ 4/
   ```
   Should see:
   - `f4se_1_10_163.dll` (version may vary)
   - `f4se_loader.exe`
   - `f4se_steam_loader.dll`
   - `Data/F4SE/` folder

### Configure Steam to Launch via F4SE

**Method 1: Launch Options (Recommended)**
```
PROTON_NO_ESYNC=1 bash -c 'cd "$STEAM_COMPAT_INSTALL_PATH" && exec "$STEAM_COMPAT_TOOL_PATHS"/proton run ./f4se_loader.exe %command%'
```

**Method 2: Create Custom Script**

Create: `~/.local/bin/fallout4-f4se`
```bash
#!/bin/bash
export PROTON_NO_ESYNC=1
export RADV_PERFTEST=aco
export DXVK_ASYNC=1

cd ~/.local/share/Steam/steamapps/common/Fallout\ 4/
~/.local/share/Steam/steamapps/common/Proton\ 8.0/proton run ./f4se_loader.exe
```

Make executable:
```bash
chmod +x ~/.local/bin/fallout4-f4se
```

### Verify F4SE Installation

1. **Launch game via F4SE**
2. **Open console** (press `~`)
3. **Type:** `GetF4SEVersion`
4. **Should return:** F4SE version number

---

## 📦 Essential Framework Mods

Install these **in this order** before any other mods!

### 1. Unofficial Fallout 4 Patch (UFO4P)

**Purpose:** Fixes thousands of bugs

**Installation:**
1. Nexus: [Unofficial Fallout 4 Patch](https://www.nexusmods.com/fallout4/mods/4598)
2. Vortex → Mod Manager Download
3. Enable and deploy

**Note:** Many mods require UFO4P!

### 2. F4SE (Already installed above)

### 3. Address Library for F4SE Plugins

**Purpose:** Required for many F4SE plugins

**Installation:**
1. Nexus: [Address Library](https://www.nexusmods.com/fallout4/mods/47327)
2. Install via Vortex
3. Enable and deploy

### 4. Buffout 4

**Purpose:** Crash prevention and fixes

**Installation:**
1. Nexus: [Buffout 4](https://www.nexusmods.com/fallout4/mods/47359)
2. Install via Vortex
3. Files go to: `Data/F4SE/Plugins/`

**Configuration:**
Create: `Data/F4SE/Plugins/Buffout4.toml`
```toml
[Compatibility]
F4EE = true

[Fixes]
ActorIsHostileToActor = true
CellInit = true
CreateD3DAndSwapChain = true
EncounterZoneReset = true
GreyMovies = true
MagicEffectApplyEvent = true
MovementPlanner = true
PackageAllocateLocation = true
SafeExit = true
TESObjectREFRGetEncounterZone = true
UnalignedLoad = true
UtilityShader = true

[Patches]
Achievements = true
BSMTAManager = true
BSPreCulledObjects = true
BSTextureStreamerLocalHeap = true
HavokMemorySystem = true
INISettingCollection = true
InputSwitch = true
MaxStdIO = 8192
MemoryManager = false
MemoryManagerDebug = false
ScaleformAllocator = true
SmallBlockAllocator = true
WorkshopMenu = true

[Warnings]
InvalidGrassData = false
```

### 5. Baka ScrapHeap

**Purpose:** Memory manager for better stability

**Installation:**
1. Nexus: [Baka ScrapHeap](https://www.nexusmods.com/fallout4/mods/55012)
2. Install via Vortex

### 6. Weapon Debris Crash Fix

**Purpose:** Fixes common crash during combat

**Installation:**
1. Nexus: [Weapon Debris Crash Fix](https://www.nexusmods.com/fallout4/mods/48078)
2. Install via Vortex

---

## ⚙️ Configuration Files

### Fallout4.ini

**Location:**
```
~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My Games/Fallout4/Fallout4.ini
```

**Add to [General] section:**
```ini
[General]
sStartingConsoleCommand=bat StartMeUp

[Archive]
bInvalidateOlderFiles=1
sResourceDataDirsFinal=

[Launcher]
bEnableFileSelection=1
```

### Fallout4Prefs.ini

**Add to [Launcher] section:**
```ini
[Launcher]
bEnableFileSelection=1
uLastAspectRatio=1
```

### Fallout4Custom.ini

**Create this file:**
```
~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My Games/Fallout4/Fallout4Custom.ini
```

**Add performance tweaks for RX 580:**
```ini
[Display]
iLocation X=0
iLocation Y=0
bFull Screen=1
bBorderless=0
iSize H=1080
iSize W=1920
bTopMostWindow=0
bMaximizeWindow=0
iAdapter=0
iNumFocusShadow=2
flGamma=1.0000

[Imagespace]
bDoRadialBlur=0
bMBEnable=0
bLensFlare=0
bDof=0

[General]
bGamepadEnable=1
bPipboyCompanionEnabled=0
iNumHWThreads=8

[Water]
bUseWaterDisplacements=0
bUseWaterRefractions=0
bUseWaterReflections=0
bUseWaterDepth=1

[Grass]
bAllowCreateGrass=1
fGrassStartFadeDistance=7000.0000
fGrassMaxStartFadeDistance=7000.0000
fGrassMinStartFadeDistance=0.0000
```

---

## 🎯 Vortex Configuration

### Load Order Management

**IMPORTANT:** Fallout 4 uses both:
1. **Plugin Load Order** (.esp/.esl/.esm files)
2. **Archive Load Order** (.ba2 files)

**Vortex handles both automatically with LOOT integration!**

### Setting Up LOOT in Vortex

1. **Vortex → Plugins tab**
2. **Click "Sort Now"** (LOOT will auto-sort)
3. **Review warnings and conflicts**
4. **Deploy changes**

### Must-Have Vortex Extensions

1. **Vortex → Extensions → Find More**
2. **Install:**
   - Collections (for mod packs)
   - Game Support: Fallout 4
   - Optional: Mod Categories

---

## 🌟 Essential Mods

### Performance & Stability

**[Boston FPS Fix](https://www.nexusmods.com/fallout4/mods/26286)**
- Dramatically improves FPS in downtown Boston
- **CRITICAL for RX 580!**

**[Insignificant Object Remover](https://www.nexusmods.com/fallout4/mods/9835)**
- Removes unnecessary objects
- +10-15 FPS

**[Shadow Resolution 2048 → 512](https://www.nexusmods.com/fallout4/mods/1822)**
- Lower shadow quality for better FPS
- Minimal visual impact

**[FAR - Faraway Area Reform](https://www.nexusmods.com/fallout4/mods/20713)**
- LOD improvements
- Better FPS

### UI & Quality of Life

**[Mod Configuration Menu (MCM)](https://www.nexusmods.com/fallout4/mods/21497)**
- In-game mod settings
- Requires: F4SE

**[Full Dialogue Interface](https://www.nexumods.com/fallout4/mods/1235)**
- Shows full dialogue text

**[DEF_UI](https://www.nexusmods.com/fallout4/mods/10654)**
- Better HUD

**[HUDFramework](https://www.nexusmods.com/fallout4/mods/20309)**
- Required for many HUD mods
- Requires: F4SE

### Gameplay

**[Sim Settlements 2](https://www.nexusmods.com/fallout4/mods/47976)**
- Complete settlement overhaul
- Requires: F4SE, HUDFramework

**[Modern Firearms](https://www.nexusmods.com/fallout4/mods/9252)**
- Modern weapon pack

**[AWKCR - Armor and Weapon Keywords Community Resource](https://www.nexusmods.com/fallout4/mods/6091)**
- Framework for armor/weapon mods

**[Armorsmith Extended](https://www.nexusmods.com/fallout4/mods/2228)**
- Expanded crafting
- Requires: AWKCR

### Visual Enhancements (RX 580 Friendly)

**[Vivid Fallout - All in One](https://www.nexusmods.com/fallout4/mods/25714)**
- Texture overhaul
- Use "Performance" option

**[Enhanced Lights and FX](https://www.nexusmods.com/fallout4/mods/13596)**
- Better lighting

**[True Storms](https://www.nexusmods.com/fallout4/mods/4472)**
- Enhanced weather

**[NAC X - Natural and Atmospheric Commonwealth](https://www.nexusmods.com/fallout4/mods/46722)**
- Weather and lighting overhaul
- Lighter than older NAC

---

## 🚀 Performance Optimization for RX 580

### In-Game Settings

**Launcher Graphics Settings:**
- Resolution: 1920x1080
- Antialiasing: TAA
- Anisotropic Filtering: 8x
- Texture Quality: High
- Shadow Quality: Medium
- Shadow Distance: Medium
- Decal Quantity: Medium
- Lighting Quality: Medium
- Godrays Quality: Low (or OFF)

### AMD-Specific Tweaks

**Steam Launch Options (with F4SE):**
```bash
RADV_PERFTEST=aco,sam,nggc DXVK_ASYNC=1 PROTON_NO_ESYNC=1 gamemoderun bash -c 'cd "$STEAM_COMPAT_INSTALL_PATH" && exec "$STEAM_COMPAT_TOOL_PATHS"/proton run ./f4se_loader.exe'
```

### Expected Performance

**RX 580 (8GB) @ 1080p:**
- High Settings + Boston FPS Fix: 50-60 FPS
- High Settings + Performance Mods: 55-65 FPS
- Medium Settings: 60+ FPS (even in Boston)

**Downtown Boston (hardest area):**
- Without mods: 25-40 FPS
- With Boston FPS Fix: 45-55 FPS

---

## 🐛 Common Issues & Fixes

### Game Crashes on Startup

**Solution 1: Verify F4SE**
```bash
# Check F4SE files exist
ls ~/.local/share/Steam/steamapps/common/Fallout\ 4/ | grep f4se
```

**Solution 2: Disable Problem Plugins**
1. Vortex → Plugins tab
2. Disable all mods
3. Enable framework mods only
4. Enable other mods one by one

**Solution 3: Check Buffout4 Logs**
```bash
cat ~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My\ Games/Fallout4/F4SE/Logs/Buffout4/crash-*.log
```

### Infinite Loading Screen

**Causes:**
- Missing master files
- Corrupt save
- Memory issues

**Solutions:**
```bash
# Increase memory limits
echo "vm.max_map_count=1048576" | sudo tee -a /etc/sysctl.conf
sudo sysctl -w vm.max_map_count=1048576
```

**Check for missing masters in Vortex:**
- Plugins tab → look for red warnings
- Install missing dependencies

### FPS Drops in Downtown Boston

**This is normal - Boston is notoriously bad!**

**Solutions:**
1. Install **Boston FPS Fix** (mandatory!)
2. Install **Insignificant Object Remover**
3. Lower godrays to Low or OFF
4. Lower shadow distance

**Nuclear option:**
```bash
# Disable precombines (last resort - breaks some mods)
# Add to Fallout4Prefs.ini
[General]
bUseCombinedObjects=0
bUsePreCreatedSCOL=0
```

### Mods Not Loading

**Check plugin count:**
- Limit: 255 plugins (.esp/.esm)
- Use ESL-flagged plugins to save slots
- Merge similar mods

**Verify load order:**
1. Vortex → Plugins tab
2. Click "Sort Now" (LOOT)
3. Check for conflicts

### CTD During Combat

**Usually weapon debris bug!**

**Solution:**
- Install **Weapon Debris Crash Fix**
- Or disable in Fallout4.ini:
  ```ini
  [NVFlex]
  bNVFlexEnable=0
  ```

---

## 📋 Mod Installation Checklist

**Before installing mods:**

- [ ] F4SE installed and verified
- [ ] UFO4P installed
- [ ] Address Library installed
- [ ] Buffout 4 installed
- [ ] Baka ScrapHeap installed
- [ ] Weapon Debris Crash Fix installed
- [ ] Boston FPS Fix installed
- [ ] Configuration files edited
- [ ] Save game backup created

---

## 🔄 Load Order Template

**Correct plugin order (top to bottom):**

1. **Fallout4.esm**
2. **DLCRobot.esm**
3. **DLCworkshop01.esm**
4. **DLCCoast.esm**
5. **DLCworkshop02.esm**
6. **DLCworkshop03.esm**
7. **DLCNukaWorld.esm**
8. **Unofficial Fallout 4 Patch.esp**
9. **Framework mods** (AWKCR, HUDFramework, etc.)
10. **Large overhauls** (Sim Settlements, etc.)
11. **Weapons & Armor**
12. **Gameplay changes**
13. **Visual mods**
14. **Bug fixes**
15. **Patches** (always load last!)

**Let LOOT sort this automatically!**

---

## 💾 Recommended Mod Loadout for RX 580

**Performance-Friendly Modlist (60+ FPS):**

**Must-Have:**
- Unofficial Fallout 4 Patch
- Buffout 4
- Boston FPS Fix
- Insignificant Object Remover
- MCM
- Full Dialogue Interface

**Quality of Life:**
- DEF_UI
- True Storms
- Enhanced Lights and FX

**Gameplay:**
- Sim Settlements 2 (Lite version)
- Modern Firearms
- Better Perks

**Total Plugin Count:** ~40-50 plugins  
**FPS Impact:** Slight improvement to -5 FPS

---

## 🆘 Emergency Mod Removal

**If game is broken:**

1. **Disable all mods in Vortex**
2. **Purge mods:**
   - Vortex → Mods tab → Purge Mods
3. **Verify game files:**
   - Steam → Right-click Fallout 4 → Properties → Local Files → Verify
4. **Delete configuration:**
   ```bash
   rm -rf ~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My\ Games/Fallout4/*.ini
   ```
5. **Reinstall F4SE**
6. **Start fresh**

---

## 📚 Resources

- **Nexus Mods:** [nexusmods.com/fallout4](https://www.nexusmods.com/fallout4)
- **F4SE:** [f4se.silverlock.org](https://f4se.silverlock.org)
- **LOOT:** [loot.github.io](https://loot.github.io)
- **r/FO4mods:** [reddit.com/r/FO4mods](https://www.reddit.com/r/FO4mods)
- **ProtonDB:** [protondb.com/app/377160](https://www.protondb.com/app/377160)

---

**Good luck in the Commonwealth, Wanderer! ☢️**

*Part of WehttamSnaps Dotfiles*  
*https://github.com/Crowdrocker/wehttamsnaps-dotfiles*