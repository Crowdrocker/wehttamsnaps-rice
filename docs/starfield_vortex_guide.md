# Starfield Modding Guide with Vortex

Complete guide for modding Starfield on Linux using Vortex, optimized for your upgraded i7-4790 + RX 580 system.

---

## 🎮 Initial Game Setup

### Steam Proton Configuration

1. **Right-click Starfield in Steam → Properties**
2. **Compatibility tab:**
   - ☑ Force the use of a specific Steam Play compatibility tool
   - Select: `Proton Experimental` (best for Starfield)
   - Alternative: `Proton-GE Latest`

3. **Launch Options:**
   ```
   PROTON_NO_ESYNC=1 PROTON_ENABLE_NVAPI=1 DXVK_ASYNC=1 gamemoderun %command%
   ```

### Game Paths

**Installation Directory:**
```
~/.local/share/Steam/steamapps/common/Starfield/
```

**Important Directories:**
- `Data/` - All mods go here
- `Starfield.exe` - Main executable
- `SFSE/` - Script Extender (after installation)

**Configuration Files:**
```
~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My Games/Starfield/
```

---

## 🔧 Essential Setup: SFSE (Starfield Script Extender)

**CRITICAL:** Many popular mods require SFSE!

### Installing SFSE

1. **Download SFSE:**
   - Visit: [sfse.silverlock.org](https://sfse.silverlock.org) (when available)
   - **OR** GitHub: [ianpatt/sfse](https://github.com/ianpatt/sfse) (current location)
   - Download latest release

2. **Extract to Game Directory:**
   ```bash
   cd ~/Downloads
   7z x sfse_*.7z
   cp -r sfse_*/* ~/.local/share/Steam/steamapps/common/Starfield/
   ```

3. **Verify Files:**
   ```bash
   ls ~/.local/share/Steam/steamapps/common/Starfield/
   ```
   Should see:
   - `sfse_loader.exe`
   - `sfse_*.dll`
   - `Data/SFSE/` folder

### Configure Steam to Launch via SFSE

**Steam Launch Options:**
```bash
PROTON_NO_ESYNC=1 DXVK_ASYNC=1 bash -c 'cd "$STEAM_COMPAT_INSTALL_PATH" && exec "$STEAM_COMPAT_TOOL_PATHS"/proton run ./sfse_loader.exe %command%'
```

### Verify SFSE Installation

1. **Launch game via SFSE**
2. **Open console** (press `~`)
3. **Type:** `GetSFSEVersion`
4. **Should return:** SFSE version number

**Note:** SFSE for Starfield is still in early development. Check for updates frequently!

---

## 📦 Essential Framework Mods

### 1. Plugins.txt Enabler

**Purpose:** Enables mod loading in Starfield

**Installation:**
1. Nexus: [Plugins.txt Enabler](https://www.nexusmods.com/starfield/mods/4157)
2. **MANUAL INSTALLATION REQUIRED:**
   ```bash
   # Download and extract
   cd ~/Downloads
   7z x plugins.txt.enabler.*.zip
   
   # Copy files
   cp Data/SFSE/Plugins/* ~/.local/share/Steam/steamapps/common/Starfield/Data/SFSE/Plugins/
   ```

3. **Create plugins.txt:**
   ```bash
   touch ~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/AppData/Local/Starfield/plugins.txt
   ```

### 2. StarUI Workbench

**Purpose:** Better workbench interface

**Installation:**
1. Nexus: [StarUI Workbench](https://www.nexusmods.com/starfield/mods/2667)
2. Install via Vortex
3. Requires: SFSE

### 3. StarUI Inventory

**Purpose:** Improved inventory management

**Installation:**
1. Nexus: [StarUI Inventory](https://www.nexusmods.com/starfield/mods/773)
2. Install via Vortex
3. Requires: SFSE

### 4. Achievement Enabler

**Purpose:** Keep achievements with mods

**Installation:**
1. Nexus: [Achievement Enabler](https://www.nexusmods.com/starfield/mods/296)
2. Install via Vortex

---

## ⚙️ Configuration Files

### StarfieldCustom.ini

**Location:**
```
~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My Games/Starfield/StarfieldCustom.ini
```

**Create this file with:**
```ini
[Archive]
bInvalidateOlderFiles=1
sResourceDataDirsFinal=

[General]
bEnableGlobalInvalidation=1

[Display]
iSize H=1080
iSize W=1920
bFull Screen=1
bBorderless=0

[Imagespace]
bDoRadialBlur=0
bLensFlare=0
bDoDepthOfField=0
bMBEnable=0

[Grass]
iMaxGrassTypesPerTexture=2
iMinGrassSize=20

[VRSS]
bDisableVRS=1

[LOD]
fLODFadeOutMultSkyCell=1.0000
fLODFadeOutMultObjects=8.0000
fLODFadeOutMultItems=4.0000
fLODFadeOutMultActors=8.0000

[Water]
bUseWaterReflections=0
bUseWaterRefractions=0
bUseWaterDepth=1

[Display]
iVolumetricLightingQuality=0
bVolumetricLightingEnable=0
```

### StarfieldPrefs.ini Tweaks

**Add to [Display] section for better performance on RX 580:**
```ini
[Display]
iShadowMapResolution=2048
uVolumetricLightingQuality=0
bVolumetricLightingEnable=0
bSAOEnable=0
bMBEnable=0
iContactShadowLevel=0
bLensFlare=0
```

---

## 🎯 Vortex Configuration

### Load Order Management

**Starfield uses .esm/.esp plugins like other Bethesda games.**

**Vortex LOOT Integration:**
1. Vortex → Plugins tab
2. Click "Sort Now"
3. LOOT will auto-sort
4. Deploy changes

### Mod Staging

**Vortex Settings:**
```
Mod Staging Folder: ~/Games/VortexMods/starfield/
Deployment: Hardlink
```

---

## 🌟 Essential Mods

### Performance (Critical for RX 580!)

**[Starfield Performance Optimizations](https://www.nexusmods.com/starfield/mods/2199)**
- Comprehensive performance tweaks
- +10-20 FPS boost

**[Low Spec PCs - Performance Boost](https://www.nexusmods.com/starfield/mods/123)**
- Specifically for mid-range hardware
- Great for RX 580

**[Smooth Ship Reticle](https://www.nexusmods.com/starfield/mods/629)**
- Fixes ship targeting FPS issues

**[Remove Planetary Haze](https://www.nexusmods.com/starfield/mods/499)**
- Improves planet FPS
- +5-10 FPS in cities

**[Better Shadows](https://www.nexusmods.com/starfield/mods/556)**
- Optimized shadow quality
- Better FPS with similar visuals

### UI & Quality of Life

**[StarUI Bundle](https://www.nexusmods.com/starfield/mods/3444)**
- Complete UI overhaul
- Inventory, workbench, HUD
- Requires: SFSE

**[BetterHUD](https://www.nexusmods.com/starfield/mods/1046)**
- Customizable HUD
- Requires: SFSE

**[Undelayed Menus](https://www.nexusmods.com/starfield/mods/404)**
- Removes menu delays
- Requires: SFSE

**[Neutral LUTs](https://www.nexusmods.com/starfield/mods/323)**
- Better colors, no filter

**[CLEAN - Full Screen Effects](https://www.nexusmods.com/starfield/mods/3274)**
- Removes visual clutter

### Gameplay

**[DarkStar - Astrodynamics Overhaul](https://www.nexusmods.com/starfield/mods/4465)**
- Realistic space flight

**[Ship Builder Unlock](https://www.nexusmods.com/starfield/mods/455)**
- More ship parts

**[Better Boost Pack Overhaul](https://www.nexusmods.com/starfield/mods/1283)**
- Improved boost packs

**[Slower Leveling](https://www.nexusmods.com/starfield/mods/2013)**
- Better progression balance

**[Enhanced Player Health](https://www.nexusmods.com/starfield/mods/5683)**
- Difficulty balancing

### Visual Enhancements (RX 580 Friendly)

**[Starfield HD Reworked Project](https://www.nexusmods.com/starfield/mods/1544)**
- HD textures
- Use "Performance" version!

**[Enhanced Lighting and Colors](https://www.nexusmods.com/starfield/mods/2189)**
- Better lighting
- Minimal FPS impact

**[Vibrant Neon Signs](https://www.nexusmods.com/starfield/mods/4478)**
- Better city atmosphere

**[Real Stars](https://www.nexusmods.com/starfield/mods/5987)**
- Astronomically accurate stars

### Fixes

**[Starfield Community Patch](https://www.nexusmods.com/starfield/mods/1) (when available)**
- Bug fixes
- Similar to USSEP

**[FOV Slider](https://www.nexusmods.com/starfield/mods/3)**
- Adjustable FOV
- Requires: SFSE

**[No Sudden Moves](https://www.nexusmods.com/starfield/mods/164)**
- Fixes jerky animations

---

## 🚀 Performance Optimization for RX 580

### In-Game Settings

**Graphics Preset:** Medium to High

**Critical Settings for RX 580:**
- Resolution: 1920x1080
- VSync: OFF
- FSR 2: Quality or Balanced
- Motion Blur: OFF
- Depth of Field: OFF
- Film Grain: OFF
- Volumetric Lighting: Low or OFF
- Contact Shadows: OFF
- Reflections: Medium
- Shadow Quality: Medium
- Particle Quality: Medium

### AMD-Specific Launch Options

**Best Performance:**
```bash
RADV_PERFTEST=aco,sam,nggc DXVK_ASYNC=1 PROTON_NO_ESYNC=1 PROTON_ENABLE_NVAPI=1 gamemoderun bash -c 'cd "$STEAM_COMPAT_INSTALL_PATH" && exec "$STEAM_COMPAT_TOOL_PATHS"/proton run ./sfse_loader.exe'
```

### Expected Performance

**RX 580 (8GB) @ 1080p:**

**Without Mods:**
- Medium Preset: 35-50 FPS
- Low Preset: 45-60 FPS

**With Performance Mods:**
- Medium + Optimizations: 45-60 FPS
- Low + Optimizations: 55-65 FPS

**Problem Areas:**
- New Atlantis: -10 to -15 FPS (very demanding)
- Space: 60+ FPS (easiest)
- Planets: 40-55 FPS (varies)

### FSR 2 Settings

**Recommended for RX 580:**
- Quality: Best visuals, 40-50 FPS
- Balanced: Good balance, 45-55 FPS
- Performance: More FPS, 50-60 FPS
- Ultra Performance: Maximum FPS, 55-65 FPS

**For 60 FPS target:** Use FSR 2 Performance or Ultra Performance

---

## 🐛 Common Issues & Fixes

### Game Crashes on Startup

**Solution 1: Disable INI Tweaks**
```bash
# Rename StarfieldCustom.ini temporarily
mv ~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My\ Games/Starfield/StarfieldCustom.ini ~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My\ Games/Starfield/StarfieldCustom.ini.bak
```

**Solution 2: Verify SFSE**
```bash
ls ~/.local/share/Steam/steamapps/common/Starfield/ | grep sfse
```

**Solution 3: Check Plugin Limit**
- Starfield has a ~256 plugin limit
- Use ESL-flagged plugins when possible

### Low FPS in Cities (New Atlantis)

**This is expected - New Atlantis is very demanding!**

**Solutions:**
1. Install **Remove Planetary Haze**
2. Lower Volumetric Lighting to Low or OFF
3. Disable Contact Shadows
4. Use FSR 2 Performance mode
5. Lower crowd density in settings

**Extreme solution:**
```ini
# Add to StarfieldCustom.ini
[Actor]
fVisibleNavmeshMoveDist=4096.0000
iMaxCharacterCount=10
```

### Stuttering During Gameplay

**Shader compilation stuttering:**
```bash
# Enable DXVK async (already in launch options)
DXVK_ASYNC=1
```

**Memory issues:**
```bash
# Increase virtual memory
echo "vm.max_map_count=1048576" | sudo tee -a /etc/sysctl.conf
sudo sysctl -w vm.max_map_count=1048576
```

### Mods Not Loading

**Check plugins.txt:**
```bash
cat ~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/AppData/Local/Starfield/plugins.txt
```

Should contain:
```
*PluginName1.esm
*PluginName2.esp
```

**Note:** Asterisk (*) means enabled!

### SFSE Mods Not Working

**Verify SFSE loaded:**
1. Launch game
2. Check for SFSE message in console
3. Or check log:
   ```bash
   cat ~/.local/share/Steam/steamapps/common/Starfield/sfse.log
   ```

---

## 📋 Mod Installation Checklist

**Before installing mods:**

- [ ] SFSE installed and verified
- [ ] Plugins.txt Enabler installed
- [ ] StarfieldCustom.ini created
- [ ] Performance mods installed
- [ ] FSR 2 configured
- [ ] Save game backup created
- [ ] Plugin limit checked (<256)

---

## 🔄 Load Order Template

**Starfield Plugin Order (top to bottom):**

1. **Starfield.esm** (base game)
2. **Constellation.esm** (DLC if owned)
3. **OldMars.esm** (DLC if owned)
4. **Framework mods** (if any)
5. **Large overhauls**
6. **Gameplay changes**
7. **Weapons & Ships**
8. **Visual mods**
9. **UI mods**
10. **Patches** (always load last!)

**Let LOOT sort automatically!**

---

## 💾 Recommended Mod Loadout for RX 580

**60 FPS Target Modlist:**

**Performance (Must-Have):**
- Starfield Performance Optimizations
- Low Spec PCs - Performance Boost
- Remove Planetary Haze
- Better Shadows

**UI:**
- StarUI Bundle
- BetterHUD
- Undelayed Menus

**Visual (Lite):**
- Neutral LUTs
- CLEAN - Full Screen Effects
- Real Stars

**Gameplay:**
- FOV Slider
- Ship Builder Unlock
- Better Boost Pack

**Total Plugin Count:** ~15-20 plugins  
**FPS Impact:** +10 to +15 FPS improvement

---

## 🎮 Starfield-Specific Tips

### Ship Building

- **Performance impact:** High
- **FPS drop:** 5-10 FPS in ship builder
- **Tip:** Close unnecessary menus

### Outpost Building

- **Performance impact:** Medium
- **FPS drop:** 3-5 FPS
- **Tip:** Limit decorations

### Space Combat

- **Performance:** Generally good
- **FPS:** 50-60 FPS
- **Tip:** Disable motion blur for clarity

### Planet Exploration

- **Performance:** Varies by planet
- **Barren planets:** 60 FPS
- **Lush planets:** 45-55 FPS
- **Cities:** 35-50 FPS

---

## 🆘 Emergency Mod Removal

**If game is broken:**

1. **Disable all mods in Vortex**
2. **Purge mods**
3. **Delete configuration:**
   ```bash
   rm -rf ~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My\ Games/Starfield/*.ini
   ```
4. **Verify game files in Steam**
5. **Reinstall SFSE**
6. **Start fresh with fewer mods**

---

## 📚 Resources

- **Nexus Mods:** [nexusmods.com/starfield](https://www.nexusmods.com/starfield)
- **SFSE:** [sfse.silverlock.org](https://sfse.silverlock.org)
- **r/Starfield:** [reddit.com/r/Starfield](https://www.reddit.com/r/Starfield)
- **r/StarfieldMods:** [reddit.com/r/StarfieldMods](https://www.reddit.com/r/StarfieldMods)
- **ProtonDB:** [protondb.com/app/1716740](https://www.protondb.com/app/1716740)

---

## 💡 Future Modding

**Starfield modding is still young!**

- Official mod support (Creation Kit) coming
- SFSE under active development
- More performance mods incoming
- Community patches in development

**Check for updates frequently!**

---

**See you in the stars, Constellation! 🚀**

*Part of WehttamSnaps Dotfiles*  
*https://github.com/Crowdrocker/wehttamsnaps-dotfiles*