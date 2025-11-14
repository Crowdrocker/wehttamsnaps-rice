# WehttamSnaps - Complete Niri + Noctalia Setup

I'll help you create a professional, modular dotfiles repository for your Niri setup! Let me break this down into organized sections and provide the complete configs you need.

## Repository Structure

First, let me create a comprehensive repository layout that combines everything you want:Now let me create your core configuration files:

## 1. Main Niri Configuration## 2. Niri Keybinds Configuration## 3. Window Rules ConfigurationNow let me create the essential scripts and configurations. Let me continue with:

## 4. Updated Welcome ScreenLet me continue with more essential files. Would you like me to create:

1. **Updated KeyHints script** (adapted for Noctalia + Ghostty + Webapps)
2. **Ghostty terminal configuration**
3. **Gaming optimization scripts** (including Proton fixes for Division 2 & Cyberpunk)
4. **Webapp launcher scripts**
5. **Audio routing configuration** (PipeWire setup for streaming)
6. **Widget template generator**
7. **Photography workspace script**
8. **Plymouth boot theme** with spinning logo animation
9. **Package lists** (cleaned and categorized)
10. **Main installer script**

Which would you like me to prioritize? I can create all of them, but let me know which are most important to you right now, and I'll generate those first!

Also, regarding your **logo for Plymouth** - yes, we can definitely make it spin! I can create a Plymouth theme that:
- Uses your logo image as the centerpiece
- Animates the camera aperture blades spinning
- Shows a progress bar or boot status
- Matches your WehttamSnaps branding colors

Should I proceed with creating these files?


##################################################################

Perfect! Let me create all the essential files for your WehttamSnaps setup.

## 5. Updated KeyHints Script## 6. Ghostty Terminal Configuration## 7. Gaming Optimization Scripts## 8. Gaming Performance Optimizer## 9. Webapp Launcher Script## 10. Webapp Creator Script## 11. Plymouth Boot Theme with Spinning Logo## 12. Audio Routing ConfigurationLet me continue with the remaining essential files. I'll create the package lists, photography workspace script, widget template creator, and the main installer.

## 13. Cleaned Package Lists## 14. Photography Workspace Script## 15. Widget Template Generator## 16. Main Installer ScriptPerfect! Now let me create one final essential file - the ASCII logo for branding:

## 17. Logo and Branding## 📦 Complete Summary

I've created a **comprehensive, professional dotfiles repository** for your WehttamSnaps setup! Here's what you now have:

### 🗂️ **Core Configuration Files:**
1. **Niri Config** - Main compositor config with modular structure
2. **Keybinds** - Complete keybind layout for Noctalia + webapps
3. **Window Rules** - Optimized rules for photography/gaming apps
4. **Ghostty Terminal** - GPU-accelerated terminal with Fira Code

### 🎮 **Gaming Optimizations:**
5. **Toggle Gamemode** - Performance mode switcher
6. **Gaming Optimizer** - AMD RX 580 optimizations + Proton fixes for Division 2 & Cyberpunk
7. **Steam Launch Options** - Pre-configured templates

### 🌐 **Webapp Integration:**
8. **Webapp Launcher** - Launch YouTube, Twitch, Spotify, Discord as dedicated windows
9. **Webapp Creator** - Interactive script to add custom webapps

### 🎨 **Theming & UI:**
10. **Welcome Screen** - Branded first-boot experience with J.A.R.V.I.S. sound
11. **KeyHints** - Updated cheat sheet for all keybinds
12. **Plymouth Theme** - Spinning logo boot animation

### 📷 **Photography Workflow:**
13. **Photography Workspace** - Auto-layout for photo editing with color management
14. **Restore Script** - Return to normal desktop settings

### 🎵 **Audio Setup:**
15. **Audio Routing** - PipeWire virtual sinks for streaming (Voicemeeter-like)
16. **OBS Integration** - Pre-configured audio sources

### 🛠️ **Development Tools:**
17. **Widget Creator** - Interactive Noctalia widget scaffold generator
18. **Package Lists** - Cleaned, categorized (core/photography/gaming/optional)
19. **Main Installer** - Interactive installation with backup

### 📄 **Branding:**
20. **Logo.txt** - ASCII art branding for all configs

---

## 🚀 **Next Steps:**

### **1. Set Up Your Repository:**
```bash
cd ~
git clone https://github.com/Crowdrocker/wehttamsnaps-dotfiles.git
cd wehttamsnaps-dotfiles

# Create the directory structure
mkdir -p configs/{niri/conf.d,ghostty,hyprlock,swaync,rofi}
mkdir -p scripts/{install,widgets,audio,gaming,webapps,utils,startup,photography}
mkdir -p themes/wehttamsnaps/{gtk,kvantum,plymouth}
mkdir -p packages wallpapers sounds webapps docs
```

### **2. Add Your Logo Images:**
Place your logo files here:
- `themes/wehttamsnaps/plymouth/logo-center.png` (static center)
- `themes/wehttamsnaps/plymouth/logo-blades.png` (rotating aperture)
- `assets/logo.png` (for welcome screen)

### **3. Populate with Configs:**
Copy all the artifact files I created into the appropriate directories.

### **4. Customize:**
- Edit `configs/niri/conf.d/10-keybinds.kdl` - Adjust keybinds to your preference
- Edit `scripts/gaming/optimize-performance.sh` - Add game-specific fixes
- Add your wallpapers to `wallpapers/`
- Add J.A.R.V.I.S. sounds to `sounds/`

### **5. Test Installation:**
```bash
chmod +x install.sh
./install.sh --help
./install.sh --core  # Test core install first
```

---

## 🎯 **Special Features for Your Needs:**

### **Gaming Crash Fixes:**
- **Division 2**: `PROTON_USE_WINED3D=1 DXVK_ASYNC=1 gamemoderun %command%`
- **Cyberpunk 2077**: `gamemoderun PROTON_NO_ESYNC=1 DXVK_ASYNC=1 %command%`
- All optimizations included in `gaming/optimize-performance.sh`

### **Plymouth Spinning Logo:**
The Plymouth script I created will animate your camera aperture logo! Just provide:
- `logo-center.png` (192x192px) - The white center circle
- `logo-blades.png` (192x192px) - The aperture blades (transparent background)

The blades will rotate smoothly while the center stays fixed.

### **Webapp Keybinds:**
All set up in the keybinds file:
- `Mod+Shift+Y` → YouTube
- `Mod+Shift+T` → Twitch
- `Mod+Shift+S` → Spotify
- `Mod+Shift+D` → Discord

---

## 📚 **Documentation to Create:**

Create these markdown files in `docs/`:

1. **INSTALL.md** - Step-by-step installation guide
2. **QUICKSTART.md** - First boot tutorial
3. **KEYBINDS.md** - Complete keybind reference (export from KeyHints)
4. **GAMING.md** - Gaming setup, fixes, and optimizations
5. **PHOTOGRAPHY.md** - Photo workflow and color management
6. **TROUBLESHOOTING.md** - Common issues and solutions

---

Would you like me to create any of these documentation files, or would you like help with anything else for your setup?



##################################################################
# Vortex Mod Manager Setup for Linux

I'll help you set up Vortex Mod Manager on your Arch Linux system. Vortex is Nexus Mods' official mod manager, and while it's primarily designed for Windows, we can get it running on Linux through Wine/Proton.Now let me create a companion guide for using Vortex with your specific games:Perfect! I've created a complete Vortex setup for you. Here's what you now have:

## 🎯 **What I've Created:**

### 1. **Vortex Setup Script** (`vortex-setup.sh`)
   - Automated installation with Wine
   - Downloads latest Vortex from GitHub
   - Installs .NET Framework 4.8 and dependencies
   - Creates launcher and desktop entry
   - Includes uninstall function

### 2. **Complete Usage Guide**
   - First-time setup instructions
   - Game-specific configurations for:
     - Skyrim SE/AE
     - Fallout 4
     - Cyberpunk 2077
     - The Witcher 3
     - Baldur's Gate 3
   - Troubleshooting section
   - Performance optimization tips
   - Alternative (Mod Organizer 2) recommendations

---

## 🚀 **Quick Start:**

### **Save the script:**
```bash
# Save to your scripts directory
nano ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
# Paste the script content
chmod +x ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
```

### **Run installation:**
```bash
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
```

**Installation takes 30-45 minutes** (mostly waiting for .NET Framework)

---

## 🎮 **Key Features:**

### **Automated Setup:**
- ✅ Downloads Vortex automatically
- ✅ Creates isolated Wine prefix
- ✅ Installs all dependencies (.NET 4.8, vcrun2019, dxvk)
- ✅ Configures for AMD RX 580
- ✅ Creates terminal and desktop launchers

### **After Installation:**
```bash
# Launch from terminal
vortex

# Or use app launcher (search "Vortex")
# Or add keybind: Mod+Shift+V
```

---

## 🔧 **Important Notes:**

### **For Your Games:**

**Cyberpunk 2077** (your mentioned crashes):
```bash
# Steam launch options:
gamemoderun PROTON_NO_ESYNC=1 DXVK_ASYNC=1 %command%
```

**Division 2** (your mentioned crashes):
```bash
# Steam launch options:
PROTON_USE_WINED3D=1 DXVK_ASYNC=1 gamemoderun %command%
```

### **Skyrim/Fallout Mods:**
1. Install SKSE/F4SE first (script extender)
2. Always launch via script extender, not base game
3. Use LOOT for load order (built into Vortex)

### **Performance on RX 580:**
The script automatically enables:
- RADV_PERFTEST=aco (optimized AMD compiler)
- DXVK_ASYNC=1 (async shader compilation)
- Proper Wine configuration

---

## 💡 **Alternative: Mod Organizer 2**

If Vortex feels too slow in Wine, consider **Mod Organizer 2**:
- Better Linux performance
- Virtual file system (no deployment needed)
- Can be installed via ProtonUp-Qt
- Works directly with Proton

To try MO2:
```bash
paru -S protonup-qt
# Then launch ProtonUp-Qt and install MO2 for your game
```

---

## 📋 **Add to Your Repo:**

1. **Save the setup script:**
   ```
   scripts/gaming/vortex-setup.sh
   ```

2. **Save the guide:**
   ```
   docs/VORTEX.md
   ```

3. **Update your main README to mention:**
   - Mod manager support
   - Vortex installation guide
   - Link to VORTEX.md

4. **Add keybind to Niri:**
   In `configs/niri/conf.d/10-keybinds.kdl`:
   ```kdl
   // Vortex Mod Manager
   Mod+Shift+V { spawn "vortex"; }
   ```

---

## 🎯 **What Games Do You Play?**

I've included guides for common modded games, but if you play others, let me know and I can add specific configurations for:
- Starfield
- Fallout: New Vegas
- Oblivion
- Morrowind
- Stardew Valley
- Etc.

Would you like me to add specific configurations for any games you're currently playing?
##################################################################
Perfect! Let me create enhanced guides specifically for your three main modding games: Cyberpunk 2077, Fallout 4, and Starfield. I'll make sure the Cyberpunk guide addresses the CET/REDx/TweakXL issues you've had with MO2.Now let me create comprehensive guides for Fallout 4 and Starfield:Now let me create the Starfield guide:Perfect! Now let me create one final quick-reference card for all three games:Perfect! I've created a complete modding suite for you! Here's what you now have:

## 📚 **Complete Modding Guide Collection:**

### 1. **Vortex Setup Script** (`vortex-setup.sh`)
   - Automated installation with Wine
   - One-command setup for Vortex Mod Manager
   - Includes uninstall function

### 2. **Game-Specific Guides:**

   **🤖 Cyberpunk 2077** (Your main concern with CET/REDx/TweakXL)
   - Complete framework setup in correct order
   - Linux-specific CET troubleshooting
   - RED4ext configuration for Proton
   - RX 580 performance optimization
   - Why Vortex works better than MO2 for CP2077

   **☢️ Fallout 4**
   - F4SE installation and Steam integration
   - Complete framework setup (UFO4P, Buffout 4, etc.)
   - Boston FPS Fix (critical for your RX 580)
   - Load order management with LOOT
   - Configuration file tweaks

   **🚀 Starfield** (Perfect for your upgraded system!)
   - SFSE installation guide
   - Performance optimization for RX 580
   - New Atlantis FPS tips (the most demanding area)
   - FSR 2 configuration
   - Early modding scene advice

### 3. **Quick Reference Card**
   - All launch commands in one place
   - Troubleshooting commands
   - Backup script
   - Emergency recovery procedures
   - Performance targets for RX 580

---

## 💡 **Key Points for Your Setup:**

### **Why Vortex Works Better for Cyberpunk:**
The guides address your specific issue - **CET, REDx, and TweakXL work much better with Vortex** because:
1. Vortex deploys files directly (no VFS issues)
2. Better DLL override handling in Wine
3. Simpler file structure for Proton
4. No VFS conflicts with RED4ext plugins

### **RX 580 Optimizations Included:**
Every guide has specific tweaks for your GPU:
- AMD-specific launch options
- FSR/performance settings
- Expected FPS targets
- Problem area solutions (Boston, New Atlantis)

### **Your i7-4790 Configuration:**
- 8-thread CPU topology set correctly
- Proper CPU governor settings
- Memory optimization scripts

---

## 🚀 **Installation Instructions:**

### **1. Save All Files:**
```bash
# Main Vortex setup
~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh

# Game guides
~/Documents/WehttamSnaps_Modding/
├── Cyberpunk2077-Guide.md
├── Fallout4-Guide.md
├── Starfield-Guide.md
└── Quick-Reference.md

# Or add to your dotfiles repo
~/wehttamsnaps-dotfiles/docs/gaming/
```

### **2. Run Vortex Setup:**
```bash
chmod +x ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
```

### **3. Add Keybind (Optional):**
Edit `~/.config/niri/conf.d/10-keybinds.kdl`:
```kdl
// Vortex Mod Manager
Mod+Shift+V { spawn "vortex"; }
```

---

## 🎮 **Priority Order for Getting Started:**

### **Start with Cyberpunk** (since you mentioned issues):
1. Install Vortex
2. Follow Cyberpunk guide **exactly in order**
3. Install frameworks: CET → RED4ext → ArchiveXL → TweakXL
4. Test with a few simple mods
5. Once working, add more mods

### **Then Fallout 4:**
1. Install F4SE (critical!)
2. Install Boston FPS Fix immediately
3. Add framework mods
4. Build modlist slowly

### **Finally Starfield** (once comfortable):
1. SFSE installation
2. Performance mods first (New Atlantis can kill FPS)
3. Fewer mods (modding scene is young)

---

## 📋 **What to Add to Your Repo:**

```
docs/
├── GAMING.md (update with modding section)
├── VORTEX.md (main Vortex guide)
└── gaming/
    ├── Cyberpunk2077-Modding.md
    ├── Fallout4-Modding.md
    ├── Starfield-Modding.md
    └── Modding-Quick-Reference.md

scripts/gaming/
├── vortex-setup.sh
├── backup-saves.sh (from quick reference)
└── reset-game.sh (emergency recovery)
```

---

## 🔥 **Most Important Tips:**

1. **Always backup saves before modding**
2. **Install frameworks FIRST** (CET, F4SE, SFSE)
3. **Start with performance mods** on RX 580
4. **Add mods one at a time** to catch issues
5. **Read mod requirements carefully**
6. **Keep Vortex and frameworks updated**

---

Would you like me to:
1. Create the backup and emergency recovery scripts as separate files?
2. Make a visual flowchart for mod installation order?
3. Create game-specific performance profiles you can quickly switch between?
4. Add any other games you play to this collection?

Your complete modding setup is ready! 🎮🚀
##################################################################
Perfect! Let me create those scripts and flowcharts for you.

## 1. Backup Script## 2. Emergency Recovery Script## 3. Visual Mod Installation FlowchartsPerfect! Now let me create one final installation guide that ties everything together:Perfect! 🎉 I've created everything you asked for. Here's the complete summary:

---

## ✅ **Complete Modding Suite Created!**

### **📜 Scripts Created:**

1. **`backup-saves`** - Comprehensive backup system
   - Backup all games or individual games
   - List available backups
   - Restore from any backup
   - Auto-backup for cron
   - Clean old backups

2. **`recovery-game`** - Three-level emergency recovery
   - **Level 1 (Soft):** Config reset, disable mods
   - **Level 2 (Medium):** Proton prefix reset, verify files
   - **Level 3 (Nuclear):** Complete system reset

3. **Visual Flowcharts** - Installation order diagrams
   - Cyberpunk 2077 step-by-step
   - Fallout 4 step-by-step
   - Starfield step-by-step
   - Decision tree for mod installation
   - Emergency recovery flowchart
   - Mod priority matrix

4. **Complete Setup Guide** - Ties everything together
   - Installation walkthrough
   - Daily workflow
   - Troubleshooting
   - Learning path
   - Quick reference

---

## 📂 **File Organization:**

### **Save scripts to:**
```
~/.config/wehttamsnaps/scripts/gaming/
├── vortex-setup.sh
├── backup-saves
└── recovery-game

# Symlink for easy access:
~/.local/bin/
├── backup-saves -> ~/.config/wehttamsnaps/scripts/gaming/backup-saves
└── recovery-game -> ~/.config/wehttamsnaps/scripts/gaming/recovery-game
```

### **Save documentation to:**
```
~/Documents/WehttamSnaps_Modding/
├── Cyberpunk2077-Guide.md
├── Fallout4-Guide.md
├── Starfield-Guide.md
├── Modding-Flowcharts.md
├── Quick-Reference.md
└── Complete-Setup-Guide.md
```

### **Add to your dotfiles repo:**
```
wehttamsnaps-dotfiles/
├── scripts/gaming/
│   ├── vortex-setup.sh
│   ├── backup-saves
│   └── recovery-game
└── docs/gaming/
    ├── Cyberpunk2077-Modding.md
    ├── Fallout4-Modding.md
    ├── Starfield-Modding.md
    ├── Modding-Flowcharts.md
    ├── Quick-Reference.md
    └── Complete-Setup-Guide.md
```

---

## 🚀 **Quick Start Commands:**

### **Installation:**
```bash
# Install Vortex
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh

# Make scripts executable
chmod +x ~/.config/wehttamsnaps/scripts/gaming/*.sh

# Create symlinks
ln -s ~/.config/wehttamsnaps/scripts/gaming/backup-saves ~/.local/bin/backup-saves
ln -s ~/.config/wehttamsnaps/scripts/gaming/recovery-game ~/.local/bin/recovery-game
```

### **Daily Usage:**
```bash
# Before modding
backup-saves --game cyberpunk

# If something breaks
recovery-game cyberpunk 1     # Try soft recovery first
recovery-game cyberpunk 2     # Then medium if needed
recovery-game cyberpunk 3     # Nuclear option last

# List backups
backup-saves --list

# Restore
backup-saves --restore 20250109-143022
```

---

## 🎯 **Key Features:**

### **Backup System:**
- ✅ Backs up all 3 games at once
- ✅ Individual game backups
- ✅ Timestamped backups
- ✅ Easy restore
- ✅ Automatic cleanup (keeps last 10)
- ✅ Cron job support

### **Recovery System:**
- ✅ Three escalating levels
- ✅ Saves backups automatically before recovery
- ✅ Clear prompts and warnings
- ✅ Handles all 3 games
- ✅ Detailed instructions after each level

### **Flowcharts:**
- ✅ Visual installation order
- ✅ Decision trees
- ✅ Troubleshooting flows
- ✅ Priority matrices
- ✅ Emergency procedures

---

## 💡 **Pro Tips:**

1. **Create first backup NOW:**
   ```bash
   backup-saves
   ```

2. **Test recovery on a working game:**
   ```bash
   # This helps you understand the process
   recovery-game cyberpunk 1
   # Then restore from backup
   backup-saves --restore [latest-backup]
   ```

3. **Set up automatic backups:**
   ```bash
   crontab -e
   # Add: 0 2 * * * /home/YOUR_USERNAME/.local/bin/backup-saves --auto
   ```

4. **Keep flowchart handy:**
   Print or bookmark `Modding-Flowcharts.md` for quick reference while modding

---

## 📚 **What Each Document Contains:**

1. **Complete Setup Guide** - Start here! Full walkthrough
2. **Cyberpunk Guide** - CET/REDx/TweakXL setup (your main concern)
3. **Fallout 4 Guide** - F4SE + Boston FPS Fix
4. **Starfield Guide** - Performance for RX 580
5. **Flowcharts** - Visual installation orders
6. **Quick Reference** - All commands, one place

---

## 🎮 **Next Steps:**

1. **Save all the scripts and docs**
2. **Install Vortex** (`vortex-setup.sh`)
3. **Create first backup** (`backup-saves`)
4. **Start with Cyberpunk** (follow flowchart)
5. **Test backup/recovery** (learn the system)
6. **Add mods slowly** (one at a time!)

---

Everything is ready for you! Would you like me to create any additional scripts or documentation? For example:
- Auto-update script for Vortex?
- Mod collection manager?
- Performance profile switcher?
- Steam launch options manager?

Your complete modding setup is done! 🎉🎮




##################################################################

Absolutely! Let me create all of those for you, including Niri window rules for SteamTinkerLaunch and Vortex.

## 1. Auto-Update Script for Vortex## 2. Mod Collection Manager## 3. Performance Profile SwitcherNow let me continue with the Steam Launch Options Manager and Niri Window Rules:

## 4. Steam Launch Options Manager## 5. Niri Window Rules for Vortex and SteamTinkerLaunchPerfect! Now let me create a complete installation guide for all these new tools:Perfect! 🎉 I've created everything you asked for! Here's the complete summary:

---

## ✅ **All New Gaming Tools Created!**

### **📜 New Scripts:**

1. **`vortex-update`** - Vortex Auto-Updater
   - Checks GitHub for updates
   - Auto-installs new versions
   - Backs up data before updating
   - Can run via cron

2. **`mod-collections`** - Mod Collection Manager
   - Save/restore mod setups
   - Compare collections
   - Create presets (vanilla, performance)
   - Track mod lists

3. **`perf-profile`** - Performance Profile Switcher
   - Switch between performance modes
   - Game-specific optimizations
   - Auto-detect running game
   - Custom profiles

4. **`steam-launch`** - Steam Launch Options Manager
   - Presets for all 3 games
   - Copy to clipboard
   - Interactive builder
   - Explain what options do

5. **`40-gaming.kdl`** - Niri Window Rules
   - Vortex: Floating, proper size
   - SteamTinkerLaunch: Floating, 1024x768
   - Mod Organizer 2: Floating, centered
   - Games: Fullscreen, workspace 3
   - Wine system tray: Suppressed

---

## 📂 **File Organization:**

```
~/.config/wehttamsnaps/scripts/gaming/
├── vortex-setup.sh         # Existing installer
├── vortex-update           # NEW: Auto-updater
├── mod-collections         # NEW: Collection manager
├── perf-profile           # NEW: Performance switcher
├── steam-launch           # NEW: Launch options manager
├── backup-saves           # Existing backup script
└── recovery-game          # Existing recovery script

~/.config/niri/conf.d/
├── 00-base.kdl
├── 10-keybinds.kdl
├── 20-rules.kdl
├── 30-work.kdl
├── 40-gaming.kdl          # NEW: Gaming window rules
└── 99-overrides.kdl

~/.local/bin/ (symlinks)
├── vortex
├── vortex-update          # NEW
├── mod-collections        # NEW
├── perf-profile          # NEW
├── steam-launch          # NEW
├── backup-saves
└── recovery-game
```

---

## 🚀 **Quick Start:**

### **Installation:**
```bash
# 1. Save all scripts to ~/.config/wehttamsnaps/scripts/gaming/
# 2. Make executable
chmod +x ~/.config/wehttamsnaps/scripts/gaming/*

# 3. Create symlinks
ln -s ~/.config/wehttamsnaps/scripts/gaming/vortex-update ~/.local/bin/vortex-update
ln -s ~/.config/wehttamsnaps/scripts/gaming/mod-collections ~/.local/bin/mod-collections
ln -s ~/.config/wehttamsnaps/scripts/gaming/perf-profile ~/.local/bin/perf-profile
ln -s ~/.config/wehttamsnaps/scripts/gaming/steam-launch ~/.local/bin/steam-launch

# 4. Install Niri rules
cp 40-gaming.kdl ~/.config/niri/conf.d/
niri msg action reload-config

# 5. Install dependencies
sudo pacman -S wl-clipboard jq
```

---

## 🎯 **Real-World Usage Examples:**

### **Daily Gaming Workflow:**
```bash
# Before gaming
backup-saves
perf-profile cyberpunk
# Launch game via Steam

# After gaming
perf-profile balanced
```

### **Trying New Mods:**
```bash
# Save current setup
mod-collections export cyberpunk stable

# Add mods in Vortex
# Test...

# If good, save new collection
mod-collections export cyberpunk experimental

# If bad, restore backup
backup-saves --restore [timestamp]
```

### **Setting Up New Game:**
```bash
# 1. Get launch options
steam-launch copy fallout4 f4se

# 2. Paste into Steam
# Properties → Launch Options

# 3. Create performance preset
mod-collections preset fallout4 performance

# 4. Apply profile before launching
perf-profile fallout4
```

---

## 🔑 **Suggested Keybinds:**

Add to `~/.config/niri/conf.d/10-keybinds.kdl`:

```kdl
// Gaming tools
Mod+Shift+V { spawn "vortex"; }

// Performance profiles
Mod+Shift+P { spawn "perf-profile" "performance"; }
Mod+Alt+P { spawn "perf-profile" "balanced"; }

// Game-specific
Mod+Shift+G+C { spawn "perf-profile" "cyberpunk"; }
Mod+Shift+G+F { spawn "perf-profile" "fallout4"; }
Mod+Shift+G+S { spawn "perf-profile" "starfield"; }

// Quick backup
Mod+Shift+B { spawn "ghostty" "-e" "backup-saves"; }
```

---

## 💡 **Pro Tips:**

### **1. Auto-Update Vortex (Cron):**
```bash
crontab -e
# Add: 0 10 * * * /home/YOUR_USERNAME/.local/bin/vortex-update --auto
```

### **2. Export Collections Before Updates:**
```bash
# Before game updates
mod-collections export cyberpunk pre-update-$(date +%Y%m%d)
```

### **3. Performance Profile on Game Launch:**
```bash
# Create wrapper script
cat > ~/.local/bin/launch-cyberpunk << 'EOF'
#!/bin/bash
perf-profile cyberpunk
steam steam://rungameid/1091500
perf-profile balanced
EOF
chmod +x ~/.local/bin/launch-cyberpunk
```

---

## 📊 **Feature Matrix:**

| Tool | Purpose | Automation | Integration |
|------|---------|-----------|-------------|
| vortex-update | Keep Vortex current | Cron support | Notifications |
| mod-collections | Track mod setups | Manual | Vortex |
| perf-profile | Optimize performance | Can auto-detect | System-wide |
| steam-launch | Manage launch options | Manual | Steam |
| Niri rules | Window management | Automatic | Niri |

---

## 🎮 **Complete Gaming Stack:**

**Before this update:**
- Vortex installer ✅
- Backup system ✅
- Emergency recovery ✅
- Game guides ✅

**After this update:**
- Vortex auto-update ✅
- Mod collections ✅
- Performance profiles ✅
- Launch options manager ✅
- Niri window rules ✅

**Total: 10 comprehensive gaming management tools!**

---

## 📝 **Next Steps:**

1. **Install all scripts** (see Quick Start above)
2. **Test each tool** individually
3. **Set up cron** for auto-update
4. **Add keybinds** to Niri
5. **Create first collection** for each game
6. **Configure Steam launch options**

---

Everything is ready! Your complete gaming management suite is now finished. You have:

- ✅ Automated Vortex updates
- ✅ Mod collection tracking
- ✅ Performance optimization
- ✅ Launch options management
- ✅ Proper window rules for all gaming tools

Would you like me to create anything else, such as:
- A unified "gaming control panel" script that combines everything?
- Automated testing scripts?
- Desktop notifications for updates?
- A GUI interface using Zenity or YAD?

Your WehttamSnaps dotfiles are incredibly comprehensive now! 🎉🎮





##################################################################







##################################################################






##################################################################














