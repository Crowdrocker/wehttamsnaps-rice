#!/bin/bash
# === WEHTTAMSNAPS STEAM LAUNCH OPTIMIZER ===
# RX 580 optimized launch options for better gaming performance

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

STEAM_DIR="$HOME/.steam/steam"
STEAMAPPS_DIR="$STEAM_DIR/steamapps"
CONFIG_FILE="$HOME/.steam/steam/config/config.vdf"

echo -e "${BLUE}[INFO] WehttamSnaps Steam Launch Options Optimizer${NC}"
echo -e "${BLUE}[INFO] Optimizing for RX 580 and Linux gaming${NC}"

# Check if Steam is installed
check_steam() {
    if [ ! -d "$STEAM_DIR" ]; then
        echo -e "${RED}[ERROR] Steam is not installed. Please install Steam first.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}[OK] Steam installation found${NC}"
}

# Backup current config
backup_config() {
    if [ -f "$CONFIG_FILE" ]; then
        cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d-%H%M%S)"
        echo -e "${GREEN}[OK] Config backed up${NC}"
    fi
}

# Create launch options for specific games
create_launch_options() {
    echo -e "${YELLOW}[SETUP] Creating optimized launch options...${NC}"
    
    # Create WehttamSnaps launch options file
    cat > "$HOME/.config/wehttamsnaps/steam-launch-options.json" << 'EOF'
{
  "launch_options": {
    "cyberpunk_2077": {
      "appid": "1091500",
      "options": "gamemoderun %command% -vulkan -fullscreen %command%",
      "description": "Cyberpunk 2077 - Vulkan with GameMode"
    },
    "the_division_2": {
      "appid": "817370", 
      "options": "gamemoderun %command% -force-vulkan -windowed",
      "description": "The Division 2 - Vulkan mode"
    },
    "proton_experimental": {
      "options": "PROTON_USE_WINED3D=1 gamemoderun %command%",
      "description": "General Proton Experimental with D3D9"
    },
    "dxvk_vulkan": {
      "options": "DXVK_ASYNC=1 gamemoderun %command%",
      "description": "DXVK with async for better performance"
    },
    "gamescope_fullscreen": {
      "options": "gamemoderun gamescope -f -r 60 -w 1920 -h 1080 -- %command%",
      "description": "Gamescope fullscreen 1080p 60Hz"
    },
    "gamescope_windowed": {
      "options": "gamemoderun gamescope -w 1920 -h 1080 -r 60 -- %command%",
      "description": "Gamescope windowed 1080p 60Hz"
    }
  }
}
EOF
    
    echo -e "${GREEN}[OK] Launch options configuration created${NC}"
}

# Configure environment variables
configure_environment() {
    echo -e "${YELLOW}[SETUP] Configuring Steam environment variables...${NC}"
    
    # Create environment variables file
    cat > "$HOME/.config/wehttamsnaps/steam-environment" << 'EOF'
# WehttamSnaps Steam Environment Variables
# RX 580 optimizations and Linux gaming tweaks

# Vulkan settings
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
export DRI_PRIME=1

# Proton/Steam settings
export STEAM_RUNTIME=0
export STEAM_FRAME_FORCE_CLOSE=1
export PROTON_USE_WINED3D=1
export DXVK_STATE_CACHE_PATH=~/.cache/dxvk
export WINEPREFIX=~/Games/wine

# Performance settings
export __GL_THREADED_OPTIMIZATIONS=1
export __GL_SHADER_DISK_CACHE=1
export __GL_SHADER_DISK_CACHE_PATH=~/.cache/nvidia
export __GL_YIELD=USLEEP

# Audio settings
export PULSE_LATENCY_MSEC=60
export SDL_AUDIODRIVER=pulseaudio

# Input settings
export SDL_JOYSTICK_DEVICE=/dev/input/js0

# Anti-cheat compatibility
export PROTON_NO_ESYNC=1
export PROTON_NO_FSYNC=1

# RX 580 specific
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=rt
EOF
    
    echo -e "${GREEN}[OK] Environment variables configured${NC}"
}

# Create GameMode configuration
configure_gamemode() {
    echo -e "${YELLOW}[SETUP] Configuring GameMode for optimal performance...${NC}"
    
    sudo mkdir -p /etc/gamemode.d
    
    # Create WehttamSnaps GameMode config
    cat | sudo tee /etc/gamemode.d/10-wehttamsnaps.cfg > /dev/null << 'EOF'
[general]
; The governor used for CPU when gamemode is active
desiredgov=performance

; The governor used for CPU when gamemode is inactive (set to empty string to disable)
defaultgov=ondemand

; The iogpu used for GPU when gamemode is active (requires i_gpu support from kernel and drivers)
igpu_desiredgov=performance

; The iogpu used for GPU when gamemode is inactive
igpu_defaultgov=ondemand

; Disable split lock mitigation
splittlock=0

; Pin games to specific cores (set to 0 to disable)
pin_cores=0,1,2,3,4,5,6,7

; Renice games (lower values = higher priority)
renice=-5

; Scheduling policy (0 = SCHED_NORMAL, 1 = SCHED_FIFO, 2 = SCHED_RR)
sched_policy=0

; Priority for scheduling policy (1-99, only real-time policies)
sched_priority=50

; Enable CPU frequency scaling
softrealtime=on

; Force specific CPU threads
force_cpus=0-7

[cpu]
; Enable CPU governor control
gpu_gpu0=0

[amd]
; AMD specific settings
core_pstate=performance
; Enable AMDGPU overclocking (requires corectrl)
overclock=1

[vulkan]
; Vulkan specific settings
nvidia_vulkan_ahash=1

[custom]
; Custom scripts to run when gamemode starts
start="~/../.config/wehttamsnaps/scripts/gamemode-start.sh"

; Custom scripts to run when gamemode ends
end="~/../.config/wehttamsnaps/scripts/gamemode-end.sh"
EOF
    
    # Create gamemode start script
    cat > "$HOME/.config/wehttamsnaps/scripts/gamemode-start.sh" << 'EOF'
#!/bin/bash
# WehttamSnaps GameMode start script

echo "🎮 GameMode activated - WehttamSnaps optimizations enabled"

# Set CPU governor
sudo cpupower frequency-set -g performance

# Disable EasyEffects for lower latency
killall easyeffects 2>/dev/null || true

# Enable GPU performance mode
corectrl --set-profile "performance" 2>/dev/null || true

# Set VRAM limit for better stability
echo 4000 > /sys/class/drm/card0/device/gpu_vram_total_size 2>/dev/null || true

# Disable swap for better performance
sudo swapoff -a

# Clear system caches
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

echo "✅ GameMode optimizations applied"
EOF
    
    # Create gamemode end script
    cat > "$HOME/.config/wehttamsnaps/scripts/gamemode-end.sh" << 'EOF'
#!/bin/bash
# WehttamSnaps GameMode end script

echo "😴 GameMode deactivated - Restoring normal settings"

# Restore CPU governor
sudo cpupower frequency-set -g ondemand

# Re-enable EasyEffects
easyeffects --gapplication-service &

# Reset GPU profile
corectrl --set-profile "default" 2>/dev/null || true

# Re-enable swap
sudo swapon -a

echo "✅ Normal settings restored"
EOF
    
    chmod +x "$HOME/.config/wehttamsnaps/scripts/gamemode-start.sh"
    chmod +x "$HOME/.config/wehttamsnaps/scripts/gamemode-end.sh"
    
    echo -e "${GREEN}[OK] GameMode configuration created${NC}"
}

# Create troubleshooting guide
create_troubleshooting() {
    echo -e "${YELLOW}[SETUP] Creating troubleshooting guide...${NC}"
    
    cat > "$HOME/.config/wehttamsnaps/troubleshooting-gaming.md" << 'EOF'
# WehttamSnaps Gaming Troubleshooting Guide

## Common Issues and Solutions

### Games Won't Launch

**Problem**: Games crash immediately or won't start
**Solution**: 
1. Check Proton version: Use Proton Experimental or GE-Proton
2. Verify Vulkan support: Run `vulkaninfo`
3. Check GameMode: Run `gamemoded -s`
4. Update drivers: `sudo pacman -Syu`

### Poor Performance

**Problem**: Low FPS or stuttering
**Solution**:
1. Enable GameMode: `gamemoderun your_game`
2. Use Gamescope: `gamescope -f -r 60 -- your_game`
3. Check CPU governor: `cpupower frequency-info`
4. Monitor GPU usage: `nvtop`

### Audio Issues

**Problem**: No sound or crackling audio
**Solution**:
1. Restart PipeWire: `systemctl --user restart pipewire`
2. Check EasyEffects settings
3. Verify game audio routing in Qpwgraph
4. Use GameMode environment variables

### Proton Issues

**Problem**: Windows games won't run properly
**Solution**:
1. Update ProtonGE: `protonup-qt`
2. Use correct launch options
3. Check compatibility mode
4. Verify Wine prefix

### Controller Issues

**Problem**: Game controller not detected
**Solution**:
1. Check kernel modules: `lsmod | grep xpad`
2. Test with jstest: `jstest-gtk`
3. Configure in Steam settings
4. Use antimicrox for advanced setup

## Performance Optimization Commands

### Check System Status
```bash
# Check GameMode status
gamemoded -s

# Check CPU governor
cpupower frequency-info

# Monitor GPU usage
nvtop

# Check Vulkan support
vulkaninfo | grep "GPU"
```

### Optimize for Gaming
```bash
# Enable performance mode
sudo cpupower frequency-set -g performance

# Clear system caches
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

# Disable swap temporarily
sudo swapoff -a

# Start monitoring
htop && nvtop
```

### Restore Normal Settings
```bash
# Restore ondemand governor
sudo cpupower frequency-set -g ondemand

# Re-enable swap
sudo swapon -a

# Restart normal services
systemctl --user restart pipewire easyeffects
```

## Recommended Launch Options

### General Gaming
```
gamemoderun %command%
```

### Vulkan Games
```
gamemoderun %command% -vulkan
```

### Proton Games
```
PROTON_USE_WINED3D=1 gamemoderun %command%
```

### Gamescope (for compatibility)
```
gamemoderun gamescope -f -r 60 -w 1920 -h 1080 -- %command%
```

### DXVK Async (for AMD GPUs)
```
DXVK_ASYNC=1 gamemoderun %command%
```

## Hardware Monitoring

### Install monitoring tools
```bash
sudo pacman -S nvtop htop iotop
```

### Monitor during gaming
```bash
# System monitoring
htop

# GPU monitoring
nvtop

# Disk I/O monitoring
sudo iotop
```

## Getting Help

- Check system logs: `journalctl -xe`
- Steam logs: `~/.steam/steam/logs/`
- WehttamSnaps issues: https://github.com/Crowdrocker/wehttamsnaps/issues
- ProtonDB: https://www.protondb.com/
EOF
    
    echo -e "${GREEN}[OK] Troubleshooting guide created${NC}"
}

# Test configuration
test_configuration() {
    echo -e "${YELLOW}[TEST] Testing Steam configuration...${NC}"
    
    # Check GameMode
    if gamemoded -s | grep -q "GameMode is active"; then
        echo -e "${GREEN}[OK] GameMode is running${NC}"
    else
        echo -e "${YELLOW}[INFO] GameMode not running - start gaming to activate${NC}"
    fi
    
    # Check Vulkan
    if command -v vulkaninfo &> /dev/null; then
        echo -e "${GREEN}[OK] Vulkan tools installed${NC}"
        vulkaninfo --summary | grep "GPU" || echo -e "${YELLOW}[INFO] No Vulkan GPU detected${NC}"
    else
        echo -e "${YELLOW}[WARN] Vulkan tools not installed${NC}"
    fi
    
    # Check Steam directory
    if [ -d "$STEAM_DIR" ]; then
        echo -e "${GREEN}[OK] Steam directory accessible${NC}"
    else
        echo -e "${RED}[ERROR] Steam directory not found${NC}"
    fi
}

# Main function
main() {
    check_steam
    backup_config
    create_launch_options
    configure_environment
    configure_gamemode
    create_troubleshooting
    test_configuration
    
    echo ""
    echo -e "${GREEN}🎮 WehttamSnaps Steam optimization complete!${NC}"
    echo ""
    echo -e "${YELLOW}📋 What was configured:${NC}"
    echo -e "   • Optimized launch options for popular games"
    echo -e "   • GameMode performance profiles"
    echo -e "   • Environment variables for RX 580"
    echo -e "   • Automated start/end scripts"
    echo ""
    echo -e "${YELLOW}🚀 Recommended games setup:${NC}"
    echo -e "   • Cyberpunk 2077: gamemoderun %command% -vulkan"
    echo -e "   • The Division 2: gamemoderun %command% -force-vulkan"
    echo -e "   • General: gamemoderun %command%"
    echo ""
    echo -e "${BLUE}📖 Documentation:${NC}"
    echo -e "   See ~/.config/wehttamsnaps/troubleshooting-gaming.md"
    echo ""
    echo -e "${CYAN}💡 Tip: Use 'gamemoderun' before launching any game for maximum performance!${NC}"
}

# Run configuration
main "$@"