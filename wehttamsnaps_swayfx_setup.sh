#!/bin/bash

# WehttamSnaps Complete Streaming & swayfx Setup Script
# Run with: curl -s https://your-repo.com/setup.sh | bash

set -e

# Colors for output
VIOLET='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${VIOLET}╔══════════════════════════════════════╗${NC}"
echo -e "${VIOLET}║      WehttamSnaps Setup Script       ║${NC}"
echo -e "${VIOLET}║    Streaming Brand + swayfx Setup    ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════╝${NC}"

# Check if running on Arch-based system
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}This script is designed for Arch Linux systems${NC}"
    exit 1
fi

# Create directory structure
echo -e "${GREEN}Creating directory structure...${NC}"
mkdir -p ~/.config/{sway,waybar,rofi,eww,dunst,alacritty,starship}
mkdir -p ~/.local/share/{applications,icons,themes}
mkdir -p ~/WehttamSnaps/{Brand,Overlays,Configs,Scripts,Wallpapers}

# Install core packages
echo -e "${GREEN}Installing core packages...${NC}"
sudo pacman -S --needed --noconfirm \
    swayfx waybar rofi dunst alacritty \
    thunar grim slurp wl-clipboard \
    pipewire pipewire-pulse pipewire-alsa \
    pavucontrol bluetuith \
    neofetch htop btop zsh starship \
    git curl wget unzip \
    obs-studio v4l2loopback-dkms \
    steam lutris heroic-games-launcher \
    discord gimp inkscape krita \
    firefox chromium \
    vulkan-radeon lib32-vulkan-radeon \
    gamemode lib32-gamemode \
    mangohud lib32-mangohud

# Install AUR helper (yay) if not present
if ! command -v yay &> /dev/null; then
    echo -e "${GREEN}Installing yay AUR helper...${NC}"
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# Install AUR packages
echo -e "${GREEN}Installing AUR packages...${NC}"
yay -S --needed --noconfirm \
    eww-wayland \
    azote \
    nwg-drawer \
    swaylock-effects \
    wlogout \
    autotiling \
    steamtinkerlaunch \
    webcord \
    spotify

# Create swayfx config with WehttamSnaps theme
echo -e "${GREEN}Creating swayfx configuration...${NC}"
cat > ~/.config/sway/config << 'EOF'
# WehttamSnaps swayfx Configuration
# Violet to Cyan theme

# Variables
set $mod Mod4
set $left h
set $down j
set $up k
set $right l
set $term alacritty
set $menu rofi -show drun -theme ~/.config/rofi/wehttamsnaps.rasi

# Colors (Violet to Cyan gradient theme)
set $violet #8A2BE2
set $cyan #00FFFF
set $deep_blue #0066CC
set $hot_pink #FF69B4
set $dark_bg #1a1b26
set $light_bg #24283b
set $text #c0caf5
set $inactive #565f89

# Window colors
client.focused          $violet $violet $text $cyan $violet
client.focused_inactive $deep_blue $deep_blue $text $deep_blue $deep_blue
client.unfocused        $inactive $inactive $text $inactive $inactive
client.urgent           $hot_pink $hot_pink $text $hot_pink $hot_pink

# Output configuration
output * bg ~/WehttamSnaps/Wallpapers/current.jpg fill

# Input configuration
input type:keyboard {
    xkb_layout us
    xkb_options caps:escape
}

input type:touchpad {
    tap enabled
    natural_scroll enabled
}

# Swayfx specific features
blur enable
blur_xray enable
blur_passes 2
blur_radius 3
shadows enable
shadow_blur_radius 20
shadow_color $violet

corner_radius 10
default_dim_inactive 0.1

# Key bindings
bindsym $mod+Return exec $term
bindsym $mod+Shift+q kill
bindsym $mod+d exec $menu
bindsym $mod+Shift+c reload
bindsym $mod+Shift+e exec wlogout

# Screenshot
bindsym Print exec grim ~/Pictures/screenshot-$(date +%Y%m%d_%H%M%S).png
bindsym Shift+Print exec grim -g "$(slurp)" ~/Pictures/screenshot-$(date +%Y%m%d_%H%M%S).png

# Volume control
bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# Gaming optimizations
bindsym $mod+g exec gamemode
bindsym $mod+Shift+g exec mangohud

# Custom keybindings
bindsym $mod+w exec ~/.config/eww/scripts/toggle-game-launcher.sh
bindsym $mod+s exec ~/.config/eww/scripts/toggle-work-launcher.sh
bindsym $mod+p exec ~/.config/eww/scripts/toggle-power-menu.sh

# Workspace bindings
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9
bindsym $mod+0 workspace number 10

# Move container to workspace
bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9
bindsym $mod+Shift+0 move container to workspace number 10

# Layout stuff
bindsym $mod+b splith
bindsym $mod+v splitv
bindsym $mod+f fullscreen
bindsym $mod+a focus parent

# Moving around
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right

bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right

# Floating windows
bindsym $mod+Shift+space floating toggle
bindsym $mod+space focus mode_toggle

# Autostart
exec waybar
exec dunst
exec autotiling
exec ~/.config/eww/scripts/launch-widgets.sh
exec discord --start-minimized
exec steam -silent

# Floating rules for streaming apps
for_window [app_id="obs"] floating enable
for_window [app_id="pavucontrol"] floating enable
for_window [title="Steam"] floating enable
for_window [class="discord"] move to workspace 10
EOF

# Create Waybar configuration
echo -e "${GREEN}Creating Waybar configuration...${NC}"
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 32,
    "spacing": 4,
    "modules-left": ["sway/workspaces", "sway/mode", "sway/scratchpad"],
    "modules-center": ["clock"],
    "modules-right": ["custom/game-launcher", "custom/work-launcher", "pulseaudio", "network", "cpu", "memory", "temperature", "battery", "custom/power"],
    
    "sway/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "🎮",
            "2": "🌐",
            "3": "📁",
            "4": "🎨",
            "5": "📺",
            "urgent": "🔥",
            "focused": "🎯",
            "default": "💙"
        }
    },
    
    "clock": {
        "timezone": "America/Chicago",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format": "{:%I:%M %p}",
        "format-alt": "{:%Y-%m-%d}"
    },
    
    "cpu": {
        "format": "💻 {usage}%",
        "tooltip": false
    },
    
    "memory": {
        "format": "🧠 {}%"
    },
    
    "temperature": {
        "thermal-zone": 1,
        "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
        "critical-threshold": 80,
        "format-critical": "🔥 {temperatureC}°C",
        "format": "🌡️ {temperatureC}°C"
    },
    
    "network": {
        "format-wifi": "📶 {signalStrength}%",
        "format-ethernet": "🌐 Connected",
        "tooltip-format": "{ifname} via {gwaddr}",
        "format-linked": "🔗 {ifname} (No IP)",
        "format-disconnected": "❌ Disconnected"
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": "🔇 Muted",
        "format-icons": {
            "headphone": "🎧",
            "hands-free": "📞",
            "headset": "🎮",
            "phone": "📱",
            "portable": "📻",
            "car": "🚗",
            "default": ["🔈", "🔉", "🔊"]
        },
        "on-click": "pavucontrol"
    },
    
    "custom/game-launcher": {
        "format": "🎮",
        "tooltip": "Game Launcher",
        "on-click": "~/.config/eww/scripts/toggle-game-launcher.sh"
    },
    
    "custom/work-launcher": {
        "format": "💼",
        "tooltip": "Work Apps",
        "on-click": "~/.config/eww/scripts/toggle-work-launcher.sh"
    },
    
    "custom/power": {
        "format": "⚡",
        "tooltip": "Power Menu",
        "on-click": "~/.config/eww/scripts/toggle-power-menu.sh"
    }
}
EOF

cat > ~/.config/waybar/style.css << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrains Mono", monospace;
    font-weight: bold;
    font-size: 14px;
    min-height: 0;
}

window#waybar {
    background: linear-gradient(90deg, rgba(138, 43, 226, 0.9), rgba(0, 255, 255, 0.9));
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
    border-radius: 0 0 10px 10px;
}

window#waybar.hidden {
    opacity: 0.2;
}

#workspaces {
    margin: 0 4px;
}

#workspaces button {
    padding: 0 8px;
    background-color: transparent;
    color: #ffffff;
    border-bottom: 3px solid transparent;
    border-radius: 5px;
}

#workspaces button:hover {
    background: rgba(255, 255, 255, 0.2);
}

#workspaces button.focused {
    background-color: rgba(255, 255, 255, 0.3);
    border-bottom: 3px solid #00ffff;
}

#clock,
#cpu,
#memory,
#temperature,
#network,
#pulseaudio,
#custom-game-launcher,
#custom-work-launcher,
#custom-power {
    padding: 0 10px;
    margin: 0 2px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
    backdrop-filter: blur(10px);
}

#clock {
    font-weight: bold;
    font-size: 16px;
    background: linear-gradient(45deg, rgba(138, 43, 226, 0.3), rgba(0, 255, 255, 0.3));
}

#cpu.warning {
    background-color: rgba(255, 165, 0, 0.8);
}

#cpu.critical {
    background-color: rgba(255, 0, 0, 0.8);
}

#temperature.critical {
    background-color: rgba(255, 0, 0, 0.8);
    animation: blink 1s linear infinite;
}

@keyframes blink {
    to {
        background-color: rgba(255, 255, 255, 0.1);
    }
}
EOF

# Create Rofi theme
echo -e "${GREEN}Creating Rofi theme...${NC}"
mkdir -p ~/.config/rofi
cat > ~/.config/rofi/wehttamsnaps.rasi << 'EOF'
/* WehttamSnaps Rofi Theme - Violet to Cyan */
* {
    background-color: transparent;
    text-color: #c0caf5;
    font: "JetBrains Mono 12";
    
    violet: #8A2BE2;
    cyan: #00FFFF;
    deep-blue: #0066CC;
    hot-pink: #FF69B4;
    dark-bg: #1a1b26;
    light-bg: #24283b;
    text: #c0caf5;
}

window {
    background: linear-gradient(135deg, @violet 0%, @deep-blue 50%, @cyan 100%);
    border-radius: 15px;
    border: 2px solid @cyan;
    padding: 20px;
    width: 600px;
}

mainbox {
    background-color: transparent;
}

inputbar {
    background: rgba(26, 27, 38, 0.8);
    border-radius: 10px;
    padding: 10px;
    margin: 0 0 10px 0;
    border: 1px solid @cyan;
}

entry {
    placeholder: "Search WehttamSnaps...";
    placeholder-color: rgba(192, 202, 245, 0.5);
    background-color: transparent;
}

listview {
    background-color: transparent;
    lines: 8;
    scrollbar: true;
}

element {
    padding: 8px;
    margin: 2px;
    border-radius: 8px;
    background-color: transparent;
}

element selected {
    background: linear-gradient(45deg, @violet, @cyan);
    text-color: #ffffff;
}

element-icon {
    size: 24px;
    margin: 0 8px 0 0;
}

element-text {
    font-weight: bold;
}

scrollbar {
    handle-color: @cyan;
    handle-width: 4px;
    background-color: rgba(26, 27, 38, 0.3);
    border-radius: 2px;
}
EOF

# Create Eww configuration and widgets
echo -e "${GREEN}Creating Eww widgets...${NC}"
mkdir -p ~/.config/eww/{scripts,scss}

cat > ~/.config/eww/eww.yuck << 'EOF'
; WehttamSnaps Eww Configuration

; Game Launcher Widget
(defwidget game-launcher []
  (box :class "game-launcher" :orientation "v" :space-evenly false
    (box :class "header"
      (label :text "🎮 WehttamSnaps Gaming")
    )
    (box :class "games" :orientation "v"
      (button :class "game-btn" :onclick "steam" "Steam")
      (button :class "game-btn" :onclick "lutris" "Lutris")
      (button :class "game-btn" :onclick "heroic" "Heroic Games")
      (button :class "game-btn" :onclick "obs" "OBS Studio")
      (button :class "game-btn" :onclick "discord" "Discord")
    )
  )
)

; Work Launcher Widget
(defwidget work-launcher []
  (box :class "work-launcher" :orientation "v" :space-evenly false
    (box :class "header"
      (label :text "💼 Creative Suite")
    )
    (box :class "apps" :orientation "v"
      (button :class "work-btn" :onclick "gimp" "GIMP")
      (button :class "work-btn" :onclick "inkscape" "Inkscape")
      (button :class "work-btn" :onclick "krita" "Krita")
      (button :class "work-btn" :onclick "thunar" "File Manager")
      (button :class "work-btn" :onclick "firefox" "Firefox")
    )
  )
)

; Power Menu Widget
(defwidget power-menu []
  (box :class "power-menu" :orientation "v" :space-evenly false
    (box :class "header"
      (label :text "⚡ WehttamSnaps Power")
    )
    (box :class "power-options" :orientation "v"
      (button :class "power-btn shutdown" :onclick "systemctl poweroff" "🔌 Shutdown")
      (button :class "power-btn reboot" :onclick "systemctl reboot" "🔄 Reboot")
      (button :class "power-btn suspend" :onclick "systemctl suspend" "💤 Sleep")
      (button :class "power-btn lock" :onclick "swaylock" "🔒 Lock")
      (button :class "power-btn logout" :onclick "swaymsg exit" "🚪 Logout")
    )
  )
)

; System Info Widget
(defwidget system-info []
  (box :class "system-info" :orientation "v"
    (box :class "header"
      (label :text "💻 WehttamSnaps System")
    )
    (box :class "info" :orientation "v"
      (label :text "CPU: Intel i5-4430")
      (label :text "GPU: AMD RX 580")
      (label :text "RAM: 16GB")
      (label :text "OS: Arch Linux")
    )
  )
)

; Windows
(defwindow game-launcher
  :monitor 0
  :geometry (geometry :x "20px" :y "50px" :width "200px" :height "300px")
  :stacking "overlay"
  :windowtype "dock"
  (game-launcher)
)

(defwindow work-launcher
  :monitor 0
  :geometry (geometry :x "240px" :y "50px" :width "200px" :height "300px")
  :stacking "overlay"
  :windowtype "dock"
  (work-launcher)
)

(defwindow power-menu
  :monitor 0
  :geometry (geometry :x "50%" :y "50%" :width "300px" :height "350px" :anchor "center center")
  :stacking "overlay"
  :windowtype "dock"
  (power-menu)
)

(defwindow system-info
  :monitor 0
  :geometry (geometry :x "20px" :y "20px" :width "250px" :height "200px")
  :stacking "fg"
  :windowtype "dock"
  (system-info)
)
EOF

cat > ~/.config/eww/eww.scss << 'EOF'
/* WehttamSnaps Eww Styles */
$violet: #8A2BE2;
$cyan: #00FFFF;
$deep-blue: #0066CC;
$hot-pink: #FF69B4;
$dark-bg: #1a1b26;
$light-bg: #24283b;
$text: #c0caf5;

* {
  font-family: "JetBrains Mono", monospace;
  font-weight: bold;
}

.game-launcher,
.work-launcher,
.power-menu,
.system-info {
  background: linear-gradient(135deg, rgba($violet, 0.9), rgba($cyan, 0.9));
  border-radius: 15px;
  border: 2px solid $cyan;
  padding: 15px;
  backdrop-filter: blur(10px);
}

.header {
  margin-bottom: 10px;
  padding-bottom: 8px;
  border-bottom: 2px solid rgba($cyan, 0.5);
  
  label {
    font-size: 16px;
    color: white;
    font-weight: bold;
  }
}

.game-btn,
.work-btn,
.power-btn {
  margin: 5px 0;
  padding: 10px 15px;
  border-radius: 8px;
  background: rgba($dark-bg, 0.8);
  border: 1px solid rgba($cyan, 0.3);
  color: $text;
  font-size: 14px;
  transition: all 0.3s ease;
  
  &:hover {
    background: linear-gradient(45deg, $violet, $deep-blue);
    border-color: $cyan;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba($cyan, 0.3);
  }
}

.power-btn {
  &.shutdown:hover { background: linear-gradient(45deg, #ff4757, #ff3838); }
  &.reboot:hover { background: linear-gradient(45deg, #ffa502, #ff6348); }
  &.suspend:hover { background: linear-gradient(45deg, $deep-blue, $violet); }
  &.lock:hover { background: linear-gradient(45deg, #747d8c, #57606f); }
  &.logout:hover { background: linear-gradient(45deg, $hot-pink, $violet); }
}

.info {
  label {
    margin: 3px 0;
    color: $text;
    font-size: 12px;
  }
}
EOF

# Create Eww scripts
mkdir -p ~/.config/eww/scripts

cat > ~/.config/eww/scripts/toggle-game-launcher.sh << 'EOF'
#!/bin/bash
if eww active-windows | grep -q "game-launcher"; then
    eww close game-launcher
else
    eww open game-launcher
fi
EOF

cat > ~/.config/eww/scripts/toggle-work-launcher.sh << 'EOF'
#!/bin/bash
if eww active-windows | grep -q "work-launcher"; then
    eww close work-launcher
else
    eww open work-launcher
fi
EOF

cat > ~/.config/eww/scripts/toggle-power-menu.sh << 'EOF'
#!/bin/bash
if eww active-windows | grep -q "power-menu"; then
    eww close power-menu
else
    eww open power-menu
fi
EOF

cat > ~/.config/eww/scripts/launch-widgets.sh << 'EOF'
#!/bin/bash
eww daemon &
sleep 2
eww open system-info
EOF

chmod +x ~/.config/eww/scripts/*.sh

# Create Alacritty config
echo -e "${GREEN}Creating Alacritty configuration...${NC}"
cat > ~/.config/alacritty/alacritty.yml << 'EOF'
# WehttamSnaps Alacritty Configuration
window:
  opacity: 0.9
  blur: true
  decorations: none
  startup_mode: Windowed
  dynamic_title: true

font:
  normal:
    family: "JetBrains Mono"
    style: Regular
  bold:
    family: "JetBrains Mono"
    style: Bold
  italic:
    family: "JetBrains Mono"
    style: Italic
  size: 12.0

colors:
  primary:
    background: '#1a1b26'
    foreground: '#c0caf5'
    
  normal:
    black:   '#15161E'
    red:     '#f7768e'
    green:   '#9ece6a'
    yellow:  '#e0af68'
    blue:    '#7aa2f7'
    magenta: '#8A2BE2'
    cyan:    '#00FFFF'
    white:   '#c0caf5'
    
  bright:
    black:   '#414868'
    red:     '#f7768e'
    green:   '#9ece6a'
    yellow:  '#e0af68'
    blue:    '#7aa2f7'
    magenta: '#bb9af7'
    cyan:    '#7dcfff'
    white:   '#c0caf5'

cursor:
  style: Block
  unfocused_hollow: true

key_bindings:
  - { key: Return, mods: Control|Shift, action: SpawnNewInstance }
EOF

# Create Starship config
echo -e "${GREEN}Creating Starship configuration...${NC}"
cat > ~/.config/starship.toml << 'EOF'
# WehttamSnaps Starship Configuration

format = """
[░▒▓](#8A2BE2)\
$username\
[](bg:#0066CC fg:#8A2BE2)\
$directory\
[](fg:#0066CC bg:#00FFFF)\
$git_branch\
$git_status\
[](fg:#00FFFF bg:#FF69B4)\
$nodejs\
$rust\
$golang\
$php\
[](fg:#FF69B4)\
$line_break$character"""

[username]
show_always = true
style_user = "bg:#8A2BE2 fg:#ffffff"
style_root = "bg:#8A2BE2 fg:#ffffff"
format = '[ $user ]($style)'

[directory]
style = "fg:#ffffff bg:#0066CC"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
symbol = ""
style = "bg:#00FFFF fg:#000000"
format = '[ $symbol $branch ]($style)'

[git_status]
style = "bg:#00FFFF fg:#000000"
format = '[$all_status$ahead_behind ]($style)'

[nodejs]
symbol = ""
style = "bg:#FF69B4 fg:#ffffff"
format = '[ $symbol ($version) ]($style)'

[character]
success_symbol = '[WS❯](bold #00FFFF)'
error_symbol = '[WS❯](bold #f7768e)'
EOF

# Create gaming optimization scripts
echo -e "${GREEN}Creating gaming optimization scripts...${NC}"
mkdir -p ~/WehttamSnaps/Scripts

cat > ~/WehttamSnaps/Scripts/gaming-setup.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Gaming Setup

# AMD GPU optimizations
export RADV_PERFTEST=aco
export MESA_LOADER_DRIVER_OVERRIDE=radv
export AMD_VULKAN_ICD=RADV

# Gaming optimizations
export WINE_CPU_TOPOLOGY=4:2
export DXVK_HUD=fps,memory,gpuload,version
export MANGOHUD=1
export ENABLE_VKBASALT=1

# Enable GameMode
gamemoded -d

echo "Gaming optimizations enabled!"
echo "Use 'gamemode %command%' for Steam games"
EOF

cat > ~/WehttamSnaps/Scripts/streaming-setup.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Streaming Setup

# Load v4l2loopback for virtual camera
sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Cam" exclusive_caps=1

# Start OBS with optimal settings
obs --scene "WehttamSnaps Default" --minimize-to-tray &

# Start Discord in streaming mode
discord --enable-features=VaapiVideoDecoder,WebRTCPipeWireCapturer &

echo "Streaming setup complete!"
echo "Virtual camera available at /dev/video10"
EOF

chmod +x ~/WehttamSnaps/Scripts/*.sh

# Create brand assets directory and placeholder files
echo -e "${GREEN}Creating brand asset placeholders...${NC}"
cat > ~/WehttamSnaps/Brand/logo-creation.md << 'EOF'
# WehttamSnaps Logo Creation Guide

## Logo Concept
- "WS" monogram design
- Camera shutter integrated into the "W"
- Gaming controller outline in the "S"
- Violet to Cyan gradient (#8A2BE2 to #00FFFF)

## Logo Variations Needed
1. Full logo with "WehttamSnaps" text
2. Icon-only "WS" monogram
3. Horizontal layout for headers
4. Square format for avatars
5. Transparent PNG versions

## Taglines
- "Capturing Gaming Moments"
- "Photography Meets Gaming"
- "Snap. Stream. Share."

## Usage Guidelines
- Minimum size: 32px for icon
- Clear space: 1/2 logo height on all sides
- Backgrounds: Works on dark and light
- File formats: SVG (vector), PNG (raster)
EOF

# Create streaming overlay templates
mkdir -p ~/WehttamSnaps/Overlays/{Starting-Soon,BRB,Ending,Webcam}

cat > ~/WehttamSnaps/Overlays/obs-scenes.md << 'EOF'
# WehttamSnaps OBS Scene Templates

## Scene 1: Starting Soon
- Background: Violet-to-cyan animated gradient
- Logo: WS monogram (center)
- Text: "Starting Soon" with countdown timer
- Social media handles
- Stream schedule display

## Scene 2: Gaming (Main)
- Game capture (full screen)
- Webcam frame (bottom right, 320x240)
- Chat box (left side)
- Alert notifications area
- Recent followers/subs ticker

## Scene 3: Just Chatting
- Webcam (center, larger)
- Background: Subtle WS pattern
- Chat box (prominent)
- "Ask Me Anything" overlay

## Scene 4: Be Right Back
- Animated background
- "BRB" text with timer
- Music visualizer
- Social media promotion

## Scene 5: Ending
- Thank you message
- Stream highlights
- Next stream info
- Follow/subscribe reminders

## Overlay Elements
- Webcam border: Violet-to-cyan gradient frame
- Alert boxes: Matching theme colors
- Progress bars: Photography-inspired designs
- Text: JetBrains Mono font family
EOF

# Create wallpaper download script
cat > ~/WehttamSnaps/Scripts/setup-wallpapers.sh << 'EOF'
#!/bin/bash
# Download and setup WehttamSnaps wallpapers

WALLPAPER_DIR="$HOME/WehttamSnaps/Wallpapers"
mkdir -p "$WALLPAPER_DIR"

echo "Setting up WehttamSnaps wallpapers..."

# Create a custom gradient wallpaper using ImageMagick if available
if command -v convert &> /dev/null; then
    convert -size 1920x1080 gradient:'#8A2BE2-#00FFFF' \
            -swirl 30 -wave 20x80 \
            "$WALLPAPER_DIR/wehttamsnaps-gradient.jpg"
    
    # Create a subtle pattern overlay
    convert "$WALLPAPER_DIR/wehttamsnaps-gradient.jpg" \
            \( +clone -blur 0x3 \) -compose multiply -composite \
            "$WALLPAPER_DIR/wehttamsnaps-main.jpg"
    
    ln -sf "$WALLPAPER_DIR/wehttamsnaps-main.jpg" "$WALLPAPER_DIR/current.jpg"
else
    # Fallback: create a solid color wallpaper
    echo "ImageMagick not found, creating solid color wallpaper"
    convert -size 1920x1080 xc:'#8A2BE2' "$WALLPAPER_DIR/current.jpg" 2>/dev/null || {
        # Create a simple text file if convert fails
        echo "# Place your wallpaper files here" > "$WALLPAPER_DIR/README.md"
        echo "# Name your main wallpaper 'current.jpg'" >> "$WALLPAPER_DIR/README.md"
    }
fi

echo "Wallpapers setup complete!"
EOF

chmod +x ~/WehttamSnaps/Scripts/setup-wallpapers.sh

# Create OBS configuration template
cat > ~/WehttamSnaps/Configs/obs-settings.md << 'EOF'
# WehttamSnaps OBS Studio Configuration

## Video Settings
- Base Resolution: 1920x1080
- Output Resolution: 1280x720 (for better performance on RX 580)
- Downscale Filter: Lanczos (32 samples)
- FPS: 30 (60 for competitive gaming)

## Output Settings (Streaming)
- Encoder: Hardware (AMD AMF H.264)
- Rate Control: CBR
- Bitrate: 3000-4500 Kbps (adjust based on upload speed)
- Keyframe Interval: 2
- Preset: Quality
- Profile: High

## Output Settings (Recording)
- Type: Standard
- Recording Format: mp4
- Encoder: Same as streaming
- Rate Control: CQP
- CQ Level: 20

## Audio Settings
- Sample Rate: 48kHz
- Channels: Stereo
- Desktop Audio: PipeWire/PulseAudio
- Mic: Your USB microphone
- Filters: Noise Suppression, Gain, Compressor

## Advanced Settings
- Color Format: NV12
- Color Space: 709
- Color Range: Partial
- Process Priority: High
- Renderer: OpenGL

## Scene Collection: WehttamSnaps
Export and import this scene collection for consistent branding.
EOF

# Create SteamTinkerLaunch configuration
cat > ~/WehttamSnaps/Scripts/setup-modding.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Game Modding Setup

echo "Setting up SteamTinkerLaunch for game modding..."

# Create STL config directory
mkdir -p ~/.config/steamtinkerlaunch

# Install required dependencies for modding
echo "Installing modding tools..."
yay -S --needed --noconfirm \
    vortex-mod-manager-bin \
    mod-organizer-2-linux-installer \
    winetricks \
    protontricks

# Setup wine prefixes for modding
echo "Creating wine prefixes..."
mkdir -p ~/Games/WinePrefixes

# Fallout 4 modding setup
WINEPREFIX=~/Games/WinePrefixes/Fallout4 winecfg

# Cyberpunk 2077 modding setup  
WINEPREFIX=~/Games/WinePrefixes/Cyberpunk winecfg

# Create modding launch script
cat > ~/WehttamSnaps/Scripts/launch-with-mods.sh << 'EOL'
#!/bin/bash
# Launch games with mod support

GAME="$1"
case "$GAME" in
    "fallout4")
        echo "Launching Fallout 4 with mod support..."
        WINEPREFIX=~/Games/WinePrefixes/Fallout4 steamtinkerlaunch
        ;;
    "cyberpunk")
        echo "Launching Cyberpunk 2077 with mod support..."
        WINEPREFIX=~/Games/WinePrefixes/Cyberpunk steamtinkerlaunch
        ;;
    *)
        echo "Usage: $0 [fallout4|cyberpunk]"
        ;;
esac
EOL

chmod +x ~/WehttamSnaps/Scripts/launch-with-mods.sh

echo "Modding setup complete!"
echo "Configure each game's mods through SteamTinkerLaunch interface"
EOF

chmod +x ~/WehttamSnaps/Scripts/setup-modding.sh

# Create welcome app script
cat > ~/WehttamSnaps/Scripts/welcome-app.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Welcome App

# Check if zenity is available for GUI
if ! command -v zenity &> /dev/null; then
    echo "Installing zenity for GUI..."
    sudo pacman -S --noconfirm zenity
fi

# Function to show keybindings
show_keybindings() {
    zenity --info --width=500 --height=400 --title="WehttamSnaps Keybindings" --text="
🎮 WEHTTAMSNAPS KEYBINDINGS 🎮

BASIC CONTROLS:
• Super + Return: Terminal
• Super + D: App Launcher
• Super + Q: Kill Window
• Super + F: Fullscreen

CUSTOM SHORTCUTS:
• Super + W: Game Launcher
• Super + S: Work Apps
• Super + P: Power Menu
• Super + G: Toggle GameMode
• Super + Shift + G: MangoHUD

STREAMING:
• Print: Screenshot
• Shift + Print: Area Screenshot

GAMING:
• Super + 1-5: Gaming Workspaces
• Super + 6-10: Work/Stream Workspaces

WINDOW MANAGEMENT:
• Super + H/J/K/L: Move Focus
• Super + Shift + H/J/K/L: Move Window
• Super + Space: Toggle Floating
"
}

# Function to open settings
open_settings() {
    choice=$(zenity --list --radiolist --width=400 --height=300 \
        --title="WehttamSnaps Settings" \
        --text="Select a configuration to edit:" \
        --column="Select" --column="Setting" \
        TRUE "Sway Config" \
        FALSE "Waybar Config" \
        FALSE "Rofi Theme" \
        FALSE "Eww Widgets" \
        FALSE "Alacritty Terminal" \
        FALSE "Gaming Scripts")
    
    case "$choice" in
        "Sway Config")
            $EDITOR ~/.config/sway/config
            ;;
        "Waybar Config")
            $EDITOR ~/.config/waybar/config
            ;;
        "Rofi Theme")
            $EDITOR ~/.config/rofi/wehttamsnaps.rasi
            ;;
        "Eww Widgets")
            $EDITOR ~/.config/eww/eww.yuck
            ;;
        "Alacritty Terminal")
            $EDITOR ~/.config/alacritty/alacritty.yml
            ;;
        "Gaming Scripts")
            thunar ~/WehttamSnaps/Scripts/
            ;;
    esac
}

# Function to check system status
system_status() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//')
    MEM_USAGE=$(free | grep Mem | awk '{printf("%.0f", $3/$2 * 100.0)}')
    GPU_TEMP=$(sensors 2>/dev/null | grep -i temp1 | head -1 | awk '{print $2}' | sed 's/+//;s/°C//')
    
    zenity --info --width=400 --height=200 --title="System Status" --text="
🖥️ SYSTEM STATUS 🖥️

CPU Usage: ${CPU_USAGE:-N/A}%
Memory Usage: ${MEM_USAGE:-N/A}%
GPU Temperature: ${GPU_TEMP:-N/A}°C

PC Specs:
• Intel i5-4430
• AMD RX 580 8GB
• 16GB RAM
• Arch Linux + swayfx
"
}

# Function to start streaming setup
streaming_setup() {
    if zenity --question --width=300 --text="Start streaming setup?\n\nThis will:\n• Load virtual camera\n• Open OBS Studio\n• Launch Discord"; then
        ~/WehttamSnaps/Scripts/streaming-setup.sh
        zenity --info --text="Streaming setup complete!\nOBS and Discord are starting..."
    fi
}

# Main menu
while true; do
    choice=$(zenity --list --width=400 --height=350 \
        --title="🎮 WehttamSnaps Control Center 🎮" \
        --text="Welcome Matt! Choose an option:" \
        --column="Action" \
        "📋 View Keybindings" \
        "⚙️ Open Settings" \
        "📊 System Status" \
        "🎥 Streaming Setup" \
        "🎮 Gaming Mode" \
        "💼 Work Mode" \
        "🌟 Update System" \
        "❌ Exit")
    
    case "$choice" in
        "📋 View Keybindings")
            show_keybindings
            ;;
        "⚙️ Open Settings")
            open_settings
            ;;
        "📊 System Status")
            system_status
            ;;
        "🎥 Streaming Setup")
            streaming_setup
            ;;
        "🎮 Gaming Mode")
            ~/WehttamSnaps/Scripts/gaming-setup.sh
            zenity --info --text="Gaming optimizations enabled!"
            ;;
        "💼 Work Mode")
            killall gamemode 2>/dev/null
            gimp & inkscape & thunar &
            zenity --info --text="Work applications launched!"
            ;;
        "🌟 Update System")
            alacritty -e bash -c "yay -Syu && echo 'Update complete! Press enter to close...' && read"
            ;;
        "❌ Exit"|"")
            break
            ;;
    esac
done
EOF

chmod +x ~/WehttamSnaps/Scripts/welcome-app.sh

# Create desktop entry for welcome app
cat > ~/.local/share/applications/wehttamsnaps-welcome.desktop << 'EOF'
[Desktop Entry]
Name=WehttamSnaps Control Center
Comment=Control center for WehttamSnaps streaming setup
Exec=/home/$USER/WehttamSnaps/Scripts/welcome-app.sh
Icon=preferences-system
Terminal=false
Type=Application
Categories=System;Settings;
EOF

# Setup zsh with oh-my-zsh
echo -e "${GREEN}Setting up Zsh configuration...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

cat > ~/.zshrc << 'EOF'
# WehttamSnaps Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    archlinux
    systemd
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nano'
export PATH="$HOME/WehttamSnaps/Scripts:$PATH"

# Gaming aliases
alias gaming='~/WehttamSnaps/Scripts/gaming-setup.sh'
alias streaming='~/WehttamSnaps/Scripts/streaming-setup.sh'
alias ws-welcome='~/WehttamSnaps/Scripts/welcome-app.sh'

# System aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'

# Git aliases
alias gst='git status'
alias gaa='git add .'
alias gcm='git commit -m'
alias gp='git push'

# Package management
alias pacman='sudo pacman'
alias pacu='sudo pacman -Syu'
alias paci='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacs='pacman -Ss'

# Initialize Starship prompt
eval "$(starship init zsh)"

# Welcome message
echo -e "\n🎮 Welcome to WehttamSnaps Setup! 🎮"
echo -e "Run 'ws-welcome' to open the control center\n"
EOF

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || true

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

# Create autostart script
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/wehttamsnaps-startup.desktop << 'EOF'
[Desktop Entry]
Name=WehttamSnaps Startup
Comment=WehttamSnaps startup script
Exec=/home/$USER/WehttamSnaps/Scripts/startup.sh
Icon=applications-games
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true
EOF

cat > ~/WehttamSnaps/Scripts/startup.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Startup Script

# Wait for desktop to load
sleep 5

# Setup wallpapers
~/WehttamSnaps/Scripts/setup-wallpapers.sh

# Show welcome message
notify-send "🎮 WehttamSnaps" "Setup complete! Welcome Matt!" --icon=applications-games

# Open control center on first login
if [ ! -f ~/.config/wehttamsnaps-welcomed ]; then
    sleep 3
    ~/WehttamSnaps/Scripts/welcome-app.sh &
    touch ~/.config/wehttamsnaps-welcomed
fi
EOF

chmod +x ~/WehttamSnaps/Scripts/startup.sh

# Create brand guidelines document
cat > ~/WehttamSnaps/Brand/brand-guidelines.md << 'EOF'
# WehttamSnaps Brand Guidelines

## Brand Identity
**Name:** WehttamSnaps  
**Real Name:** Matt  
**Tagline:** "Capturing Gaming Moments"

## Color Palette
- **Primary Gradient:** Violet to Cyan (#8A2BE2 → #00FFFF)
- **Secondary Colors:**
  - Deep Blue: #0066CC
  - Hot Pink: #FF69B4
- **Neutral Colors:**
  - Dark Background: #1a1b26
  - Light Background: #24283b
  - Text: #c0caf5

## Typography
- **Primary Font:** JetBrains Mono (monospace)
- **Headings:** Bold weight
- **Body Text:** Regular weight
- **Size Range:** 12px-24px

## Logo Usage
- **WS Monogram:** Camera shutter in W, controller in S
- **Minimum Size:** 32px
- **Clear Space:** 1/2 logo height on all sides
- **Backgrounds:** Works on dark and light surfaces

## Applications
- **Streaming Overlays:** Violet-to-cyan gradients
- **Social Media:** Consistent WS branding
- **Desktop Theme:** Matching color scheme
- **Gaming Setup:** Branded wallpapers and widgets

## Voice & Tone
- **Personality:** Tech-savvy, creative, approachable
- **Style:** Professional but fun
- **Audience:** Gamers and photography enthusiasts
EOF

# Create social media templates
mkdir -p ~/WehttamSnaps/Brand/Social-Templates

cat > ~/WehttamSnaps/Brand/Social-Templates/stream-announcements.md << 'EOF'
# Stream Announcement Templates

## Going Live Templates

### The Division Series (Monday)
"🎮 Going LIVE with The Division 2! 
Time to reclaim Washington DC! 

🔴 Live now: twitch.tv/WehttamSnaps
💜 Drop by and say hi!
#TheDivision2 #Gaming #Streaming"

### Cyberpunk Night (Wednesday)  
"⚡ NIGHT CITY AWAITS ⚡
Cyberpunk 2077 stream starting NOW!

🎮 Twitch: twitch.tv/WehttamSnaps
🌟 Let's explore Night City together!
#Cyberpunk2077 #Gaming #Streaming"

### The First Descendant Friday
"🚀 FRIDAY NIGHT GAMING! 
The First Descendant co-op action!

🔴 LIVE: twitch.tv/WehttamSnaps
💫 Join the descendant squad!
#TheFirstDescendant #Gaming"

### Photography Q&A Saturday
"📸 PHOTOGRAPHY & GAMING CHAT 📸
Just chatting stream today!

Ask me anything about:
• Wedding photography
• Gaming setups
• Stream tech

🔴 LIVE: twitch.tv/WehttamSnaps"

### Linux Gaming Sunday
"🐧 LINUX GAMING SUNDAY! 🐧
Exploring games on Arch Linux!

🎮 Tonight's adventure TBD
💻 Stream setup tour included
🔴 LIVE: twitch.tv/WehttamSnaps"

## Post-Stream Templates

### Thank You Post
"Thanks everyone who stopped by tonight's stream! 💜

🎮 Highlights coming to YouTube
📸 Behind-the-scenes on Instagram  
💬 Join our Discord community

See you next time! 
#WehttamSnaps #StreamFamily"

### Milestone Posts
"🎉 WE HIT [X] FOLLOWERS! 🎉

Thank you all for supporting WehttamSnaps!
Your support means the world to me 💜

What game should we celebrate with?
Drop suggestions below! ⬇️"
EOF

# Run setup wallpapers
~/WehttamSnaps/Scripts/setup-wallpapers.sh

# Final setup steps
echo -e "${GREEN}Compiling Eww configuration...${NC}"
eww kill 2>/dev/null || true
cd ~/.config/eww && eww daemon &
sleep 2 && eww reload

echo -e "${GREEN}Reloading sway configuration...${NC}"
swaymsg reload 2>/dev/null || true

# Create completion message
echo -e "${VIOLET}╔══════════════════════════════════════╗${NC}"
echo -e "${VIOLET}║     WEHTTAMSNAPS SETUP COMPLETE!     ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════╝${NC}"
echo -e ""
echo -e "${GREEN}✅ swayfx with violet-to-cyan theme configured${NC}"
echo -e "${GREEN}✅ Waybar with custom WehttamSnaps styling${NC}"
echo -e "${GREEN}✅ Eww widgets (game/work launchers, power menu)${NC}"
echo -e "${GREEN}✅ Gaming optimizations for AMD RX 580${NC}"
echo -e "${GREEN}✅ Streaming tools and OBS configuration${NC}"
echo -e "${GREEN}✅ Brand guidelines and templates created${NC}"
echo -e "${GREEN}✅ Welcome app and control center ready${NC}"
echo -e ""
echo -e "${CYAN}🚀 NEXT STEPS:${NC}"
echo -e "1. Logout and log back in to apply all changes"
echo -e "2. Run ${VIOLET}'ws-welcome'${NC} to open the control center"
echo -e "3. Customize your wallpaper in ~/WehttamSnaps/Wallpapers/"
echo -e "4. Create your WS logo using the brand guidelines"
echo -e "5. Set up OBS scenes using the provided templates"
echo -e ""
echo -e "${HOT_PINK}🎮 Happy streaming, Matt! 🎮${NC}"
echo -e "${CYAN}Follow: @WehttamSnaps everywhere!${NC}"

# Save installation log
echo "WehttamSnaps setup completed on $(date)" > ~/WehttamSnaps/install.log
echo "System: $(uname -a)" >> ~/WehttamSnaps/install.log
echo "User: $(whoami)" >> ~/WehttamSnaps/install.log
