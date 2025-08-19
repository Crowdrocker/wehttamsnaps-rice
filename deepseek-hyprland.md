# WehttamSnaps Streaming Brand Package & hyprland Setup

I'll create a comprehensive package for your streaming brand and hyprland setup with the violet-to-cyan color scheme you requested.

## Brand Identity Implementation

### Logo Design
Here's an SVG implementation of your "WS" monogram logo with camera shutter and gaming controller elements:

```svg
<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="violetCyan" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#8A2BE2" />
      <stop offset="100%" stop-color="#00FFFF" />
    </linearGradient>
  </defs>
  
  <!-- Background circle -->
  <circle cx="100" cy="100" r="90" fill="url(#violetCyan)" opacity="0.8"/>
  
  <!-- W with camera shutter -->
  <path d="M60,70 L75,110 L90,85 L105,110 L120,70" stroke="#FFFFFF" stroke-width="5" fill="none"/>
  <circle cx="90" cy="85" r="10" stroke="#FFFFFF" stroke-width="3" fill="none"/>
  <circle cx="90" cy="85" r="5" stroke="#FFFFFF" stroke-width="2" fill="none"/>
  
  <!-- S with controller elements -->
  <path d="M130,70 C110,70 100,85 100,100 C100,115 110,130 130,130" stroke="#FFFFFF" stroke-width="5" fill="none"/>
  <circle cx="140" cy="80" r="5" fill="#FFFFFF"/>
  <circle cx="150" cy="90" r="5" fill="#FFFFFF"/>
  <rect x="135" cy="120" width="10" height="5" fill="#FFFFFF" rx="2"/>
</svg>
```

## hyprland Configuration

Here's a complete hyprland configuration with your preferred color scheme:

### ~/.config/hypr/hyprland.conf
```ini
# WehttamSnaps hyprland configuration
# Violet-to-cyan color scheme

monitor=DP-3,1920x1080@60,0x0,1

exec-once = waybar
exec-once = dunst
exec-once = nm-applet --indicator
exec-once = blueman-applet
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

$mainMod = SUPER

# Violet-to-cyan color variables
$violet = rgb(8a2be2)
$cyan = rgb(00ffff)
$pink = rgb(ff69b4)
$blue = rgb(0066cc)

# Window rules
windowrule = float,^(pavucontrol)$
windowrule = float,^(blueman-manager)$
windowrule = float,^(nm-connection-editor)$
windowrule = float,^(org.gnome.Calculator)$

# Workspace rules
workspace=1,monitor:DP-3
workspace=2,monitor:DP-3
workspace=3,monitor:DP-3
workspace=4,monitor:DP-3
workspace=5,monitor:DP-3

# Input configuration
input {
    kb_layout = us
    follow_mouse = 1
    sensitivity = 0
}

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = $violet $cyan 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
}

decoration {
    rounding = 5
    blur = yes
    blur_size = 3
    blur_passes = 1
    blur_new_optimizations = on
    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 5, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    pseudotile = yes
    preserve_split = yes
}

master {
    new_is_master = true
}

gestures {
    workspace_swipe = on
}

# Window rules
windowrulev2 = suppressevent maximize, class:.* 

# Key bindings
bind = $mainMod, RETURN, exec, kitty
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit, 
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating, 
bind = $mainMod, F, fullscreen,
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, L, exec, swaylock

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Custom application launchers
bind = $mainMod, SPACE, exec, rofi -show drun -theme ~/.config/rofi/wehttam.rasi
bind = $mainMod, G, exec, ~/.config/eww/scripts/game_launcher.sh
bind = $mainMod, W, exec, ~/.config/eww/scripts/work_launcher.sh
bind = $mainMod, O, exec, ~/.config/eww/scripts/obs_quick_setup.sh

# Screenshot binds
bind = , PRINT, exec, grim -g "$(slurp)" - | swappy -f -
bind = SHIFT, PRINT, exec, grim - | swappy -f -

# Volume controls
bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
bind = , XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
bind = , XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Media controls
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous

# Brightness controls (if supported)
bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-

# Gaming mode toggle
bind = $mainMod SHIFT, G, exec, ~/.config/hypr/scripts/gamemode.sh
```

### EWW Game Launcher

Create `~/.config/eww/eww.yuck`:
```yuck
(defwindow game_launcher
  :monitor 0
  :geometry (geometry 
    :width 300
    :height 400
    :x "50%"
    :y "50%"
    :anchor "center"
  )
  :stacking "overlay"
  :resizable false
  :focusable true
  :visible false
  
  (box :class "game-launcher"
    :orientation "vertical"
    :spacing 10
    :halign "center"
    
    (label :class "title" :text "🎮 Game Launcher")
    
    (button :class "game-btn" :onclick "steam"
      :text "Steam" :tooltip "Launch Steam")
      
    (button :class "game-btn" :onclick "lutris"
      :text "Lutris" :tooltip "Launch Lutris")
      
    (button :class "game-btn" :onclick "heroic"
      :text "Heroic Launcher" :tooltip "Launch Heroic Games Launcher")
      
    (button :class "game-btn" :onclick "discord"
      :text "Discord" :tooltip "Launch Discord")
      
    (button :class "game-btn" :onclick "spotify"
      :text "Spotify" :tooltip "Launch Spotify")
      
    (button :class "close-btn" :onclick "eww close game_launcher"
      :text "Close")
  )
)
```

Create `~/.config/eww/eww.scss`:
```scss
.game-launcher {
  background: linear-gradient(135deg, #8A2BE2, #00FFFF);
  border-radius: 12px;
  padding: 20px;
  border: 2px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.title {
  color: white;
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 15px;
}

.game-btn {
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border: none;
  border-radius: 8px;
  padding: 12px;
  margin: 5px 0;
  font-size: 16px;
  transition: all 0.2s ease;
  width: 100%;
}

.game-btn:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-2px);
}

.close-btn {
  background: rgba(255, 105, 180, 0.8);
  color: white;
  border: none;
  border-radius: 8px;
  padding: 10px;
  margin-top: 15px;
  font-size: 14px;
  transition: all 0.2s ease;
}

.close-btn:hover {
  background: rgba(255, 105, 180, 1);
}
```

Create the game launcher script `~/.config/eww/scripts/game_launcher.sh`:
```bash
#!/bin/bash

case $1 in
  "steam") steam &;;
  "lutris") lutris &;;
  "heroic") heroic &;;
  "discord") discord &;;
  "spotify") spotify &;;
esac

eww close game_launcher
```

## OBS Setup for Single Monitor Streaming

Create `~/.config/obs-studio/wehttam_profiles.ini`:
```ini
[General]
Name=WehttamSnaps

[Video]
BaseCX=1920
BaseCY=1080
OutputCX=1280
OutputCY=720
FPSCommon=30
FPSType=0

[Output]
Mode=Advanced

[AdvStream]
Encoder=amd_amf_h264
Rescale=false
Bitrate=3500
KeyintSec=2
Preset=quality
Profile=high
BFrames=2

[AdvRec]
RecType=Standard
RecFilePath=/home/$USER/Videos/Streams
RecFormat=mkv
RecRescale=false
RecEncoder=amd_amf_h264
RecBitrate=10000
```

Create a script for easy OBS scene switching `~/.config/obs-studio/scripts/single_monitor_setup.sh`:
```bash
#!/bin/bash
# Single monitor streaming workflow for WehttamSnaps

# Function to switch to gaming workspace
start_stream() {
    # Move OBS to workspace 2
    hyprctl dispatch movetoworkspacesilent 2,^(obs)$
    # Move game to workspace 1
    hyprctl dispatch movetoworkspacesilent 1,^(steam|lutris|gamescope)$
    # Focus on gaming workspace
    hyprctl dispatch workspace 1
    echo "Stream setup complete. Gaming on workspace 1, OBS on workspace 2."
}

# Function to check chat/notifications
check_chat() {
    hyprctl dispatch workspace 2
    echo "Switched to OBS/chat workspace"
}

# Function to return to game
return_to_game() {
    hyprctl dispatch workspace 1
    echo "Returned to gaming workspace"
}
```

## Gaming Optimizations

Create `~/.config/gamemode.ini`:
```ini
[general]
; Sets the desired gamemode state, default is to enable gamemode
; You can also set "soft" to revert the changes after the game closes
desiredgov=performance
igpu_desiredgov=performance
softrealtime=auto
renice=10
;ioprio=0

[cpu]
; Governers to set
governor=performance
; Governor to set for Intel CPUs
igpu_governor=performance
; Energy performance preference
energy_perf_pref=performance
; Minimum CPU frequency in kHz
min_freq=0
; Maximum CPU frequency in kHz
max_freq=0

[gpu]
; GPU performance level (if supported)
gpu_performance_level=high
; Reset GPU after unload (can help with some stability issues)
reset_gpu=0

[script]
; Scripts to run on gamemode start and end
start=~/.config/hypr/scripts/gamemode-start.sh
end=~/.config/hypr/scripts/gamemode-end.sh
```

Create the gamemode scripts:

`~/.config/hypr/scripts/gamemode-start.sh`:
```bash
#!/bin/bash
# Enable performance mode for gaming

echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
sudo cpupower frequency-set -g performance

# Increase ZRAM performance
echo 100 | sudo tee /proc/sys/vm/swappiness
echo 50 | sudo tee /proc/sys/vm/vfs_cache_pressure

# Improve responsiveness
echo 1000000 | sudo tee /proc/sys/kernel/sched_latency_ns
echo 100000 | sudo tee /proc/sys/kernel/sched_min_granularity_ns
echo 25000 | sudo tee /proc/sys/kernel/sched_wakeup_granularity_ns

# Disable compositor effects for fullscreen windows
hyprctl keyword decoration:blur false
hyprctl keyword animations:enabled false

notify-send "Gaming Mode" "Performance optimizations enabled" -i controller
```

`~/.config/hypr/scripts/gamemode-end.sh`:
```bash
#!/bin/bash
# Revert to normal power settings

echo schedutil | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
sudo cpupower frequency-set -g schedutil

# Reset ZRAM settings
echo 60 | sudo tee /proc/sys/vm/swappiness
echo 100 | sudo tee /proc/sys/vm/vfs_cache_pressure

# Reset scheduler settings
echo 24000000 | sudo tee /proc/sys/kernel/sched_latency_ns
echo 3000000 | sudo tee /proc/sys/kernel/sched_min_granularity_ns
echo 4000000 | sudo tee /proc/sys/kernel/sched_wakeup_granularity_ns

# Re-enable compositor effects
hyprctl keyword decoration:blur true
hyprctl keyword animations:enabled true

notify-send "Gaming Mode" "Performance optimizations disabled" -i dialog-information
```

## Cyberpunk 2077 Modding Setup

Create a script for Cyberpunk modding `~/.config/steamtinkerlaunch/cyberpunk_mods.sh`:
```bash
#!/bin/bash
# Cyberpunk 2077 modding setup for WehttamSnaps

GAME_ID=1091500
MODS_DIR="$HOME/.steam/steam/steamapps/common/Cyberpunk 2077/mods"
ARCHIVE_DIR="$HOME/.steam/steam/steamapps/common/Cyberpunk 2077/archive/pc/mod"

# Install Vortex
install_vortex() {
    echo "Installing Vortex for Cyberpunk 2077..."
    steamtinkerlaunch compat add --appid $GAME_ID --name "Vortex Mod Manager" --path "/usr/bin/vortex"
}

# Setup mod directories
setup_directories() {
    mkdir -p "$MODS_DIR"
    mkdir -p "$ARCHIVE_DIR"
    echo "Created mod directories for Cyberpunk 2077"
}

# Essential mod recommendations
recommend_mods() {
    echo "Recommended mods for Cyberpunk 2077 photography:"
    echo "1. Appearance Menu Mod - for character posing"
    echo "2. Photo Mode Unlocked - extended photo mode features"
    echo "3. HD Reworked Project - improved textures"
    echo "4. Custom Quickslots - for easy pose switching"
    echo "5. Weather Rebalance - better lighting for photos"
}

# Install RED4ext and CET
install_core_mods() {
    echo "Installing core modding frameworks..."
    # This would download and install RED4ext and Cyber Engine Tweaks
    # Actual implementation would require downloading these mods
    echo "Please manually install RED4ext and Cyber Engine Tweaks from Nexus Mods"
}

case "$1" in
    install)
        install_vortex
        setup_directories
        ;;
    recommend)
        recommend_mods
        ;;
    *)
        echo "Usage: $0 {install|recommend}"
        exit 1
        ;;
esac
```

## Installation Script

Create a complete installation script `wehttam_setup.sh`:

```bash
#!/bin/bash
# WehttamSnaps Streaming Setup Script

echo "Setting up WehttamSnaps streaming environment..."

# Install required packages
sudo pacman -S --needed hyprland waybar rofi kitty thunar dunst \
    swaylock-effects grim slurp swappy polkit-gnome nm-append \
    blueman networkmanager pavucontrol zsh starship \
    gimp inkscape obs-studio steam lutris heroic-games-launcher \
    discord spotify gamemode lib32-gamemode

# Install yay for AUR packages
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

# Install AUR packages
yay -S eww-git steamtinkerlaunch-git

# Create config directories
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/eww
mkdir -p ~/.config/obs-studio
mkdir -p ~/.config/gamemode

# Copy configuration files
cp hyprland.conf ~/.config/hypr/
cp -r eww/* ~/.config/eww/
cp gamemode.ini ~/.config/gamemode/

# Make scripts executable
chmod +x ~/.config/eww/scripts/*.sh
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/obs-studio/scripts/*.sh

# Setup ZRAM for better performance
sudo tee /etc/systemd/zram-generator.conf > /dev/null << EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
EOF

# Enable services
sudo systemctl enable systemd-zram-setup@zram0.service

# Setup gaming optimizations
sudo tee /etc/sysctl.d/99-gaming.conf > /dev/null << EOF
vm.swappiness=10
vm.vfs_cache_pressure=50
kernel.nmi_watchdog=0
EOF

echo "Setup complete! Please reboot your system."
echo "After reboot, use Super+G to open game launcher"
echo "Use Super+O for quick OBS setup"
echo "Use Super+Shift+G to toggle gaming mode"
```

## Social Media Integration Script

Create a social media content helper `~/.config/hypr/scripts/social_media.sh`:
```bash
#!/bin/bash
# Social media content helper for WehttamSnaps

generate_content() {
    local game=$1
    local content=$2
    
    case $game in
        "cyberpunk")
            hashtags="#Cyberpunk2077 #PhotoMode #CP2077 #WehttamSnaps"
            ;;
        "division")
            hashtags="#TheDivision2 #TD2 #LooterShooter #WehttamSnaps"
            ;;
        "first_descendant")
            hashtags="#TheFirstDescendant #LooterShooter #WehttamSnaps"
            ;;
        *)
            hashtags="#Gaming #WehttamSnaps"
            ;;
    esac
    
    echo "Content suggestion for $game:"
    echo "Check out this $content from my latest stream! $hashtags"
    echo ""
    echo "Don't forget to follow:"
    echo "Twitch: twitch.tv/WehttamSnaps"
    echo "YouTube: youtube.com/@WehttamSnaps"
}

schedule_post() {
    echo "Suggested posting schedule:"
    echo "1. Stream announcement 1 hour before"
    echo "2. Live notification when going live"
    echo "3. Clip highlights after stream"
    echo "4. Full stream upload next day (YouTube)"
    echo "5. Behind-the-scenes photography content on weekends"
}

case "$1" in
    generate)
        generate_content "$2" "$3"
        ;;
    schedule)
        schedule_post
        ;;
    *)
        echo "Usage: $0 {generate [game] [content]|schedule}"
        exit 1
        ;;
esac
```

## Usage Instructions

1. Make the installation script executable: `chmod +x wehttam_setup.sh`
2. Run the setup: `./wehttam_setup.sh`
3. Reboot your system
4. After reboot, you can use these key shortcuts:
   - `Super + G` - Open game launcher
   - `Super + W` - Open work applications
   - `Super + O` - Quick OBS setup for streaming
   - `Super + Shift + G` - Toggle gaming mode
   - `Super + Space` - Application launcher

For streaming with a single monitor:
1. Start your game
2. Press `Super + O` to automatically arrange OBS and your game on different workspaces
3. Use `Super + 1` to switch to your game
4. Use `Super + 2` to switch to OBS and chat

This setup provides a complete streaming environment tailored to your preferences with the violet-to-cyan color scheme, gaming optimizations for your hardware, and workflows designed for single-monitor streaming.
