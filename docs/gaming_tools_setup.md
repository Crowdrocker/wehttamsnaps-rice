# WehttamSnaps Gaming Tools Complete Setup

Complete setup guide for all new gaming management tools.

---

## 📦 What's Included

1. **Vortex Auto-Update** - Keep Vortex updated automatically
2. **Mod Collection Manager** - Manage different mod loadouts
3. **Performance Profile Switcher** - Switch between performance modes
4. **Steam Launch Options Manager** - Manage game launch options
5. **Niri Window Rules** - Proper window management for gaming tools

---

## 🚀 Installation

### Step 1: Save All Scripts

```bash
# Create directory
mkdir -p ~/.config/wehttamsnaps/scripts/gaming

# Save scripts
cd ~/.config/wehttamsnaps/scripts/gaming
```

**Save these files:**
1. `vortex-update` - Auto-update script
2. `mod-collections` - Collection manager
3. `perf-profile` - Performance switcher
4. `steam-launch` - Launch options manager

**Make executable:**
```bash
chmod +x ~/.config/wehttamsnaps/scripts/gaming/*

# Create symlinks for easy access
ln -s ~/.config/wehttamsnaps/scripts/gaming/vortex-update ~/.local/bin/vortex-update
ln -s ~/.config/wehttamsnaps/scripts/gaming/mod-collections ~/.local/bin/mod-collections
ln -s ~/.config/wehttamsnaps/scripts/gaming/perf-profile ~/.local/bin/perf-profile
ln -s ~/.config/wehttamsnaps/scripts/gaming/steam-launch ~/.local/bin/steam-launch
```

### Step 2: Install Niri Window Rules

```bash
# Copy gaming rules
cp 40-gaming.kdl ~/.config/niri/conf.d/

# Reload Niri
niri msg action reload-config
# Or: Mod+Shift+C
```

### Step 3: Install Dependencies

```bash
# For clipboard support
sudo pacman -S wl-clipboard

# For JSON parsing (mod collections)
sudo pacman -S jq
```

---

## 🔧 Tool Usage

### 1. Vortex Auto-Update

**Check for updates:**
```bash
vortex-update --check
```

**Update Vortex:**
```bash
vortex-update
```

**View changelog:**
```bash
vortex-update --changelog
```

**Set up automatic checks (cron):**
```bash
crontab -e

# Add this line (check daily at 10 AM):
0 10 * * * /home/YOUR_USERNAME/.local/bin/vortex-update --auto
```

**What it does:**
- Checks GitHub for latest Vortex version
- Backs up your Vortex data before updating
- Downloads and installs update
- Preserves all mod staging folders
- Keeps your settings

---

### 2. Mod Collection Manager

**Create a collection:**
```bash
# Save current setup
mod-collections export cyberpunk my-current-setup

# Create from scratch
mod-collections create fallout4 performance-build
```

**List collections:**
```bash
# All collections
mod-collections list

# Specific game
mod-collections list cyberpunk
```

**Show collection details:**
```bash
mod-collections show cyberpunk my-current-setup
```

**Compare collections:**
```bash
mod-collections compare fallout4 current old-backup
```

**Create preset:**
```bash
# Performance preset
mod-collections preset starfield performance

# Available presets: vanilla, performance, immersive
```

**Use cases:**
- **Backup current mods** before major changes
- **Compare** different mod setups
- **Share** mod lists with others
- **Quick switch** between loadouts (manual restore)

---

### 3. Performance Profile Switcher

**Switch profiles:**
```bash
# General profiles
perf-profile performance    # Gaming mode
perf-profile balanced       # Normal use
perf-profile powersave      # Battery/idle

# Game-specific profiles
perf-profile cyberpunk      # Cyberpunk optimized
perf-profile fallout4       # Fallout 4 optimized
perf-profile starfield      # Starfield optimized
```

**Check current profile:**
```bash
perf-profile status
```

**List all profiles:**
```bash
perf-profile list
```

**Auto-detect game:**
```bash
# Automatically applies best profile for running game
perf-profile auto
```

**What each profile does:**

**Performance:**
- CPU: Performance governor
- GPU: High performance mode
- Swappiness: 10
- Animations: Disabled
- DND: Enabled

**Balanced:**
- CPU: Schedutil governor
- GPU: Auto mode
- Swappiness: 60
- Animations: Enabled

**Powersave:**
- CPU: Powersave governor
- GPU: Low power mode
- Swappiness: 100

**Game-specific profiles:**
- Include game-specific environment variables
- Optimized for each game's quirks

**Keybind suggestion:**
```kdl
// Add to ~/.config/niri/conf.d/10-keybinds.kdl

// Performance toggle
Mod+Shift+P { spawn "perf-profile" "performance"; }
Mod+Alt+P { spawn "perf-profile" "balanced"; }

// Game-specific (before launching)
Mod+Shift+G+C { spawn "perf-profile" "cyberpunk"; }
Mod+Shift+G+F { spawn "perf-profile" "fallout4"; }
Mod+Shift+G+S { spawn "perf-profile" "starfield"; }
```

---

### 4. Steam Launch Options Manager

**Show presets for a game:**
```bash
steam-launch show cyberpunk
steam-launch show fallout4
steam-launch show starfield
```

**Copy options to clipboard:**
```bash
# Copy default preset
steam-launch copy cyberpunk default

# Copy F4SE preset (for Fallout 4)
steam-launch copy fallout4 f4se

# Copy SFSE preset (for Starfield)
steam-launch copy starfield sfse
```

**Explain what options do:**
```bash
steam-launch explain
```

**Build custom options interactively:**
```bash
steam-launch build
```

**Available presets:**

**Cyberpunk 2077:**
- `default` - Standard optimizations
- `performance` - Maximum FPS
- `stability` - Crash prevention
- `debug` - Enable logging

**Fallout 4:**
- `default` - Standard optimizations
- `f4se` - Launch with F4SE (REQUIRED for mods!)
- `performance` - Maximum FPS
- `stability` - Crash prevention

**Starfield:**
- `default` - Standard optimizations
- `sfse` - Launch with SFSE (for mods)
- `performance` - Maximum FPS
- `fsr` - AMD FSR upscaling

**How to use:**
1. Run: `steam-launch copy fallout4 f4se`
2. Options copied to clipboard
3. Open Steam → Right-click game → Properties
4. Paste into "Launch Options" field
5. Done!

---

### 5. Niri Window Rules

**Rules included:**

**Vortex:**
- Main window: Floating, 1280x720
- Dialogs: Floating, 800x600
- Wine system tray: Suppressed

**SteamTinkerLaunch:**
- Main window: Floating, 1024x768
- Configuration dialogs: Floating

**Mod Organizer 2:**
- Main window: Floating, 1280x720
- File pickers: Floating, stay on top

**Games:**
- Cyberpunk/Fallout 4/Starfield: Fullscreen, Workspace 3
- All Steam games: Fullscreen by default

**Testing rules:**
```bash
# Launch Vortex and check if it floats correctly
vortex

# Check current windows
niri msg windows

# Reload rules if changed
niri msg action reload-config
```

**Customizing rules:**
Edit `~/.config/niri/conf.d/40-gaming.kdl` and reload Niri.

---

## 🎯 Workflow Examples

### Before Gaming Session

```bash
# 1. Backup saves
backup-saves

# 2. Switch to gaming profile
perf-profile performance
# Or game-specific:
perf-profile cyberpunk

# 3. Check Vortex is up to date
vortex-update --check

# 4. Launch game
# Steam will use launch options you configured
```

### After Gaming Session

```bash
# 1. Switch back to balanced profile
perf-profile balanced

# 2. Backup saves (optional)
backup-saves --auto
```

### Trying New Mod Setup

```bash
# 1. Export current collection
mod-collections export cyberpunk current-stable

# 2. Add new mods in Vortex
# ... test mods ...

# 3. If it works, export new collection
mod-collections export cyberpunk experimental

# 4. If it breaks, restore from backup
backup-saves --restore 20250109-143022
# ... restore via Vortex ...
```

### Performance Testing

```bash
# Test different profiles
perf-profile performance
# Launch game, note FPS

perf-profile balanced
# Launch game, compare FPS

# Use best profile
```

---

## 🔑 Quick Commands Reference

```bash
# Vortex
vortex-update               # Update Vortex
vortex-update --check       # Check version only

# Collections
mod-collections list        # List all
mod-collections export cyberpunk current  # Save current

# Performance
perf-profile performance    # Gaming mode
perf-profile balanced       # Normal mode
perf-profile status         # Check current

# Steam Launch Options
steam-launch show fallout4  # Show presets
steam-launch copy fallout4 f4se  # Copy to clipboard

# Backups (from earlier)
backup-saves               # Backup all
backup-saves --list        # List backups
backup-saves --restore ... # Restore

# Recovery (from earlier)
recovery-game cyberpunk 1  # Soft recovery
recovery-game fallout4 2   # Medium recovery
```

---

## 📱 Keybinds Integration

Add to `~/.config/niri/conf.d/10-keybinds.kdl`:

```kdl
// ===================================================================
// GAMING TOOLS
// ===================================================================

// Vortex
Mod+Shift+V { spawn "vortex"; }

// Performance profiles
Mod+Shift+P { spawn "perf-profile" "performance"; }
Mod+Alt+P { spawn "perf-profile" "balanced"; }

// Game-specific performance
Mod+Shift+G+C { spawn "perf-profile" "cyberpunk"; }
Mod+Shift+G+F { spawn "perf-profile" "fallout4"; }
Mod+Shift+G+S { spawn "perf-profile" "starfield"; }

// Backup saves quickly
Mod+Shift+B { spawn "ghostty" "-e" "backup-saves"; }

// Check performance status
Mod+Shift+I { spawn "ghostty" "-e" "perf-profile" "status"; }
```

Reload Niri: `Mod+Shift+C`

---

## 🎮 Integration with Existing Tools

All tools work together:

1. **Vortex Auto-Update** keeps Vortex fresh
2. **Mod Collections** track your mod setups
3. **Performance Profiles** optimize system
4. **Steam Launch Options** optimize games
5. **Backup/Recovery** protect your data
6. **Niri Rules** make windows behave

**Complete gaming workflow:**
```bash
# Morning setup
vortex-update --check
perf-profile balanced

# Before gaming
backup-saves
perf-profile cyberpunk
# Launch Cyberpunk via Steam (with configured launch options)

# After gaming
perf-profile balanced
backup-saves --auto

# If something breaks
recovery-game cyberpunk 1
```

---

## 📝 Tips & Tricks

### Automatic Profile Switching

Create a game launcher script:

```bash
#!/bin/bash
# launch-cyberpunk.sh

# Apply profile
perf-profile cyberpunk

# Launch game
steam steam://rungameid/1091500

# Wait for game to exit
wait

# Restore balanced profile
perf-profile balanced
```

### Weekly Maintenance

```bash
# Create maintenance script
cat > ~/.local/bin/gaming-maintenance << 'EOF'
#!/bin/bash
echo "🎮 Gaming Maintenance"
echo ""

# Check Vortex updates
vortex-update --check

# Clean old backups (keep 10)
backup-saves --clean 10

# List collections
mod-collections list

echo ""
echo "✓ Maintenance complete"
EOF

chmod +x ~/.local/bin/gaming-maintenance

# Run weekly
gaming-maintenance
```

### Export All Collections

```bash
# Backup all current setups
for game in cyberpunk fallout4 starfield; do
    mod-collections export $game backup-$(date +%Y%m%d)
done
```

---

## 🆘 Troubleshooting

### Vortex won't update

```bash
# Check internet connection
ping github.com

# Check manually
vortex-update --changelog

# Force reinstall if needed
bash ~/.config/wehttamsnaps/scripts/gaming/vortex-setup.sh
```

### Performance profile not applying

```bash
# Check sudo access
sudo -v

# Check status
perf-profile status

# Try manual apply
sudo cpupower frequency-set -g performance
```

### Window rules not working

```bash
# Check window app-id
niri msg windows

# Reload config
niri msg action reload-config

# Check syntax
kdl check ~/.config/niri/conf.d/40-gaming.kdl
```

---

## 📚 Additional Resources

- **Vortex Wiki:** [wiki.nexusmods.com/index.php/Vortex](https://wiki.nexusmods.com/index.php/Vortex)
- **Niri Manual:** [github.com/YaLTeR/niri](https://github.com/YaLTeR/niri)
- **ProtonDB:** [protondb.com](https://www.protondb.com)

---

**All gaming tools ready! 🎮🚀**

*Part of WehttamSnaps Dotfiles*  
*https://github.com/Crowdrocker/wehttamsnaps-dotfiles*