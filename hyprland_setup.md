#!/bin/bash

# WehttamSnaps Hyprland Complete Setup Script
# Violet-to-Cyan TokyoNight Gaming/Photography Workstation
# Author: Created for Matt (@WehttamSnaps)

set -e

# Colors for output
VIOLET='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ASCII Art Banner
echo -e "${VIOLET}"
cat << "EOF"
 __      __      _     _   _                   _____                      
 \ \    / /     | |   | | | |                 /  ___|                     
  \ \/\/ /  ___ | |__ | |_| |_ __ _ _ __ ___   \ `--.  _ __   __ _ _ __  ___ 
   \    /  / _ \| '_ \| __| __/ _` | '_ ` _ \   `--. \| '_ \ / _` | '_ \/ __|
    \  /  |  __/| | | | |_| || (_| | | | | | | /\__/ /| | | | (_| | |_) \__ \
     \/    \___||_| |_|\__|\__\__,_|_| |_| |_| \____/ |_| |_|\__,_| .__/|___/
                                                                  | |        
     Hyprland Gaming/Photography Workstation Setup               |_|        
EOF
echo -e "${NC}"

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo -e "${RED}This script should not be run as root${NC}"
   exit 1
fi

# Confirm installation
echo -e "${CYAN}This script will install a complete WehttamSnaps-branded Hyprland setup.${NC}"
echo -e "${YELLOW}Continue? (y/n)${NC}"
read -r response
if [[ ! $response =~ ^[Yy]$ ]]; then
    exit 0
fi

# Update system
echo -e "${VIOLET}[1/10] Updating system...${NC}"
sudo pacman -Syu --noconfirm

# Install base packages
echo -e "${VIOLET}[2/10] Installing base packages...${NC}"
sudo pacman -S --noconfirm \
    hyprland hyprpaper hypridle hyprlock \
    waybar wofi rofi fuzzel \
    kitty alacritty foot \
    thunar thunar-volman gvfs \
    firefox firefox-developer-edition \
    discord telegram-desktop \
    pipewire pipewire-pulse pipewire-jack wireplumber \
    pavucontrol pamixer \
    brightnessctl \
    network-manager-applet \
    bluez bluez-utils \
    sddm sddm-kcm \
    grub grub-bios-config \
    ttf-jetbrains-mono ttf-font-awesome ttf-fira-code \
    noto-fonts noto-fonts-emoji \
    neofetch fastfetch htop btop \
    git github-cli \
    steam lutris heroic-games-launcher \
    obs-studio \
    gimp inkscape krita \
    code neovim \
    zsh zsh-completions \
    starship

# Install AUR helper (yay)
echo -e "${VIOLET}[3/10] Installing AUR helper...${NC}"
if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# Install AUR packages
echo -e "${VIOLET}[4/10] Installing AUR packages...${NC}"
yay -S --noconfirm \
    eww-wayland \
    swww \
    sddm-sugar-candy-git \
    wlogout \
    hyprshot \
    waybar-hyprland-git \
    cava \
    spotify \
    vesktop-bin \
    gamescope \
    gamemode \
    mangohud

# Create directories
echo -e "${VIOLET}[5/10] Creating directories...${NC}"
mkdir -p ~/.config/{hypr,waybar,rofi,kitty,eww,wlogout,dunst}
mkdir -p ~/.local/share/{applications,icons,themes,sounds}
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Videos/Recordings
mkdir -p ~/.local/bin

# Install Hyprland configuration
echo -e "${VIOLET}[6/10] Installing Hyprland configuration...${NC}"
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# WehttamSnaps Hyprland Config - Violet to Cyan Theme
# Monitor setup
monitor=,preferred,auto,1

# Execute your favorite apps at launch
exec-once = waybar
exec-once = hyprpaper
exec-once = hypridle
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = swww init
exec-once = nm-applet --indicator
exec-once = blueman-applet
exec-once = wl-paste --type text --watch cliphist store
exec-once = wl-paste --type image --watch cliphist store

# Source a file (multi-file configs)
source = ~/.config/hypr/mocha.conf

# Environment variables
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct

# Input configuration
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =
    follow_mouse = 1
    touchpad {
        natural_scroll = yes
    }
    sensitivity = 0
}

# General settings
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(8A2BE2ff) rgba(00FFFFff) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
    allow_tearing = false
}

# Decoration
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 8
        passes = 1
    }
    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Animations
animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Layouts
dwindle {
    pseudotile = yes
    preserve_split = yes
}

master {
    new_is_master = true
}

# Gestures
gestures {
    workspace_swipe = off
}

# Gaming optimizations
misc {
    force_default_wallpaper = -1
    disable_hyprland_logo = yes
    vfr = true
    vrr = 1
}

# Window rules
windowrule = float, ^(pavucontrol)$
windowrule = float, ^(blueman-manager)$
windowrule = float, ^(nm-connection-editor)$
windowrule = float, ^(rofi)$
windowrulev2 = opacity 0.8 0.8,class:^(kitty)$
windowrulev2 = opacity 0.9 0.9,class:^(thunar)$

# Gaming window rules
windowrulev2 = immediate, class:^(steam_app_)(.*)$
windowrulev2 = immediate, class:^(gamescope)$

# Keybindings
$mainMod = SUPER

# App launchers
bind = $mainMod, Q, exec, kitty
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, rofi -show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, F, fullscreen,

# Screenshot
bind = , Print, exec, hyprshot -m window
bind = $mainMod, Print, exec, hyprshot -m output
bind = $mainMod SHIFT, Print, exec, hyprshot -m region

# Gaming shortcuts
bind = $mainMod, G, exec, steam
bind = $mainMod SHIFT, G, exec, lutris
bind = $mainMod CTRL, G, exec, heroic

# Streaming shortcuts
bind = $mainMod, O, exec, obs
bind = $mainMod SHIFT, O, exec, ~/.local/bin/stream-setup.sh

# Photography shortcuts
bind = $mainMod, I, exec, gimp
bind = $mainMod SHIFT, I, exec, krita

# Move focus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces
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

# Move windows to workspace
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

# Audio controls
bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
bind = , XF86AudioLowerVolume, exec, pamixer -d 5
bind = , XF86AudioMute, exec, pamixer -t

# Custom WehttamSnaps shortcuts
bind = $mainMod, K, exec, ~/.local/bin/welcome-app.sh
bind = $mainMod SHIFT, K, exec, ~/.local/bin/settings-app.sh
bind = $mainMod, SPACE, exec, ~/.local/bin/game-launcher.sh
bind = $mainMod SHIFT, SPACE, exec, ~/.local/bin/work-launcher.sh
EOF

# Install Waybar configuration
echo -e "${VIOLET}[7/10] Installing Waybar configuration...${NC}"
cat > ~/.config/waybar/config.json << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "spacing": 4,
    "modules-left": ["hyprland/workspaces", "wlr/taskbar"],
    "modules-center": ["hyprland/window"],
    "modules-right": ["mpd", "idle_inhibitor", "pulseaudio", "network", "cpu", "memory", "temperature", "backlight", "battery", "battery#bat2", "clock", "tray"],

    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "warp-on-scroll": false,
        "format": "{icon}",
        "format-icons": {
            "1": "🎮",
            "2": "🌐",
            "3": "💬",
            "4": "📸",
            "5": "🎵",
            "urgent": "",
            "focused": "",
            "default": ""
        }
    },

    "clock": {
        "timezone": "America/Chicago",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format-alt": "{:%Y-%m-%d}"
    },

    "cpu": {
        "format": "{usage}% ",
        "tooltip": false
    },

    "memory": {
        "format": "{}% "
    },

    "temperature": {
        "critical-threshold": 80,
        "format": "{temperatureC}°C {icon}",
        "format-icons": ["", "", ""]
    },

    "network": {
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "{ipaddr}/{cidr} ",
        "tooltip-format": "{ifname} via {gwaddr} ",
        "format-linked": "{ifname} (No IP) ",
        "format-disconnected": "Disconnected ⚠",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
    },

    "pulseaudio": {
        "format": "{volume}% {icon} {format_source}",
        "format-bluetooth": "{volume}% {icon} {format_source}",
        "format-bluetooth-muted": " {icon} {format_source}",
        "format-muted": " {format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    }
}
EOF

cat > ~/.config/waybar/style.css << 'EOF'
* {
    font-family: JetBrains Mono, FontAwesome, sans-serif;
    font-size: 13px;
}

window#waybar {
    background-color: rgba(26, 26, 46, 0.9);
    border-bottom: 3px solid;
    border-image: linear-gradient(45deg, #8A2BE2, #00FFFF) 1;
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
}

button {
    box-shadow: inset 0 -3px transparent;
    border: none;
    border-radius: 0;
}

#workspaces button {
    padding: 0 8px;
    background-color: transparent;
    color: #ffffff;
}

#workspaces button:hover {
    background: rgba(138, 43, 226, 0.3);
}

#workspaces button.active {
    background: linear-gradient(45deg, #8A2BE2, #00FFFF);
    color: white;
}

#clock,
#battery,
#cpu,
#memory,
#temperature,
#network,
#pulseaudio,
#tray {
    padding: 0 10px;
    color: #ffffff;
}

#window {
    background: linear-gradient(45deg, rgba(138, 43, 226, 0.3), rgba(0, 255, 255, 0.3));
    padding: 0 10px;
    border-radius: 8px;
}

#battery.charging, #battery.plugged {
    color: #ffffff;
    background: linear-gradient(45deg, #8A2BE2, #00FFFF);
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}
EOF

# Create custom applications
echo -e "${VIOLET}[8/10] Creating custom applications...${NC}"

# Welcome App
cat > ~/.local/bin/welcome-app.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Welcome App

CHOICE=$(echo -e "🎮 Game Launcher\n🛠️ Settings App\n📸 Photography Tools\n🎥 Streaming Setup\n⚙️ System Updates\n📋 Keybindings\n🎨 Theming\n❌ Exit" | rofi -dmenu -p "WehttamSnaps Control")

case $CHOICE in
    "🎮 Game Launcher")
        ~/.local/bin/game-launcher.sh
        ;;
    "🛠️ Settings App")
        ~/.local/bin/settings-app.sh
        ;;
    "📸 Photography Tools")
        ~/.local/bin/photo-tools.sh
        ;;
    "🎥 Streaming Setup")
        ~/.local/bin/stream-setup.sh
        ;;
    "⚙️ System Updates")
        kitty -e sudo pacman -Syu
        ;;
    "📋 Keybindings")
        ~/.local/bin/show-keybindings.sh
        ;;
    "🎨 Theming")
        ~/.local/bin/theme-manager.sh
        ;;
esac
