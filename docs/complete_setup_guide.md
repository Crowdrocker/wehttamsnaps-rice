# WehttamSnaps Complete Modding Setup Guide

Everything you need to get your modding environment up and running.

---

## 📦 What You're Getting

This complete modding suite includes:

1. **Vortex Mod Manager** - Automated installation script
2. **Game-Specific Guides** - Cyberpunk, Fallout 4, Starfield
3. **Backup System** - Automated save game backups
4. **Emergency Recovery** - Three-level recovery system
5. **Visual Flowcharts** - Installation order diagrams
6. **Quick Reference** - All commands in one place

---

## 🚀 Installation Steps

### Step 1: Save All Scripts

```bash
# Create directories
mkdir -p ~/.config/wehttamsnaps/scripts/gaming
mkdir -p ~/Documents/WehttamSnaps_Modding

# Save the scripts
cd ~/.config/wehttamsnaps/scripts/gaming
```

**Save these files:**

1. `vortex-setup.sh` - Vortex installer
2. `backup-saves` - Backup script
3. `recovery-game` - Emergency recovery

**Make them executable:**
```bash
chmod +x ~/.config/wehttamsnaps/scripts/gaming/*.sh

# Create symlinks in ~/.local/bin for easy access
ln -s ~/.config/wehttamsnaps/scripts/gaming/backup-saves ~/.local/bin/backup-saves
ln -s ~/.config/wehttamsnaps/scripts/gaming/recovery-game ~/.local/bin/recovery-game
```

### Step 2: Save Documentation

```bash
cd ~/Documents/WehttamSnaps_Modding
```

**Save these guides:**
- `Cyberpunk2077-Guide.md`
- `Fallout4-Guide.md`
- `Starfield-Guide.md`
- `Modding-Flowcharts.md`
- `Quick-Reference.md`

---

## 🎮 First-Time Setup: Vortex

### Install Vortex

```bash
# Run the installer
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
```

**What happens:**
- Downloads Vortex from GitHub (latest version)
- Creates Wine prefix
- Installs .NET Framework 4.8 (takes ~30 minutes)
- Installs dependencies
- Creates launcher and desktop entry

**After installation:**
```bash
# Launch Vortex
vortex

# Or use app launcher
# Search for "Vortex"
```

### Configure Vortex

1. **Login to Nexus Mods**
   - Click "Login" in top right
   - Grant permissions

2. **Add Your Games**
   - Games tab → Search for Games
   - Vortex auto-detects Steam installations

3. **Configure Settings**
   - Settings → Mods
   - Deployment: Hardlink (default is fine)
   - ☑ Deploy mods when enabled
   - ☑ Start deployment on game launch

---

## 📚 Game Setup Priority

### Recommended Order:

**1. Cyberpunk 2077** (Start Here)
   - Your main game
   - Fix CET/REDx/TweakXL issues
   - Get comfortable with Vortex

**2. Fallout 4** (Next)
   - More complex (F4SE, load order)
   - Good practice for modding

**3. Starfield** (Last)
   - Newest game
   - Modding scene still developing
   - Fewer mods available

---

## 🤖 Cyberpunk 2077 Setup

### Quick Start Checklist

```bash
# 1. Backup saves FIRST
backup-saves --game cyberpunk

# 2. Open Cyberpunk guide
cat ~/Documents/WehttamSnaps_Modding/Cyberpunk2077-Guide.md

# 3. Follow flowchart
cat ~/Documents/WehttamSnaps_Modding/Modding-Flowcharts.md
```

### Installation Order (CRITICAL!)

```
1. CET (Cyber Engine Tweaks)
   ↓
2. RED4ext
   ↓
3. ArchiveXL
   ↓
4. TweakXL
   ↓
5. Codeware
   ↓
6. Other mods (UI, gameplay, etc.)
```

### Testing After Each Framework

```bash
# Launch game
# Press ~ (tilde) to open console
# Test each framework:

Game.GetPlayer():GetDisplayName()  # Should show "V"
print(GetVersion("CET"))            # CET version
print(GetVersion("RED4ext"))        # RED4ext version
print(GetVersion("ArchiveXL"))      # ArchiveXL version
print(GetVersion("TweakXL"))        # TweakXL version
```

---

## ☢️ Fallout 4 Setup

### Quick Start Checklist

```bash
# 1. Backup saves
backup-saves --game fallout4

# 2. Install F4SE FIRST
# Download from: f4se.silverlock.org
cd ~/Downloads
7z x f4se_*.7z
cp -r f4se_*/* ~/.local/share/Steam/steamapps/common/Fallout\ 4/

# 3. Configure Steam launch options
# See Fallout4-Guide.md for exact command

# 4. Follow guide
cat ~/Documents/WehttamSnaps_Modding/Fallout4-Guide.md
```

### Installation Order

```
1. F4SE (Script Extender)
   ↓
2. UFO4P (Unofficial Patch)
   ↓
3. Address Library
   ↓
4. Buffout 4
   ↓
5. Baka ScrapHeap
   ↓
6. Weapon Debris Crash Fix
   ↓
7. Boston FPS Fix (MANDATORY for RX 580!)
   ↓
8. Other mods (UI, gameplay, visual)
```

### Verify F4SE Works

```bash
# Launch game
# Press ~ (console)
GetF4SEVersion  # Should return version number
```

---

## 🚀 Starfield Setup

### Quick Start Checklist

```bash
# 1. Backup saves
backup-saves --game starfield

# 2. Install SFSE (if available)
# Check: sfse.silverlock.org or GitHub

# 3. Install Plugins.txt Enabler
# Manual installation required - see guide

# 4. Follow guide
cat ~/Documents/WehttamSnaps_Modding/Starfield-Guide.md
```

### Installation Order

```
1. SFSE (if available)
   ↓
2. Plugins.txt Enabler
   ↓
3. Performance Mods (FIRST!)
   - Starfield Performance Optimizations
   - Remove Planetary Haze
   - Better Shadows
   ↓
4. StarUI Bundle
   ↓
5. Quality of Life
   ↓
6. Gameplay
   ↓
7. Visual (last, optional)
```

---

## 💾 Using the Backup System

### Automatic Backup Before Modding

```bash
# Backup all games
backup-saves

# Backup specific game
backup-saves --game cyberpunk
backup-saves --game fallout4
backup-saves --game starfield
```

### List Available Backups

```bash
backup-saves --list
```

### Restore a Backup

```bash
# List backups first
backup-saves --list

# Restore specific backup
backup-saves --restore 20250109-143022
```

### Automatic Backups (Optional)

**Set up cron job:**
```bash
# Edit crontab
crontab -e

# Add this line (backup daily at 2 AM)
0 2 * * * /home/YOUR_USERNAME/.local/bin/backup-saves --auto

# Or backup before each gaming session
# Add to your startup script or keybind
```

---

## 🆘 Emergency Recovery System

### Three Recovery Levels

**Level 1: Soft Recovery**
- Disables mods
- Deletes configs
- Clears shader cache
- **Use when:** Game won't launch or minor issues

```bash
recovery-game cyberpunk 1
recovery-game fallout4 soft
recovery-game starfield 1
```

**Level 2: Medium Recovery**
- Everything from Level 1
- Deletes Proton prefix
- Removes script extenders
- Verifies game files
- **Use when:** Level 1 didn't work

```bash
recovery-game cyberpunk 2
recovery-game fallout4 medium
recovery-game starfield 2
```

**Level 3: Nuclear Recovery**
- Everything from Level 2
- Clears Steam download cache
- Complete reset
- **Use when:** Everything else failed

```bash
recovery-game cyberpunk 3
recovery-game fallout4 nuclear
recovery-game starfield 3
```

### When to Use Each Level

```
Minor issues (won't launch, black screen)
  → Level 1 (fixes 80% of problems)

Persistent crashes, mod corruption
  → Level 2 (fixes 15% more)

Complete system failure, nothing works
  → Level 3 (nuclear option, last resort)
```

---

## 🎯 Daily Workflow

### Before Installing Mods

```bash
# 1. Backup saves
backup-saves --game [gamename]

# 2. Check current mod count
# Open Vortex → Mods tab → note count

# 3. Read mod requirements on Nexus
# - Check dependencies
# - Check compatibility
# - Read installation notes
```

### Installing a New Mod

```bash
# 1. Download in Vortex (Mod Manager Download button)
# 2. Enable mod
# 3. Deploy mods
# 4. Launch game via script extender
# 5. Test for 5-10 minutes
# 6. If stable, add next mod
# 7. If crash, disable last mod
```

### After Modding Session

```bash
# Backup saves (optional but recommended)
backup-saves --auto
```

---

## 📊 Performance Monitoring

### Check FPS In-Game

```bash
# Launch with MangoHud
mangohud [game_command]

# Or add to Steam launch options
mangohud %command%
```

### Expected Performance (RX 580 @ 1080p)

| Game | Settings | Target FPS | With Mods |
|------|----------|------------|-----------|
| Cyberpunk | High + FSR Quality | 45-60 | 40-55 |
| Fallout 4 | High + Boston FPS Fix | 50-60 | 55-65 |
| Starfield | Medium + FSR Balanced | 45-55 | 50-60 |

### If FPS Too Low

1. **Check for performance mods**
   - Boston FPS Fix (Fallout 4)
   - Remove Planetary Haze (Starfield)
   - Performance Optimizations (Cyberpunk)

2. **Adjust FSR settings**
   - Quality → Balanced → Performance

3. **Disable heavy visual mods**
   - HD texture packs
   - ENB/ReShade
   - Lighting overhauls

4. **Use game-specific tweaks**
   - See individual game guides

---

## 🔧 Troubleshooting

### Vortex Won't Start

```bash
# Reset Wine prefix
rm -rf ~/.local/share/wineprefixes/vortex

# Reinstall
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
```

### Mods Not Loading

**Cyberpunk:**
```bash
# Check CET log
cat ~/.local/share/Steam/steamapps/compatdata/1091500/pfx/drive_c/users/steamuser/AppData/Local/Cyberpunk\ 2077/cyber_engine_tweaks.log
```

**Fallout 4:**
```bash
# Check Buffout crash log
cat ~/.local/share/Steam/steamapps/compatdata/377160/pfx/drive_c/users/steamuser/Documents/My\ Games/Fallout4/F4SE/Logs/Buffout4/crash-*.log
```

**Starfield:**
```bash
# Check plugins.txt
cat ~/.local/share/Steam/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/AppData/Local/Starfield/plugins.txt
```

### Game Crashes

**Quick fix:**
```bash
# Try recovery level 1
recovery-game [game] 1

# If that doesn't work, level 2
recovery-game [game] 2
```

---

## 📝 Quick Reference Commands

```bash
# Vortex
vortex                              # Launch Vortex

# Backups
backup-saves                        # Backup all games
backup-saves --game cyberpunk       # Backup specific game
backup-saves --list                 # List backups
backup-saves --restore 20250109...  # Restore backup

# Recovery
recovery-game cyberpunk 1           # Soft recovery
recovery-game fallout4 2            # Medium recovery
recovery-game starfield 3           # Nuclear recovery

# Performance
mangohud [game]                     # Monitor FPS
gamemoded -s                        # Check gamemode status

# Logs
# See troubleshooting section above for log locations
```

---

## 🎓 Learning Path

### Week 1: Get Comfortable with Vortex
- Install Vortex
- Set up one game (Cyberpunk recommended)
- Install 2-3 simple mods
- Learn backup/restore

### Week 2: Add More Mods
- Install frameworks for chosen game
- Add 5-10 mods
- Test stability
- Practice using recovery if needed

### Week 3: Second Game
- Set up another game (Fallout 4)
- Apply knowledge from first game
- Learn load order management

### Week 4: Advanced Modding
- Add third game (Starfield)
- Create mod collections
- Optimize performance
- Experiment with advanced mods

---

## 📚 Additional Resources

**Save these bookmarks:**

- [Nexus Mods](https://www.nexusmods.com)
- [ProtonDB](https://www.protondb.com)
- [r/linux_gaming](https://www.reddit.com/r/linux_gaming)
- [WehttamSnaps Dotfiles](https://github.com/Crowdrocker/wehttamsnaps-dotfiles)

**Discord Communities:**
- Nexus Mods Discord
- ProtonDB Discord
- Game-specific modding communities

---

## ✅ Setup Checklist

**Before you start modding:**

- [ ] Vortex installed and working
- [ ] Backup script installed (`backup-saves`)
- [ ] Recovery script installed (`recovery-game`)
- [ ] All game guides downloaded
- [ ] Flowcharts reviewed
- [ ] Steam launch options configured
- [ ] First backup created
- [ ] Test game launches without mods

**For each new game:**

- [ ] Game guide read completely
- [ ] Script extender installed (if needed)
- [ ] Configuration files edited
- [ ] Framework mods installed
- [ ] Performance mods installed
- [ ] Backup created before adding mods
- [ ] Test vanilla game first

---

## 🎉 You're Ready!

You now have everything you need to mod your games safely and effectively!

**Remember:**
1. **Always backup before modding**
2. **Add mods one at a time**
3. **Test after each mod**
4. **Read mod requirements**
5. **Use recovery when needed**

**Happy modding! 🎮**

---

*Part of WehttamSnaps Dotfiles*  
*https://github.com/Crowdrocker/wehttamsnaps-dotfiles*