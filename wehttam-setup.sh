#!/bin/bash

# WehttamSnaps Hyprland Complete Setup Script
# Gaming-focused Hyprland setup with TokyoNight violet-to-cyan theme
# Created for WehttamSnaps streaming setup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logo display
echo -e "${PURPLE}"
cat << "EOF"
 __      __     _   _   _                      _____                      
 \ \    / /__  | | | | | |                    /  ___|                     
  \ \  / / _ \ | |_| |_| |_ __ ___  _ __   __ _\ `--.  _ __   __ _ _ __  ___ 
   \ \/ / (_) ||  _|  _|  _/ _' _ \| '_ \ / _' |`--. \| '_ \ / _' | '_ \/ __|
    \  / \___/ | | | | | || (_| |_| | |_) | (_| /\__/ /| |_) | (_| | |_) \__ \
     \/         |_| |_| |_| \__,_| | .__/ \__,_\____/ | .__/ \__,_| .__/|___/
                                  | |                | |         | |        
                                  |_|                |_|         |_|        
                      Gaming Setup - Photography Life - Linux Adventures
EOF
echo -e "${NC}"

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Create directory structure
print_status "Setting up WehttamSnaps directory structure..."
mkdir -p ~/.config/{hypr,waybar,rofi,dunst,kitty,eww,sddm,gtk-3.0}
mkdir -p ~/WehttamSnaps/{configs,themes,wallpapers,scripts,streaming}
mkdir -p ~/.local/share/fonts

# Check if running Arch Linux
if ! command -v pacman &> /dev/null; then
    print_error "This script is designed for Arch Linux. Please adapt for your distribution."
    exit 1
fi

# Update system
print_status "Updating system packages..."
sudo pacman -Syu --noconfirm

# Install essential packages
print_status "Installing Hyprland and essential packages..."
sudo pacman -S --needed --noconfirm \
    hyprland waybar rofi-wayland dunst \
    kitty thunar grim slurp wl-clipboard \
    pipewire pipewire-pulse pavucontrol \
    nwg-look nwg-drawer azote \
    sddm qt6-svg qt6-declarative \
    btop htop neofetch fastfetch \
    zsh starship git curl wget \
    gamemode lib32-gamemode lutris steam \
    obs-studio v4l2loopback-dkms \
    gimp inkscape blender \
    discord firefox code

# Install AUR helper (yay) if not present
if ! command -v yay &> /dev/null; then
    print_status "Installing yay AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# Install AUR packages
print_status "Installing AUR packages for enhanced functionality..."
yay -S --needed --noconfirm \
    eww \
    sddm-sugar-candy-git \
    swaylock-effects \
    wlogout \
    swww \
    hyprpicker \
    hypridle \
    hyprlock \
    waybar-hyprland \
    nwg-panel

# Install gaming optimizations
print_status "Installing gaming optimizations..."
sudo pacman -S --needed --noconfirm \
    vulkan-radeon lib32-vulkan-radeon \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    mesa lib32-mesa \
    mangohud lib32-mangohud goverlay \
    gamescope

# Configure zram
print_status "Setting up zram for better performance..."
sudo pacman -S --needed --noconfirm zram-generator
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF

# Create Hyprland config
print_status "Creating WehttamSnaps Hyprland configuration..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# WehttamSnaps Gaming Hyprland Config
# Optimized for streaming and gaming

# Monitor configuration (adjust for your setup)
monitor = ,preferred,auto,1

# Source external configs
source = ~/.config/hypr/colors.conf
source = ~/.config/hypr/keybinds.conf
source = ~/.config/hypr/rules.conf

# Startup applications
exec-once = waybar
exec-once = dunst
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = swww init
exec-once = swww img ~/WehttamSnaps/wallpapers/ws-gaming-wall.jpg
exec-once = hypridle
exec-once = steam -silent
exec-once = discord --start-minimized

# Gaming optimizations
exec-once = echo 'WehttamSnaps Gaming Session Started'

# Input configuration
input {
    kb_layout = us
    follow_mouse = 1
    sensitivity = 0.5 # Gaming sensitivity
    
    touchpad {
        natural_scroll = false
    }
}

# General settings
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(8B5CF6ee) rgba(06B6D4ee) 45deg
    col.inactive_border = rgba(313244aa)
    layout = dwindle
    allow_tearing = true # For gaming
}

# Decoration
decoration {
    rounding = 8
    
    blur {
        enabled = true
        size = 8
        passes = 3
        new_optimizations = true
    }
    
    drop_shadow = true
    shadow_range = 15
    shadow_render_power = 3
    col.shadow = rgba(8B5CF6aa)
}

# Animations optimized for gaming
animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    
    animation = windows, 1, 4, myBezier
    animation = windowsOut, 1, 4, default, popin 80%
    animation = border, 1, 8, default
    animation = borderangle, 1, 6, default
    animation = fade, 1, 4, default
    animation = workspaces, 1, 4, default
}

# Layout
dwindle {
    pseudotile = true
    preserve_split = true
}

# Gestures
gestures {
    workspace_swipe = true
}

# Gaming-specific device config
device:epic-mouse-v1 {
    sensitivity = -0.5
}

# Gaming window rules
windowrulev2 = immediate,class:^(cs2)$
windowrulev2 = immediate,class:^(steam_app_.*)$
windowrulev2 = immediate,class:^(lutris)$
windowrulev2 = fullscreen,class:^(cs2)$
windowrulev2 = workspace 2,class:^(steam)$
windowrulev2 = workspace 3,class:^(discord)$
windowrulev2 = workspace 4,class:^(obs)$
EOF

# Create color scheme
print_status "Setting up WehttamSnaps color scheme..."
cat > ~/.config/hypr/colors.conf << 'EOF'
# WehttamSnaps TokyoNight Violet-to-Cyan Colors
$background = 0x1a1b26
$foreground = 0xc0caf5
$color0 = 0x15161e
$color1 = 0xf7768e
$color2 = 0x9ece6a
$color3 = 0xe0af68
$color4 = 0x7aa2f7
$color5 = 0xbb9af7
$color6 = 0x7dcfff
$color7 = 0xa9b1d6
$color8 = 0x414868
$color9 = 0xf7768e
$color10 = 0x9ece6a
$color11 = 0xe0af68
$color12 = 0x7aa2f7
$color13 = 0xbb9af7
$color14 = 0x7dcfff
$color15 = 0xc0caf5

# Gaming accent colors
$ws_violet = 0x8B5CF6
$ws_cyan = 0x06B6D4
$ws_blue = 0x3B82F6
$ws_pink = 0xEC4899
EOF

# Create keybinds
print_status "Setting up gaming-optimized keybinds..."
cat > ~/.config/hypr/keybinds.conf << 'EOF'
# WehttamSnaps Gaming Keybinds

$mainMod = SUPER
$terminal = kitty
$fileManager = thunar
$menu = rofi -show drun

# Application shortcuts
bind = $mainMod, RETURN, exec, $terminal
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, $menu
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

# Gaming shortcuts
bind = $mainMod, G, exec, steam
bind = $mainMod, D, exec, discord
bind = $mainMod, O, exec, obs
bind = $mainMod SHIFT, G, exec, gamemode-toggle
bind = $mainMod, F12, exec, grim -g "$(slurp)" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png

# Streaming shortcuts
bind = $mainMod, F9, exec, obs --start-recording
bind = $mainMod, F10, exec, obs --stop-recording
bind = $mainMod, F11, exec, obs --start-streaming
bind = $mainMod SHIFT, F11, exec, obs --stop-streaming

# System shortcuts
bind = $mainMod, L, exec, swaylock
bind = $mainMod SHIFT, L, exec, wlogout
bind = $mainMod, N, exec, dunstctl set-paused toggle
bind = $mainMod SHIFT, N, exec, dunstctl history-pop

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

# Mouse bindings
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Volume and brightness
binde = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
binde = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous
EOF

# Create window rules
cat > ~/.config/hypr/rules.conf << 'EOF'
# WehttamSnaps Window Rules for Gaming and Streaming

# Gaming rules
windowrulev2 = immediate, class:^(steam_app_).*
windowrulev2 = immediate, class:^(cs2)$
windowrulev2 = immediate, class:^(cyberpunk2077)$
windowrulev2 = immediate, class:^(lutris)$

# Streaming rules
windowrulev2 = workspace 4, class:^(obs)$
windowrulev2 = workspace 3, class:^(discord)$
windowrulev2 = workspace 5, class:^(firefox)$

# Floating rules
windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(nwg-look)$
windowrulev2 = float, class:^(azote)$
windowrulev2 = float, title:^(Picture-in-Picture)$

# Gaming optimizations
windowrulev2 = fullscreen, class:^(steam_app_).*
windowrulev2 = monitor 1, class:^(steam_app_).*
EOF

# Create Waybar config
print_status "Setting up WehttamSnaps Waybar..."
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 35,
    "spacing": 4,
    
    "modules-left": ["custom/ws-logo", "hyprland/workspaces", "custom/gamemode"],
    "modules-center": ["hyprland/window"],
    "modules-right": ["custom/updates", "cpu", "memory", "temperature", "pulseaudio", "network", "clock", "tray", "custom/power"],
    
    "custom/ws-logo": {
        "format": "🎮 WS",
        "tooltip": false,
        "on-click": "rofi -show drun"
    },
    
    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "🏠",
            "2": "🎮",
            "3": "💬",
            "4": "📺",
            "5": "🌐",
            "urgent": "🔥",
            "focused": "🎯",
            "default": "💻"
        }
    },
    
    "custom/gamemode": {
        "exec": "if pgrep -x gamemode; then echo '🎮 GAMING'; else echo ''; fi",
        "interval": 5,
        "format": "{}"
    },
    
    "custom/updates": {
        "exec": "checkupdates | wc -l",
        "interval": 3600,
        "format": "📦 {}"
    },
    
    "cpu": {
        "format": "🔥 {usage}%",
        "tooltip": false
    },
    
    "memory": {
        "format": "🧠 {}%"
    },
    
    "temperature": {
        "thermal-zone": 2,
        "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
        "critical-threshold": 80,
        "format-critical": "🌡️ {temperatureC}°C 🔥",
        "format": "🌡️ {temperatureC}°C"
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-bluetooth": "{icon} {volume}%",
        "format-bluetooth-muted": "🔇",
        "format-muted": "🔇",
        "format-source": " {volume}%",
        "format-source-muted": "",
        "format-icons": {
            "headphone": "🎧",
            "hands-free": "🎧",
            "headset": "🎧",
            "phone": "📱",
            "portable": "📱",
            "car": "🚗",
            "default": ["🔈", "🔉", "🔊"]
        },
        "on-click": "pavucontrol"
    },
    
    "network": {
        "format-wifi": "📶 {essid}",
        "format-ethernet": "🌐 Connected",
        "format-linked": "🌐 (No IP)",
        "format-disconnected": "🚫 Disconnected",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
    },
    
    "clock": {
        "format": "📅 {:%Y-%m-%d 🕐 %H:%M}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format-alt": "{:%Y-%m-%d}"
    },
    
    "tray": {
        "spacing": 10
    },
    
    "custom/power": {
        "format": "⚡",
        "tooltip": false,
        "on-click": "wlogout"
    }
}
EOF

# Waybar styling
cat > ~/.config/waybar/style.css << 'EOF'
* {
    font-family: 'JetBrains Mono', 'Font Awesome 5 Free';
    font-size: 13px;
}

window#waybar {
    background-color: rgba(26, 27, 38, 0.9);
    border-bottom: 3px solid rgba(139, 92, 246, 0.8);
    color: #c0caf5;
    transition-property: background-color;
    transition-duration: .5s;
}

#workspaces {
    border-radius: 8px;
    background-color: rgba(65, 72, 104, 0.8);
    margin: 5px;
    padding: 0 5px;
}

#workspaces button {
    padding: 0 8px;
    background-color: transparent;
    color: #a9b1d6;
    border: none;
    border-radius: 4px;
}

#workspaces button:hover {
    background: rgba(139, 92, 246, 0.2);
}

#workspaces button.active {
    background-color: rgba(139, 92, 246, 0.8);
    color: #ffffff;
}

.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#custom-ws-logo {
    background: linear-gradient(45deg, #8B5CF6, #06B6D4);
    color: white;
    border-radius: 8px;
    padding: 0 12px;
    margin: 5px 5px 5px 10px;
    font-weight: bold;
}

#window {
    color: #7dcfff;
    font-weight: bold;
}

#cpu, #memory, #temperature, #pulseaudio, #network, #clock, #tray, #custom-updates, #custom-gamemode, #custom-power {
    padding: 0 10px;
    margin: 5px 2px;
    background-color: rgba(65, 72, 104, 0.8);
    border-radius: 8px;
    color: #c0caf5;
}

#cpu {
    background-color: rgba(247, 118, 142, 0.2);
    color: #f7768e;
}

#memory {
    background-color: rgba(158, 206, 106, 0.2);
    color: #9ece6a;
}

#temperature {
    background-color: rgba(224, 175, 104, 0.2);
    color: #e0af68;
}

#temperature.critical {
    background-color: rgba(247, 118, 142, 0.8);
    color: #ffffff;
}

#pulseaudio {
    background-color: rgba(125, 207, 255, 0.2);
    color: #7dcfff;
}

#network {
    background-color: rgba(187, 154, 247, 0.2);
    color: #bb9af7;
}

#clock {
    background-color: rgba(122, 162, 247, 0.2);
    color: #7aa2f7;
    margin-right: 10px;
}

#custom-gamemode {
    background: linear-gradient(45deg, #8B5CF6, #EC4899);
    color: white;
    font-weight: bold;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { opacity: 1; }
    50% { opacity: 0.7; }
    100% { opacity: 1; }
}

#custom-power {
    background-color: rgba(247, 118, 142, 0.8);
    color: #ffffff;
    margin-right: 10px;
}

#custom-power:hover {
    background-color: rgba(247, 118, 142, 1);
}
EOF

# Create gaming scripts
print_status "Creating WehttamSnaps gaming utilities..."
mkdir -p ~/WehttamSnaps/scripts

# Game launcher script
cat > ~/WehttamSnaps/scripts/game-launcher.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Game Launcher

GAMES=(
    "Steam:steam"
    "Lutris:lutris"
    "The Division 2:steam steam://rungameid/581320"
    "Cyberpunk 2077:steam steam://rungameid/1091500"
    "The First Descendant:steam steam://rungameid/2074920"
    "Discord:discord"
    "OBS Studio:obs"
)

choice=$(printf '%s\n' "${GAMES[@]}" | rofi -dmenu -i -p "🎮 Launch Game")

if [[ -n $choice ]]; then
    game_cmd=$(echo "$choice" | cut -d':' -f2-)
    eval "$game_cmd" &
    
    # Enable gamemode if it's a game
    if [[ $choice != *"Discord"* ]] && [[ $choice != *"OBS"* ]]; then
        notify-send "🎮 WehttamSnaps" "Launching $choice with gamemode"
        sleep 2
        gamemode-toggle
    fi
fi
EOF

# Streaming setup script
cat > ~/WehttamSnaps/scripts/streaming-setup.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Streaming Setup

# Set up workspaces for streaming
hyprctl dispatch workspace 4
obs --minimize-to-tray &
sleep 2

hyprctl dispatch workspace 3  
discord &
sleep 2

hyprctl dispatch workspace 2
steam -silent &

hyprctl dispatch workspace 1

notify-send "🎮 WehttamSnaps" "Streaming setup complete!"
EOF

# Make scripts executable
chmod +x ~/WehttamSnaps/scripts/*.sh

# Download wallpaper (create a gaming-themed one)
print_status "Setting up WehttamSnaps wallpaper..."
mkdir -p ~/WehttamSnaps/wallpapers

# Create a simple gradient wallpaper
cat > ~/WehttamSnaps/wallpapers/create-wallpaper.py << 'EOF'
#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont
import math

# Create wallpaper with WehttamSnaps colors
width, height = 1920, 1080
image = Image.new('RGB', (width, height))
draw = ImageDraw.Draw(image)

# Create gradient from violet to cyan
for y in range(height):
    r = int(139 - (139-6) * y / height)      # 139 to 6
    g = int(92 + (182-92) * y / height)      # 92 to 182
    b = int(246 - (246-212) * y / height)    # 246 to 212
    
    for x in range(width):
        # Add some noise/texture
        noise = int(20 * math.sin(x * 0.01) * math.cos(y * 0.01))
        r_final = max(0, min(255, r + noise))
        g_final = max(0, min(255, g + noise))
        b_final = max(0, min(255, b + noise))
        
        draw.point((x, y), (r_final, g_final, b_final))

# Add WS logo text
try:
    font = ImageFont.truetype("/usr/share/fonts/TTF/DejaVuSans-Bold.ttf", 120)
except:
    font = ImageFont.load_default()

text = "WS"
text_bbox = draw.textbbox((0, 0), text, font=font)
text_width = text_bbox[2] - text_bbox[0]
text_height = text_bbox[3] - text_bbox[1]
text_x = (width - text_width) // 2
text_y = (height - text_height) // 2

# Draw text shadow
draw.text((text_x + 5, text_y + 5), text, font=font, fill=(0, 0, 0, 100))
# Draw main text
draw.text((text_x, text_y), text, font=font, fill=(255, 255, 255, 200))

# Add subtitle
subtitle = "WehttamSnaps Gaming"
try:
    subfont = ImageFont.truetype("/usr/share/fonts/TTF/DejaVuSans.ttf", 40)
except:
    subfont = ImageFont.load_default()

sub_bbox = draw.textbbox((0, 0), subtitle, font=subfont)
sub_width = sub_bbox[2] - sub_bbox[0]
sub_x = (width - sub_width) // 2
sub_y = text_y + text_height + 20

draw.text((sub_x + 2, sub_y + 2), subtitle, font=subfont, fill=(0, 0, 0, 80))
draw.text((sub_x, sub_y), subtitle, font=subfont, fill=(255, 255, 255, 180))

image.save('/tmp/ws-gaming-wall.jpg', 'JPEG', quality=95)
print("Wallpaper created!")
EOF

python3 ~/WehttamSnaps/wallpapers/create-wallpaper.py 2>/dev/null || {
    # Fallback: download a solid color image
    convert -size 1920x1080 gradient:"#8B5CF6"-"#06B6D4" ~/WehttamSnaps/wallpapers/ws-gaming-wall.jpg 2>/dev/null || {
        # Final fallback: create simple solid color
        convert -size 1920x1080 xc:"#1a1b26" ~/WehttamSnaps/wallpapers/ws-gaming-wall.jpg 2>/dev/null
    }
}

# Set up rofi theme
print_status "Configuring WehttamSnaps Rofi theme..."
mkdir -p ~/.config/rofi
cat > ~/.config/rofi/config.rasi << 'EOF'
configuration {
    modi: "drun,run,window";
    show-icons: true;
    terminal: "kitty";
    drun-display-format: "{name}";
    location: 0;
    disable-history: false;
    hide-scrollbar: true;
    sidebar-mode: false;
}

@theme "~/.config/rofi/ws-theme.rasi"
EOF

cat > ~/.config/rofi/ws-theme.rasi << 'EOF'
* {
    bg-col: #1a1b26;
    bg-col-light: #1a1b26;
    border-col: #8B5CF6;
    selected-col: #8B5CF6;
    blue: #06B6D4;
    fg-col: #c0caf5;
    fg-col2: #7aa2f7;
    grey: #414868;

    width: 600;
    font: "JetBrains Mono 12";
}

element-text, element-icon, mode-switcher {
    background-color: inherit;
    text-color: inherit;
}

window {
    height: 360px;
    border: 3px;
    border-color: @border-col;
    background-color: @bg-col;
    border-radius: 12px;
}

mainbox {
    background-color: @bg-col;
}

inputbar {
    children: [prompt,entry];
    background-color: @bg-col;
    border-radius: 8px;
    padding: 2px;
}

prompt {
    background-color: @blue;
    padding: 6px;
    text-color: @bg-col;
    border-radius: 6px;
    margin: 20px 0px 0px 20px;
}

textbox-prompt-colon {
    expand: false;
    str: ":";
}

entry {
    padding: 6px;
    margin: 20px 0px 0px 10px;
    text-color: @fg-col;
    background-color: @bg-col;
}

listview {
    border: 0px 0px 0px;
    padding: 6px 0px 0px;
    margin: 10px 0px 0px 20px;
    columns: 1;
    lines: 5;
    background-color: @bg-col;
}

element {
    padding: 5px;
    background-color: @bg-col;
    text-color: @fg-col;
    border-radius: 6px;
}

element-icon {
    size: 25px;
}

element selected {
    background-color: @selected-col;
    text-color: @bg-col;
}

mode-switcher {
    spacing: 0;
}

button {
    padding: 10px;
    background-color: @bg-col-light;
    text-color: @grey;
    vertical-align: 0.5;
    horizontal-align: 0.5;
}

button selected {
    background-color: @bg-col;
    text-color: @blue;
}
EOF

# Set up terminal (kitty)
print_status "Configuring WehttamSnaps terminal..."
cat > ~/.config/kitty/kitty.conf << 'EOF'
# WehttamSnaps Gaming Terminal Config

# Font
font_family JetBrains Mono
bold_font auto
italic_font auto
bold_italic_font auto
font_size 12.0

# Colors - TokyoNight theme with WehttamSnaps accents
foreground #c0caf5
background #1a1b26
selection_foreground none
selection_background #33467C

# Cursor
cursor #c0caf5
cursor_text_color #1a1b26

# URL
url_color #73daca
url_style curly

# Border
active_border_color #8B5CF6
inactive_border_color #414868
bell_border_color #e0af68

# Tabs
tab_bar_style powerline
tab_powerline_style slanted
active_tab_foreground #1a1b26
active_tab_background #8B5CF6
inactive_tab_foreground #c0caf5
inactive_tab_background #414868

# Normal colors
color0 #15161e
color1 #f7768e
color2 #9ece6a
color3 #e0af68
color4 #7aa2f7
color5 #bb9af7
color6 #7dcfff
color7 #a9b1d6

# Bright colors
color8 #414868
color9 #f7768e
color10 #9ece6a
color11 #e0af68
color12 #7aa2f7
color13 #bb9af7
color14 #7dcfff
color15 #c0caf5

# Extended colors for gaming
color16 #ff9e64
color17 #db4b4b

# Performance
sync_to_monitor yes
enable_audio_bell no
window_alert_on_bell no

# Gaming optimizations
input_delay 0
repaint_delay 5

# Window layout
window_border_width 2px
window_margin_width 2
window_padding_width 4
placement_strategy center

# Keybinds
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+v paste_from_clipboard
map ctrl+shift+enter new_window
map ctrl+shift+t new_tab
EOF

# Configure dunst for notifications
print_status "Setting up WehttamSnaps notifications..."
cat > ~/.config/dunst/dunstrc << 'EOF'
[global]
    monitor = 0
    follow = mouse
    geometry = "350x5-15+49"
    indicate_hidden = yes
    shrink = yes
    transparency = 10
    notification_height = 0
    separator_height = 2
    padding = 12
    horizontal_padding = 12
    frame_width = 2
    frame_color = "#8B5CF6"
    separator_color = frame
    sort = yes
    idle_threshold = 120
    font = JetBrains Mono 10
    line_height = 0
    markup = full
    format = "<b>%s</b>\n%b"
    alignment = left
    show_age_threshold = 60
    word_wrap = yes
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = true
    hide_duplicate_count = false
    show_indicators = yes
    icon_position = left
    max_icon_size = 32
    sticky_history = yes
    history_length = 20
    dmenu = /usr/bin/rofi -dmenu -p dunst:
    browser = /usr/bin/firefox
    always_run_script = true
    title = Dunst
    class = Dunst
    startup_notification = false
    verbosity = mesg
    corner_radius = 8

[experimental]
    per_monitor_dpi = false

[shortcuts]
    close = ctrl+space
    close_all = ctrl+shift+space
    history = ctrl+grave
    context = ctrl+shift+period

[urgency_low]
    background = "#1a1b26"
    foreground = "#c0caf5"
    timeout = 10

[urgency_normal]
    background = "#1a1b26"
    foreground = "#c0caf5"
    timeout = 10

[urgency_critical]
    background = "#f7768e"
    foreground = "#1a1b26"
    frame_color = "#f7768e"
    timeout = 0

[gaming]
    appname = WehttamSnaps
    background = "#8B5CF6"
    foreground = "#ffffff"
    frame_color = "#06B6D4"
    timeout = 5
EOF

# Set up SDDM login theme
print_status "Configuring WehttamSnaps login screen..."
sudo mkdir -p /etc/sddm.conf.d
cat > /tmp/sddm.conf << 'EOF'
[Theme]
Current=sugar-candy

[General]
InputMethod=
EOF
sudo mv /tmp/sddm.conf /etc/sddm.conf.d/

# Configure Sugar Candy theme
sudo mkdir -p /usr/share/sddm/themes/sugar-candy
sudo tee /usr/share/sddm/themes/sugar-candy/theme.conf > /dev/null << 'EOF'
[General]
Background="Backgrounds/WS-Background.jpg"
DimBackgroundImage="0.0"
ScaleImageCropped=true
ScreenWidth=1920
ScreenHeight=1080
FullBlur=false
PartialBlur=true
BlurRadius=100
HaveFormBackground=false
FormPosition="left"
BackgroundImageHAlignment="center"
BackgroundImageVAlignment="center"
MainColor="#8B5CF6"
AccentColor="#06B6D4"
BackgroundColor="#1a1b26"
OverrideLoginButtonTextColor=""
InterfaceShadowSize="6"
InterfaceShadowOpacity="0.6"
RoundCorners="20"
ScreenPadding="0"
Font="JetBrains Mono"
FontSize="10"
ForceRightToLeft=false
ForceLastUser=true
ForcePasswordFocus=true
ForceHideCompletePassword=false
ForceHideVirtualKeyboardButton=false
ForceHideSystemButtons=false
AllowEmptyPassword=false
AllowBadUsernames=false
Locale=""
HourFormat="HH:mm"
DateFormat="dddd, MMMM d, yyyy"
HeaderText="WehttamSnaps Gaming Station"
EOF

# Gaming optimizations
print_status "Applying gaming optimizations..."

# Create gaming profile script
cat > ~/WehttamSnaps/scripts/gaming-mode.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Gaming Mode Toggle

GAMING_FILE="/tmp/ws-gaming-mode"

if [ -f "$GAMING_FILE" ]; then
    # Disable gaming mode
    rm -f "$GAMING_FILE"
    
    # Reset CPU governor
    echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    
    # Normal GPU performance
    echo "auto" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null
    
    # Re-enable compositor effects
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword animations:enabled true
    
    notify-send "🎮 WehttamSnaps" "Gaming mode disabled - Power saving restored"
else
    # Enable gaming mode
    touch "$GAMING_FILE"
    
    # Set CPU to performance
    echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    
    # Max GPU performance
    echo "high" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level > /dev/null 2>/dev/null || true
    
    # Disable compositor effects for performance
    hyprctl keyword decoration:blur:enabled false
    hyprctl keyword animations:enabled false
    
    # Kill unnecessary processes
    pkill -f discord || true
    pkill -f firefox || true
    
    notify-send "🎮 WehttamSnaps" "Gaming mode enabled - Maximum performance!"
fi
EOF

chmod +x ~/WehttamSnaps/scripts/gaming-mode.sh

# Create alias for easier access
echo 'alias gaming-mode="~/WehttamSnaps/scripts/gaming-mode.sh"' >> ~/.zshrc

# Set up OBS for streaming
print_status "Configuring OBS for WehttamSnaps streaming..."
mkdir -p ~/.config/obs-studio/basic/scenes
mkdir -p ~/.config/obs-studio/basic/profiles/WehttamSnaps

# OBS Scene collection
cat > ~/.config/obs-studio/basic/scenes/WehttamSnaps.json << 'EOF'
{
    "AuxAudioDevice1": {
        "balance": 0.5,
        "deinterlace_field_order": 0,
        "deinterlace_mode": 0,
        "enabled": true,
        "flags": 0,
        "hotkeys": {},
        "id": "pulse_input_capture",
        "mixers": 255,
        "monitoring_type": 0,
        "muted": false,
        "name": "Mic/Aux",
        "prev_ver": 469762048,
        "private_settings": {},
        "push-to-mute": false,
        "push-to-mute-delay": 0,
        "push-to-talk": false,
        "push-to-talk-delay": 0,
        "settings": {
            "device_id": "default"
        },
        "sync": 0,
        "versioned_id": "pulse_input_capture",
        "volume": 1.0
    },
    "DesktopAudioDevice1": {
        "balance": 0.5,
        "deinterlace_field_order": 0,
        "deinterlace_mode": 0,
        "enabled": true,
        "flags": 0,
        "hotkeys": {},
        "id": "pulse_output_capture",
        "mixers": 255,
        "monitoring_type": 0,
        "muted": false,
        "name": "Desktop Audio",
        "prev_ver": 469762048,
        "private_settings": {},
        "push-to-mute": false,
        "push-to-mute-delay": 0,
        "push-to-talk": false,
        "push-to-talk-delay": 0,
        "settings": {
            "device_id": "default"
        },
        "sync": 0,
        "versioned_id": "pulse_output_capture",
        "volume": 1.0
    },
    "current_program_scene": "Gaming Scene",
    "current_scene": "Gaming Scene",
    "current_transition": "Fade",
    "groups": [],
    "modules": {
        "auto-scene-switcher": {
            "active": false,
            "interval": 300,
            "non_matching_scene": "",
            "switch_if_not_matching": false,
            "switches": []
        },
        "output-timer": {
            "autoStart": false,
            "autoStartRecordTimer": false,
            "autoStartStreamTimer": false,
            "pauseRecordTimer": true,
            "pauseStreamTimer": true,
            "recordTimerHours": 0,
            "recordTimerMinutes": 0,
            "recordTimerSeconds": 30,
            "streamTimerHours": 1,
            "streamTimerMinutes": 0,
            "streamTimerSeconds": 0
        }
    },
    "name": "WehttamSnaps",
    "preview_locked": false,
    "quick_transitions": [
        {
            "duration": 300,
            "fade_to_black": false,
            "hotkeys": [],
            "id": 1,
            "name": "Cut"
        },
        {
            "duration": 300,
            "fade_to_black": false,
            "hotkeys": [],
            "id": 2,
            "name": "Fade"
        }
    ],
    "saved": true,
    "scene_order": [
        {
            "name": "Gaming Scene"
        },
        {
            "name": "Just Chatting"
        },
        {
            "name": "BRB Scene"
        },
        {
            "name": "Starting Soon"
        },
        {
            "name": "Ending Screen"
        }
    ],
    "sources": [],
    "transitions": [
        {
            "duration": 300,
            "hotkeys": [],
            "id": "cut_transition",
            "name": "Cut",
            "settings": {}
        },
        {
            "duration": 300,
            "hotkeys": [],
            "id": "fade_transition",
            "name": "Fade",
            "settings": {}
        }
    ],
    "version": "29.1.3"
}
EOF

# Configure zsh with starship
print_status "Setting up WehttamSnaps shell environment..."
chsh -s $(which zsh) 2>/dev/null || true

cat > ~/.zshrc << 'EOF'
# WehttamSnaps ZSH Configuration

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# Completion
autoload -Uz compinit
compinit

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias gaming-mode='~/WehttamSnaps/scripts/gaming-mode.sh'
alias stream-setup='~/WehttamSnaps/scripts/streaming-setup.sh'
alias launch-game='~/WehttamSnaps/scripts/game-launcher.sh'

# Gaming shortcuts
alias division2='steam steam://rungameid/581320'
alias cyberpunk='steam steam://rungameid/1091500'
alias descendant='steam steam://rungameid/2074920'

# Streaming shortcuts
alias start-stream='obs --start-streaming'
alias stop-stream='obs --stop-streaming'
alias start-record='obs --start-recording'
alias stop-record='obs --stop-recording'

# Environment
export EDITOR=nano
export BROWSER=firefox
export TERMINAL=kitty

# Gaming environment variables
export RADV_PERFTEST=aco
export mesa_glthread=true
export vblank_mode=0

# Starship prompt
eval "$(starship init zsh)"

# Welcome message
echo "🎮 Welcome to WehttamSnaps Gaming Station!"
echo "💻 Use 'gaming-mode' to toggle performance mode"
echo "🎬 Use 'stream-setup' to prepare for streaming"
echo "🎮 Use 'launch-game' for quick game access"
EOF

# Create starship config
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
# WehttamSnaps Starship Configuration

format = """
[┌─ ](bold purple)$username[@](bold cyan)$hostname[ in ](bold cyan)$directory$git_branch$git_status
[└─ ](bold purple)$character"""

right_format = """$cmd_duration$time"""

[character]
success_symbol = "[🎮](bold purple)"
error_symbol = "[💀](bold red)"

[username]
style_user = "bold cyan"
style_root = "bold red"
format = "[$user]($style)"
show_always = true

[hostname]
ssh_only = false
format = "[$hostname](bold purple)"

[directory]
style = "bold blue"
truncation_length = 3
truncate_to_repo = false

[git_branch]
symbol = "🌱 "
style = "bold green"

[git_status]
style = "bold yellow"

[time]
disabled = false
format = "🕐[$time](bold white)"
time_format = "%H:%M"

[cmd_duration]
min_time = 2_000
format = "⏱️ [$duration](bold yellow)"
EOF

# Install fonts
print_status "Installing WehttamSnaps fonts..."
mkdir -p ~/.local/share/fonts

# Download JetBrains Mono
curl -L https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip -o /tmp/jetbrains-mono.zip 2>/dev/null || true
if [ -f /tmp/jetbrains-mono.zip ]; then
    unzip -q /tmp/jetbrains-mono.zip -d /tmp/jetbrains-mono
    cp /tmp/jetbrains-mono/fonts/ttf/*.ttf ~/.local/share/fonts/
    rm -rf /tmp/jetbrains-mono*
fi

# Refresh font cache
fc-cache -fv

# Enable services
print_status "Enabling WehttamSnaps services..."
sudo systemctl enable sddm
sudo systemctl enable NetworkManager
systemctl --user enable pipewire pipewire-pulse
sudo systemctl enable zram-generator

# Create desktop entries
print_status "Creating WehttamSnaps desktop shortcuts..."
mkdir -p ~/.local/share/applications

cat > ~/.local/share/applications/ws-gaming-mode.desktop << 'EOF'
[Desktop Entry]
Name=WehttamSnaps Gaming Mode
Comment=Toggle gaming performance mode
Exec=/home/USER/WehttamSnaps/scripts/gaming-mode.sh
Icon=applications-games
Type=Application
Categories=Game;
EOF

cat > ~/.local/share/applications/ws-stream-setup.desktop << 'EOF'
[Desktop Entry]
Name=WehttamSnaps Stream Setup
Comment=Prepare workspaces for streaming
Exec=/home/USER/WehttamSnaps/scripts/streaming-setup.sh
Icon=camera-video
Type=Application
Categories=AudioVideo;
EOF

# Replace USER placeholder
sed -i "s/USER/$USER/g" ~/.local/share/applications/ws-*.desktop

# Final system optimizations
print_status "Applying final WehttamSnaps optimizations..."

# AMD GPU optimizations
if lspci | grep -i amd > /dev/null; then
    echo 'KERNEL=="card0", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"' | sudo tee /etc/udev/rules.d/30-amdgpu.rules > /dev/null
fi

# Gaming kernel parameters
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.d/99-gaming.conf > /dev/null
echo 'kernel.sched_autogroup_enabled=0' | sudo tee -a /etc/sysctl.d/99-gaming.conf > /dev/null

# Create final setup script
cat > ~/WehttamSnaps/scripts/post-reboot.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Post-Reboot Setup

# Set wallpaper
swww img ~/WehttamSnaps/wallpapers/ws-gaming-wall.jpg

# Start gaming services
steam -silent &
gamemode &

# Setup complete notification
sleep 5
notify-send "🎮 WehttamSnaps Setup Complete!" "Welcome to your gaming paradise!"
EOF

chmod +x ~/WehttamSnaps/scripts/post-reboot.sh

# Add to autostart
echo "exec-once = ~/WehttamSnaps/scripts/post-reboot.sh" >> ~/.config/hypr/hyprland.conf

print_status "🎮 WehttamSnaps Hyprland setup is complete!"
echo
echo -e "${PURPLE}=================================================${NC}"
echo -e "${CYAN}🎮 WehttamSnaps Gaming Station Ready!${NC}"
echo -e "${PURPLE}=================================================${NC}"
echo
echo -e "${GREEN}Next steps:${NC}"
echo -e "1. ${YELLOW}Reboot your system:${NC} sudo reboot"
echo -e "2. ${YELLOW}Login with SDDM${NC} (should auto-select Hyprland)"
echo -e "3. ${YELLOW}Test gaming mode:${NC} Super + Shift + G"
echo -e "4. ${YELLOW}Launch games:${NC} Super + G"
echo -e "5. ${YELLOW}Setup streaming:${NC} run 'stream-setup' in terminal"
echo
echo -e "${GREEN}Gaming shortcuts:${NC}"
echo -e "• ${CYAN}Super + G${NC} - Launch Steam"
echo -e "• ${CYAN}Super + D${NC} - Launch Discord"
echo -e "• ${CYAN}Super + O${NC} - Launch OBS"
echo -e "• ${CYAN}Super + Shift + G${NC} - Toggle Gaming Mode"
echo -e "• ${CYAN}Super + F9/F10${NC} - Start/Stop Recording"
echo -e "• ${CYAN}Super + F11${NC} - Start/Stop Streaming"
echo
echo -e "${GREEN}Files created in:${NC}"
echo -e "• ${YELLOW}~/WehttamSnaps/scripts/${NC} - All utility scripts"
echo -e "• ${YELLOW}~/WehttamSnaps/configs/${NC} - Backup configurations"
echo -e "• ${YELLOW}~/WehttamSnaps/wallpapers/${NC} - Custom wallpapers"
echo
echo -e "${PURPLE}🎬 Ready to stream The Division 2, Cyberpunk, and The First Descendant!${NC}"
echo -e "${CYAN}📸 Photography meets Gaming - WehttamSnaps style!${NC}"
echo
