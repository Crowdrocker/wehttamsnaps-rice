#!/bin/bash

# WehttamSnaps Complete Hyprland Gaming Setup Script
# Matt's Custom Streaming & Gaming Environment
# violet-to-cyan TokyoNight theme

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${PURPLE}"
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                    WehttamSnaps Gaming Setup Script                         ║"
echo "║                    Hyprland + Gaming + Streaming                            ║"
echo "║                    violet-to-cyan TokyoNight theme                          ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "This script should not be run as root"
   exit 1
fi

# Update system first
print_status "Updating system packages..."
sudo pacman -Syu --noconfirm

# Install paru (AUR helper) if not present
if ! command -v paru &> /dev/null; then
    print_status "Installing paru AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ~
fi

# Core Hyprland packages
print_status "Installing Hyprland and core packages..."
sudo pacman -S --needed --noconfirm \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    xdg-desktop-portal-hyprland \
    qt5-wayland \
    qt6-wayland \
    waybar \
    rofi-wayland \
    fuzzel \
    dunst \
    mako \
    thunar \
    thunar-volman \
    thunar-archive-plugin \
    file-roller \
    xfce4-terminal \
    pavucontrol \
    pipewire \
    pipewire-alsa \
    pipewire-pulse \
    wireplumber \
    sddm \
    grub \
    neofetch \
    fastfetch \
    htop \
    btop \
    zsh \
    starship \
    git \
    curl \
    wget \
    unzip \
    grim \
    slurp \
    wl-clipboard \
    cliphist \
    brightnessctl \
    playerctl \
    nwg-look \
    azote \
    polkit-gnome

# Gaming packages
print_status "Installing gaming packages and optimizations..."
sudo pacman -S --needed --noconfirm \
    steam \
    lutris \
    gamemode \
    gamescope \
    vulkan-radeon \
    lib32-vulkan-radeon \
    mesa \
    lib32-mesa \
    wine \
    winetricks \
    dxvk \
    mangohud \
    lib32-mangohud \
    zram-generator

# AUR packages
print_status "Installing AUR packages..."
paru -S --needed --noconfirm \
    eww-wayland \
    nwg-drawer \
    sddm-sugar-candy-git \
    hyprshot \
    heroic-games-launcher-bin \
    discord \
    obs-studio \
    visual-studio-code-bin \
    spotify

# Create directories
print_status "Creating config directories..."
mkdir -p ~/.config/{hypr,waybar,rofi,dunst,eww,gtk-3.0,gtk-4.0}
mkdir -p ~/.local/share/fonts
mkdir -p ~/Pictures/wallpapers
mkdir -p ~/.themes
mkdir -p ~/WehttamSnaps-Brand

# Install fonts
print_status "Installing fonts..."
cd /tmp
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"
wget "https://fonts.google.com/download?family=Orbitron" -O Orbitron.zip
wget "https://github.com/googlefonts/Exo-2/archive/refs/heads/master.zip" -O Exo2.zip
unzip JetBrainsMono.zip -d JetBrainsMono
unzip Orbitron.zip -d Orbitron
unzip Exo2.zip -d Exo2
cp JetBrainsMono/*.ttf ~/.local/share/fonts/
cp Orbitron/*.ttf ~/.local/share/fonts/
find Exo2/ -name "*.ttf" -exec cp {} ~/.local/share/fonts/ \;
fc-cache -fv

# Hyprland config
print_status "Creating Hyprland configuration..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# WehttamSnaps Hyprland Config
# violet-to-cyan TokyoNight Gaming Setup

monitor=,preferred,auto,1

exec-once = waybar
exec-once = hyprpaper
exec-once = dunst
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = cliphist wipe
exec-once = wl-paste --type text --watch cliphist store
exec-once = wl-paste --type image --watch cliphist store

env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt6ct
env = QT_QPA_PLATFORM,wayland;xcb
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
env = GDK_BACKEND,wayland,x11
env = SDL_VIDEODRIVER,wayland
env = CLUTTER_BACKEND,wayland

# AMD GPU optimizations
env = __GL_VRR_ALLOWED,1
env = WLR_DRM_NO_ATOMIC,1
env = __GL_GSYNC_ALLOWED,1
env = __GL_MaxFramesAllowed,1
env = PROTON_ENABLE_NGX_UPDATER,1

input {
    kb_layout = us
    follow_mouse = 1
    touchpad {
        natural_scroll = no
    }
    sensitivity = 0
}

general {
    gaps_in = 8
    gaps_out = 16
    border_size = 3
    col.active_border = rgba(7aa2f7ff) rgba(bb9af7ff) 45deg
    col.inactive_border = rgba(414868aa)
    layout = dwindle
    allow_tearing = true
}

decoration {
    rounding = 12
    blur {
        enabled = true
        size = 6
        passes = 3
        new_optimizations = true
        xray = true
        ignore_opacity = true
    }
    drop_shadow = yes
    shadow_range = 20
    shadow_render_power = 3
    col.shadow = rgba(000000aa)
    active_opacity = 0.95
    inactive_opacity = 0.85
}

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

dwindle {
    pseudotile = yes
    preserve_split = yes
}

windowrulev2 = immediate, class:^(cs2)$
windowrulev2 = immediate, class:^(steam_app_).*
windowrulev2 = immediate, class:^(gamescope)$

# Gaming window rules
windowrulev2 = fullscreen, class:^(cs2)$
windowrulev2 = fullscreen, class:^(steam_app_).*
windowrulev2 = workspace 5, class:^(steam)$
windowrulev2 = workspace 6, class:^(lutris)$
windowrulev2 = workspace 6, class:^(heroic)$
windowrulev2 = workspace 4, class:^(discord)$
windowrulev2 = workspace 7, class:^(obs)$
windowrulev2 = workspace 8, class:^(spotify)$

# Key bindings
$mainMod = SUPER

# Essential binds
bind = $mainMod, Return, exec, xfce4-terminal
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, Space, exec, rofi -show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, F, fullscreen,

# Gaming toggles
bind = $mainMod, G, exec, gamemoderun
bind = $mainMod SHIFT, G, exec, pkill gamemode

# Screenshots
bind = , Print, exec, hyprshot -m output
bind = $mainMod, Print, exec, hyprshot -m window
bind = $mainMod SHIFT, S, exec, hyprshot -m region

# Audio
bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# Media
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous

# Move focus
bind = $mainMod, H, movefocus, l
bind = $mainMod, L, movefocus, r
bind = $mainMod, K, movefocus, u
bind = $mainMod, J, movefocus, d

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
EOF

# Waybar config
print_status "Creating Waybar configuration..."
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 35,
    "modules-left": ["custom/arch", "hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["custom/gamemode", "cpu", "memory", "temperature", "custom/gpu", "pulseaudio", "network", "battery", "custom/power"],
    
    "custom/arch": {
        "format": " ",
        "tooltip": false,
        "on-click": "nwg-drawer"
    },
    
    "hyprland/workspaces": {
        "format": "{icon}",
        "format-icons": {
            "1": "󰈹",
            "2": "",
            "3": "",
            "4": "󰙯",
            "5": "󰓓",
            "6": "󰊴",
            "7": "󰕧",
            "8": "󰓇",
            "9": "󰗃",
            "10": "󰝚"
        },
        "persistent_workspaces": {
            "1": [],
            "2": [],
            "3": [],
            "4": [],
            "5": []
        }
    },
    
    "hyprland/window": {
        "format": "{}",
        "max-length": 50
    },
    
    "clock": {
        "format": "{:%I:%M %p}",
        "format-alt": "{:%A, %B %d, %Y}",
        "tooltip-format": "<tt><small>{calendar}</small></tt>"
    },
    
    "custom/gamemode": {
        "exec": "pgrep -x gamemode && echo '󰊖 Gaming' || echo '󰊗 Normal'",
        "interval": 5,
        "tooltip": true
    },
    
    "cpu": {
        "format": "󰘚 {usage}%",
        "tooltip": false
    },
    
    "memory": {
        "format": "󰍛 {used:0.1f}G"
    },
    
    "temperature": {
        "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
        "critical-threshold": 80,
        "format": "{icon} {temperatureC}°C",
        "format-icons": ["", "", ""]
    },
    
    "custom/gpu": {
        "exec": "cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo '0'",
        "format": "󰢮 {}%",
        "interval": 1
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": "󰝟",
        "format-icons": {
            "default": ["󰕿", "󰖀", "󰕾"]
        },
        "on-click": "pavucontrol"
    },
    
    "network": {
        "format-wifi": "󰤨 {signalStrength}%",
        "format-ethernet": "󰈀 Connected",
        "format-disconnected": "󰤭 Disconnected",
        "tooltip-format": "{ifname}: {ipaddr}"
    },
    
    "battery": {
        "states": {
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-icons": ["", "", "", "", ""]
    },
    
    "custom/power": {
        "format": "⏻",
        "on-click": "wlogout",
        "tooltip": false
    }
}
EOF

cat > ~/.config/waybar/style.css << 'EOF'
/* WehttamSnaps Waybar Style - TokyoNight violet-to-cyan */
* {
    font-family: 'JetBrainsMono Nerd Font', monospace;
    font-size: 13px;
    font-weight: bold;
}

window#waybar {
    background: linear-gradient(90deg, rgba(26, 27, 38, 0.9), rgba(16, 16, 29, 0.9));
    border-bottom: 3px solid #7aa2f7;
    color: #c0caf5;
}

#workspaces button {
    padding: 0 8px;
    background: transparent;
    color: #565f89;
    border: none;
    border-radius: 8px;
    margin: 0 2px;
}

#workspaces button.active {
    background: linear-gradient(45deg, #7aa2f7, #bb9af7);
    color: #1a1b26;
}

#workspaces button:hover {
    background: rgba(122, 162, 247, 0.3);
    color: #c0caf5;
}

.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#custom-arch {
    color: #7aa2f7;
    font-size: 16px;
    padding: 0 10px;
}

#window {
    color: #9ece6a;
    font-weight: normal;
}

#clock {
    color: #bb9af7;
    font-weight: bold;
}

#custom-gamemode {
    color: #f7768e;
    background: rgba(247, 118, 142, 0.1);
    padding: 0 10px;
    border-radius: 8px;
    margin: 0 5px;
}

#cpu, #memory, #temperature, #custom-gpu {
    color: #7dcfff;
    background: rgba(125, 207, 255, 0.1);
    padding: 0 10px;
    border-radius: 8px;
    margin: 0 2px;
}

#pulseaudio {
    color: #9ece6a;
    background: rgba(158, 206, 106, 0.1);
    padding: 0 10px;
    border-radius: 8px;
}

#network {
    color: #e0af68;
    background: rgba(224, 175, 104, 0.1);
    padding: 0 10px;
    border-radius: 8px;
}

#battery {
    color: #73daca;
    background: rgba(115, 218, 202, 0.1);
    padding: 0 10px;
    border-radius: 8px;
}

#battery.warning {
    color: #e0af68;
    background: rgba(224, 175, 104, 0.2);
}

#battery.critical {
    color: #f7768e;
    background: rgba(247, 118, 142, 0.2);
}

#custom-power {
    color: #f7768e;
    background: rgba(247, 118, 142, 0.1);
    padding: 0 10px;
    border-radius: 8px;
    margin-left: 5px;
}
EOF

# Rofi config
print_status "Creating Rofi configuration..."
mkdir -p ~/.config/rofi
cat > ~/.config/rofi/config.rasi << 'EOF'
/* WehttamSnaps Rofi Config - TokyoNight */
configuration {
    modi: "drun,window,run";
    font: "JetBrainsMono Nerd Font 12";
    show-icons: true;
    icon-theme: "Papirus-Dark";
    display-drun: "Apps";
    display-window: "Windows";
    display-run: "Run";
    drun-display-format: "{name}";
}

* {
    bg: #1a1b26;
    bg-alt: #24283b;
    fg: #c0caf5;
    fg-alt: #565f89;
    accent: #7aa2f7;
    accent-alt: #bb9af7;
    
    background-color: @bg;
    text-color: @fg;
}

window {
    transparency: "real";
    background-color: rgba(26, 27, 38, 0.9);
    border: 2px solid @accent;
    border-radius: 12px;
    width: 600px;
}

mainbox {
    children: [inputbar, listview];
    padding: 20px;
}

inputbar {
    children: [prompt, entry];
    background-color: @bg-alt;
    border-radius: 8px;
    padding: 8px;
    margin: 0 0 10px 0;
}

prompt {
    background-color: @accent;
    color: @bg;
    border-radius: 4px;
    padding: 4px 8px;
    font-weight: bold;
}

entry {
    placeholder: "Search...";
    placeholder-color: @fg-alt;
    padding: 4px 8px;
}

listview {
    lines: 8;
    columns: 1;
    scrollbar: false;
}

element {
    padding: 8px;
    border-radius: 6px;
}

element selected {
    background-color: linear-gradient(45deg, @accent, @accent-alt);
    color: @bg;
}

element-icon {
    size: 24px;
    margin: 0 8px 0 0;
}
EOF

# Terminal config
print_status "Configuring terminal..."
mkdir -p ~/.config/xfce4/terminal
cat > ~/.config/xfce4/terminal/terminalrc << 'EOF'
[Configuration]
ColorBackground=#1a1b26
ColorForeground=#c0caf5
ColorCursor=#c0caf5
ColorBold=#c0caf5
ColorBoldUseDefault=FALSE
ColorPalette=#15161e;#f7768e;#9ece6a;#e0af68;#7aa2f7;#bb9af7;#7dcfff;#a9b1d6;#414868;#f7768e;#9ece6a;#e0af68;#7aa2f7;#bb9af7;#7dcfff;#c0caf5
FontName=JetBrainsMono Nerd Font 11
BackgroundMode=TERMINAL_BACKGROUND_TRANSPARENT
BackgroundDarkness=0.10
EOF

# Set up ZSH with Starship
print_status "Configuring ZSH and Starship..."
chsh -s $(which zsh)

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

cat > ~/.zshrc << 'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git sudo archlinux)
source $ZSH/oh-my-zsh.sh

# Starship prompt
eval "$(starship init zsh)"

# Gaming aliases
alias gamemode='gamemoderun'
alias steam-native='steam -native'
alias lutris-debug='lutris -d'

# System aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias neo='neofetch'
alias fetch='fastfetch'

# Hyprland specific
alias hypr-reload='hyprctl reload'
alias waybar-restart='pkill waybar; waybar &'
EOF

# Starship config
cat > ~/.config/starship.toml << 'EOF'
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$nodejs\
$rust\
$golang\
$php\
$java\
$kotlin\
$haskell\
$python\
$docker_context\
$package\
$cmake\
$dart\
$deno\
$dotnet\
$elixir\
$elm\
$erlang\
$lua\
$nim\
$ocaml\
$perl\
$purescript\
$ruby\
$swift\
$terraform\
$vlang\
$vagrant\
$zig\
$nix_shell\
$conda\
$memory_usage\
$aws\
$gcloud\
$openstack\
$env_var\
$crystal\
$custom\
$sudo\
$cmd_duration\
$line_break\
$jobs\
$battery\
$time\
$status\
$character"""

[directory]
style = "bold cyan"
format = "[$path]($style)[$read_only]($read_only_style) "

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[➜](bold red)"

[git_branch]
symbol = "🌱 "
style = "bold purple"

[git_status]
style = "bold yellow"

[cmd_duration]
min_time = 4
show_milliseconds = false
disabled = false
style = "bold italic red"

[username]
style_user = "bold blue"
format = "[$user]($style) "
disabled = false
show_always = true

[hostname]
ssh_only = false
format = "on [$hostname](bold purple) "
disabled = false

[time]
disabled = false
format = "🕐 [$time]($style) "
style = "bold yellow"
EOF

# Gaming optimizations
print_status "Setting up gaming optimizations..."

# ZRAM
sudo tee /etc/systemd/zram-generator.conf << 'EOF'
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
fs-type = swap
EOF

# GameMode config
sudo mkdir -p /etc/gamemode
sudo tee /etc/gamemode/gamemode.ini << 'EOF'
[general]
reaper_freq=5
desiredgov=performance
defaultgov=powersave

[filter]
whitelist=steam
whitelist=lutris
whitelist=heroic
whitelist=gamescope

[gpu]
apply_gpu_optimisations=accept-responsibility
gpu_device=0
amd_performance_level=high

[custom]
start=notify-send "GameMode activated" && echo performance | sudo tee /sys/class/drm/card*/device/power_dpm_force_performance_level
end=notify-send "GameMode deactivated" && echo auto | sudo tee /sys/class/drm/card*/device/power_dpm_force_performance_level
EOF

# Mangohud config
mkdir -p ~/.config/MangoHud
cat > ~/.config/MangoHud/MangoHud.conf << 'EOF'
legacy_layout=false
horizontal
gpu_stats
gpu_temp
cpu_stats
cpu_temp
vram
ram
fps
frametime=0
hud_no_margin
table_columns=14
frame_timing=1
engine_version
vulkan_driver
wine
fps_limit=0,60,120,144
toggle_fps_limit=Shift_R+F1
position=top-left
text_color=FFFFFF
gpu_color=2e9762
cpu_color=2e97cb
vram_color=ad64c1
ram_color=c26693
engine_color=eb5b5b
io_color=a491d3
frametime_color=00ff00
background_color=020202
background_alpha=0.5
alpha=1.0
round_corners=0
EOF

# Create welcome app script
print_status "Creating welcome application..."
mkdir -p ~/Scripts
cat > ~/Scripts/wehttam-welcome.py << 'EOF'
#!/usr/bin/env python3

import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import os

class WehttamWelcome:
    def __init__(self, root):
        self.root = root
        self.root.title("WehttamSnaps Gaming Setup")
        self.root.geometry("800x600")
        self.root.configure(bg="#1a1b26")
        
        # Style
        style = ttk.Style()
        style.theme_use("clam")
        style.configure("Title.TLabel", foreground="#7aa2f7", background="#1a1b26", font=("JetBrainsMono Nerd Font", 16, "bold"))
        style.configure("Header.TLabel", foreground="#bb9af7", background="#1a1b26", font=("JetBrainsMono Nerd Font", 12, "bold"))
        style.configure("Normal.TLabel", foreground="#c0caf5", background="#1a1b26", font=("JetBrainsMono Nerd Font", 10))
        
        self.create_widgets()
    
    def create_widgets(self):
        # Title
        title = ttk.Label(self.root, text="🎮 WehttamSnaps Gaming Setup", style="Title.TLabel")
        title.pack(pady=20)
        
        # Notebook for tabs
        notebook = ttk.Notebook(self.root)
        notebook.pack(expand=True, fill="both", padx=20, pady=10)
        
        # Keybindings tab
        kb_frame = ttk.Frame(notebook)
        notebook.add(kb_frame, text="⌨️ Keybindings")
        self.create_keybindings_tab(kb_frame)
        
        # Quick Launch tab
        launch_frame = ttk.Frame(notebook)
        notebook.add(launch_frame, text="🚀 Quick Launch")
        self.create_launch_tab(launch_frame)
        
        # Settings tab
        settings_frame = ttk.Frame(notebook)
        notebook.add(settings_frame, text="⚙️ Settings")
        self.create_settings_tab(settings_frame)
        
        # System Info tab
        info_frame = ttk.Frame(notebook)
        notebook.add(info_frame, text="📊 System Info")
        self.create_info_tab(info_frame)
    
    def create_keybindings_tab(self, parent):
        scrollable_frame = tk.Frame(parent, bg="#1a1b26")
        scrollable_frame.pack(fill="both", expand=True, padx=10, pady=10)
        
        keybinds = [
            ("Essential", [
                ("Super + Return", "Open Terminal"),
                ("Super + Space", "App Launcher"),
                ("Super + E", "File Manager"),
                ("Super + Q", "Close Window"),
                ("Super + F", "Fullscreen"),
                ("Super + V", "Toggle Float")
            ]),
            ("Gaming", [
                ("Super + G", "Toggle GameMode"),
                ("Super + Shift + G", "Stop GameMode"),
                ("Print", "Screenshot Display"),
                ("Super + Print", "Screenshot Window"),
                ("Super + Shift + S", "Screenshot Region")
            ]),
            ("Workspaces", [
                ("Super + 1-9", "Switch Workspace"),
                ("Super + Shift + 1-9", "Move to Workspace"),
                ("Super + H/J/K/L", "Move Focus")
            ]),
            ("Audio/Media", [
                ("Volume Up/Down", "Adjust Volume"),
                ("Mute", "Toggle Mute"),
                ("Play/Pause", "Media Control")
            ])
        ]
        
        row = 0
        for category, binds in keybinds:
            header = ttk.Label(scrollable_frame, text=category, style="Header.TLabel")
            header.grid(row=row, column=0, columnspan=2, sticky="w", pady=(10,5))
            row += 1
            
            for key, desc in binds:
                key_label = ttk.Label(scrollable_frame, text=key, style="Normal.TLabel")
                desc_label = ttk.Label(scrollable_frame, text=desc, style="Normal.TLabel")
                key_label.grid(row=row, column=0, sticky="w", padx=(10,20))
                desc_label.grid(row=row, column=1, sticky="w")
                row += 1
    
    def create_launch_tab(self, parent):
        frame = tk.Frame(parent, bg="#1a1b26")
        frame.pack(fill="both", expand=True, padx=20, pady=20)
        
        apps = [
            ("🎮 Steam", "steam"),
            ("🎯 Lutris", "lutris"),
            ("🏆 Heroic", "heroic"),
            ("🎵 Spotify", "spotify"),
            ("💬 Discord", "discord"),
            ("🎥 OBS Studio", "obs"),
            ("📁 File Manager", "thunar"),
            ("🎨 Settings", "nwg-look"),
            ("🖥️ System Monitor", "htop"),
            ("📊 Performance", "btop")
        ]
        
        for i, (name, cmd) in enumerate(apps):
            btn = tk.Button(frame, text=name, bg="#7aa2f7", fg="#1a1b26", 
                           font=("JetBrainsMono Nerd Font", 10, "bold"),
                           command=lambda c=cmd: self.launch_app(c))
            btn.grid(row=i//3, column=i%3, padx=10, pady=10, sticky="ew")
        
        for i in range(3):
            frame.columnconfigure(i, weight=1)
    
    def create_settings_tab(self, parent):
        frame = tk.Frame(parent, bg="#1a1b26")
        frame.pack(fill="both", expand=True, padx=20, pady=20)
        
        settings = [
            ("🎨 GTK Themes", "nwg-look"),
            ("🖼️ Wallpapers", "azote"),
            ("🔊 Audio Settings", "pavucontrol"),
            ("⚡ GameMode Config", "gamemode"),
            ("📊 MangoHud Settings", "mangohud"),
            ("🖥️ Display Settings", "wdisplays"),
            ("⌨️ Waybar Config", "code ~/.config/waybar/config"),
            ("🎮 Hyprland Config", "code ~/.config/hypr/hyprland.conf")
        ]
        
        for i, (name, cmd) in enumerate(settings):
            btn = tk.Button(frame, text=name, bg="#bb9af7", fg="#1a1b26",
                           font=("JetBrainsMono Nerd Font", 10, "bold"),
                           command=lambda c=cmd: self.launch_app(c))
            btn.grid(row=i//2, column=i%2, padx=10, pady=10, sticky="ew")
        
        for i in range(2):
            frame.columnconfigure(i, weight=1)
    
    def create_info_tab(self, parent):
        frame = tk.Frame(parent, bg="#1a1b26")
        frame.pack(fill="both", expand=True, padx=20, pady=20)
        
        info_text = tk.Text(frame, bg="#24283b", fg="#c0caf5", 
                           font=("JetBrainsMono Nerd Font", 10))
        info_text.pack(fill="both", expand=True)
        
        try:
            result = subprocess.run(['fastfetch'], capture_output=True, text=True)
            info_text.insert("1.0", result.stdout)
        except:
            info_text.insert("1.0", "System information not available")
        
        info_text.config(state="disabled")
    
    def launch_app(self, cmd):
        try:
            subprocess.Popen(cmd.split())
        except Exception as e:
            messagebox.showerror("Error", f"Could not launch {cmd}: {str(e)}")

if __name__ == "__main__":
    root = tk.Tk()
    app = WehttamWelcome(root)
    root.mainloop()
EOF

chmod +x ~/Scripts/wehttam-welcome.py

# Create EWW game launcher
print_status "Creating EWW game launcher..."
mkdir -p ~/.config/eww
cat > ~/.config/eww/eww.yuck << 'EOF'
;; WehttamSnaps Gaming Launcher
(defwidget launcher []
  (box :class "launcher-box" :orientation "v" :space-evenly false :spacing 10
    (box :class "header" :orientation "h" :space-evenly false
      (label :class "title" :text "🎮 WehttamSnaps Gaming")
      (button :class "close-btn" :onclick "eww close launcher" "✕"))
    
    (box :class "games-grid" :orientation "v" :spacing 5
      (box :orientation "h" :spacing 10
        (button :class "game-btn steam" :onclick "steam &" :tooltip "Steam"
          (box :orientation "v" :spacing 5
            (label :class "game-icon" :text "")
            (label :class "game-name" :text "Steam")))
        (button :class "game-btn lutris" :onclick "lutris &" :tooltip "Lutris"
          (box :orientation "v" :spacing 5
            (label :class "game-icon" :text "")
            (label :class "game-name" :text "Lutris")))
        (button :class "game-btn heroic" :onclick "heroic &" :tooltip "Heroic"
          (box :orientation "v" :spacing 5
            (label :class "game-icon" :text "")
            (label :class "game-name" :text "Heroic"))))
      
      (box :orientation "h" :spacing 10
        (button :class "game-btn discord" :onclick "discord &" :tooltip "Discord"
          (box :orientation "v" :spacing 5
            (label :class "game-icon" :text "")
            (label :class "game-name" :text "Discord")))
        (button :class "game-btn spotify" :onclick "spotify &" :tooltip "Spotify"
          (box :orientation "v" :spacing 5
            (label :class "game-icon" :text "")
            (label :class "game-name" :text "Spotify")))
        (button :class "game-btn obs" :onclick "obs &" :tooltip "OBS"
          (box :orientation "v" :spacing 5
            (label :class "game-icon" :text "")
            (label :class "game-name" :text "OBS")))))))

(defwindow launcher
  :monitor 0
  :geometry (geometry :x "50%"
                     :y "50%"
                     :width "400px"
                     :height "300px"
                     :anchor "center")
  :stacking "fg"
  :reserve (struts :distance "40px" :side "top")
  :windowtype "dialog"
  :wm-ignore false
  (launcher))
EOF

cat > ~/.config/eww/eww.scss << 'EOF'
/* WehttamSnaps EWW Gaming Launcher */
* {
  all: unset;
  font-family: "JetBrainsMono Nerd Font";
}

.launcher-box {
  background: linear-gradient(135deg, rgba(26, 27, 38, 0.95), rgba(36, 40, 59, 0.95));
  border: 2px solid #7aa2f7;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
}

.header {
  margin-bottom: 15px;
}

.title {
  color: #7aa2f7;
  font-size: 18px;
  font-weight: bold;
  flex: 1;
}

.close-btn {
  color: #f7768e;
  background: rgba(247, 118, 142, 0.2);
  border-radius: 6px;
  padding: 5px 10px;
  font-weight: bold;
}

.close-btn:hover {
  background: rgba(247, 118, 142, 0.4);
}

.games-grid {
  min-width: 360px;
}

.game-btn {
  background: rgba(125, 207, 255, 0.1);
  border: 1px solid rgba(125, 207, 255, 0.3);
  border-radius: 8px;
  padding: 15px;
  min-width: 100px;
  transition: all 0.2s ease;
}

.game-btn:hover {
  background: rgba(125, 207, 255, 0.2);
  border-color: #7dcfff;
  transform: translateY(-2px);
}

.game-btn.steam { border-color: rgba(158, 206, 106, 0.5); }
.game-btn.steam:hover { border-color: #9ece6a; background: rgba(158, 206, 106, 0.2); }

.game-btn.lutris { border-color: rgba(224, 175, 104, 0.5); }
.game-btn.lutris:hover { border-color: #e0af68; background: rgba(224, 175, 104, 0.2); }

.game-btn.heroic { border-color: rgba(187, 154, 247, 0.5); }
.game-btn.heroic:hover { border-color: #bb9af7; background: rgba(187, 154, 247, 0.2); }

.game-btn.discord { border-color: rgba(115, 218, 202, 0.5); }
.game-btn.discord:hover { border-color: #73daca; background: rgba(115, 218, 202, 0.2); }

.game-btn.spotify { border-color: rgba(158, 206, 106, 0.5); }
.game-btn.spotify:hover { border-color: #9ece6a; background: rgba(158, 206, 106, 0.2); }

.game-btn.obs { border-color: rgba(247, 118, 142, 0.5); }
.game-btn.obs:hover { border-color: #f7768e; background: rgba(247, 118, 142, 0.2); }

.game-icon {
  font-size: 24px;
  color: #c0caf5;
}

.game-name {
  font-size: 12px;
  color: #c0caf5;
  font-weight: bold;
}
EOF

# Create systemd services
print_status "Setting up systemd services..."
mkdir -p ~/.config/systemd/user

cat > ~/.config/systemd/user/eww.service << 'EOF'
[Unit]
Description=EWW Daemon
PartOf=graphical-session.target

[Service]
ExecStart=/usr/bin/eww daemon --no-daemonize
Restart=on-failure

[Install]
WantedBy=default.target
EOF

# Add game launcher keybind to hyprland
print_status "Adding game launcher keybind..."
echo 'bind = $mainMod, A, exec, eww open launcher' >> ~/.config/hypr/hyprland.conf

# SDDM theme setup
print_status "Setting up SDDM login theme..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/theme.conf << 'EOF'
[Theme]
Current=sugar-candy

[General]
InputMethod=
EOF

sudo mkdir -p /usr/share/sddm/themes/sugar-candy
sudo tee /usr/share/sddm/themes/sugar-candy/theme.conf << 'EOF'
[General]
Background="background.jpg"
ScaleImageCropped=true
ScreenWidth=1920
ScreenHeight=1080
FullBlur=true
PartialBlur=false
BlurRadius=100
HaveFormBackground=true
FormPosition="center"
BackgroundImageHAlignment="center"
BackgroundImageVAlignment="center"
MainColor="#7aa2f7"
AccentColor="#bb9af7"
BackgroundColor="#1a1b26"
OverrideLoginButtonTextColor="#1a1b26"
InterfaceShadowSize=6
InterfaceShadowOpacity=0.6
RoundCorners=12
ScreenPadding=0
Font="JetBrainsMono Nerd Font"
FontSize=10
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
HeaderText="WehttamSnaps Gaming Setup"
TranslatePlaceholderUsername="Username"
TranslatePlaceholderPassword="Password"
TranslateShowPassword="Show Password"
TranslateLogin="Login"
TranslateLoginFailedWarning="Login Failed"
TranslateCapslockWarning="Caps Lock is on"
TranslateSession="Session"
TranslateSuspend="Suspend"
TranslateHibernate="Hibernate"
TranslateReboot="Restart"
TranslateShutdown="Shutdown"
EOF

# Download and set wallpapers
print_status "Setting up wallpapers..."
mkdir -p ~/Pictures/wallpapers
cd ~/Pictures/wallpapers

# Create hyprpaper config
cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/Pictures/wallpapers/gaming-wallpaper.jpg
wallpaper = ,~/Pictures/wallpapers/gaming-wallpaper.jpg
splash = false
ipc = off
EOF

# Create a script to generate a gradient wallpaper if none exists
cat > ~/Scripts/generate-wallpaper.py << 'EOF'
#!/usr/bin/env python3
import os
from PIL import Image, ImageDraw
import colorsys

def create_gradient_wallpaper():
    width, height = 1920, 1080
    image = Image.new("RGB", (width, height))
    draw = ImageDraw.Draw(image)
    
    # violet-to-cyan gradient colors
    start_color = (187, 154, 247)  # bb9af7 (violet)
    end_color = (125, 207, 255)    # 7dcfff (cyan)
    
    for y in range(height):
        r = int(start_color[0] + (end_color[0] - start_color[0]) * y / height)
        g = int(start_color[1] + (end_color[1] - start_color[1]) * y / height)
        b = int(start_color[2] + (end_color[2] - start_color[2]) * y / height)
        
        draw.line([(0, y), (width, y)], fill=(r, g, b))
    
    # Add some geometric elements
    draw.rectangle([width//4, height//4, 3*width//4, 3*height//4], 
                  outline=(26, 27, 38), width=3, fill=None)
    draw.ellipse([width//3, height//3, 2*width//3, 2*height//3], 
                outline=(36, 40, 59), width=2, fill=None)
    
    wallpaper_path = os.path.expanduser("~/Pictures/wallpapers/gaming-wallpaper.jpg")
    image.save(wallpaper_path, "JPEG", quality=95)
    print(f"Generated wallpaper: {wallpaper_path}")

if __name__ == "__main__":
    create_gradient_wallpaper()
EOF

chmod +x ~/Scripts/generate-wallpaper.py
python3 ~/Scripts/generate-wallpaper.py

# Create startup script
print_status "Creating startup script..."
cat > ~/Scripts/startup.sh << 'EOF'
#!/bin/bash
# WehttamSnaps Startup Script

# Start EWW daemon
eww daemon &

# Enable services
systemctl --user enable eww.service
systemctl --user start eww.service

# Set wallpaper
hyprpaper &

# Gaming optimizations
echo "Setting up gaming optimizations..."
sudo systemctl enable zramswap
sudo systemctl start zramswap

# AMD GPU optimizations
echo auto | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
echo high | sudo tee /sys/class/drm/card0/device/power_dpm_state

echo "WehttamSnaps setup complete! 🎮"
notify-send "WehttamSnaps Setup" "Gaming environment ready!" -i gamepad
EOF

chmod +x ~/Scripts/startup.sh

# Create brand assets directory structure
print_status "Creating brand assets directory..."
mkdir -p ~/WehttamSnaps-Brand/{logo,overlays,panels,banners,scenes,animated,editable,fonts}

# Create desktop entries
print_status "Creating desktop entries..."
mkdir -p ~/.local/share/applications

cat > ~/.local/share/applications/wehttam-welcome.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=WehttamSnaps Welcome
Comment=Gaming setup welcome screen
Exec=python3 /home/$USER/Scripts/wehttam-welcome.py
Icon=gamepad
Terminal=false
Categories=Game;Settings;
StartupNotify=true
EOF

cat > ~/.local/share/applications/eww-launcher.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Game Launcher
Comment=Quick game launcher
Exec=eww open launcher
Icon=applications-games
Terminal=false
Categories=Game;
StartupNotify=true
EOF

# Enable services
print_status "Enabling services..."
sudo systemctl enable sddm
sudo systemctl enable pipewire
sudo systemctl enable pipewire-pulse
systemctl --user enable pipewire
systemctl --user enable pipewire-pulse

# Final touches
print_status "Applying final configurations..."

# Set execute permissions on all scripts
chmod +x ~/Scripts/*.sh ~/Scripts/*.py

# Create quick access aliases
cat >> ~/.bashrc << 'EOF'
# WehttamSnaps aliases
alias welcome='python3 ~/Scripts/wehttam-welcome.py'
alias launcher='eww open launcher'
alias hypr-edit='code ~/.config/hypr/hyprland.conf'
alias waybar-edit='code ~/.config/waybar/config'
alias gaming-mode='gamemoderun'
EOF

print_status "Installation complete! 🎉"
echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                            INSTALLATION COMPLETE!                           ║"
echo "╠══════════════════════════════════════════════════════════════════════════════╣"
echo "║                                                                              ║"
echo "║  🎮 Your WehttamSnaps gaming setup is ready!                               ║"
echo "║                                                                              ║"
echo "║  Next steps:                                                                 ║"
echo "║  1. Reboot your system                                                       ║"
echo "║  2. Login with SDDM                                                          ║"
echo "║  3. Run: welcome (for the welcome app)                                      ║"
echo "║  4. Run: launcher (for game launcher)                                       ║"
echo "║  5. Super + A for quick game access                                          ║"
echo "║                                                                              ║"
echo "║  Key bindings:                                                               ║"
echo "║  • Super + Return: Terminal                                                  ║"
echo "║  • Super + Space: App launcher                                               ║"
echo "║  • Super + A: Game launcher                                                  ║"
echo "║  • Super + G: Toggle GameMode                                                ║"
echo "║                                                                              ║"
echo "║  Stream setup files are in: ~/WehttamSnaps-Brand/                          ║"
echo "║                                                                              ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

print_warning "Please reboot to complete the setup!"
echo -e "${GREEN}Enjoy your new gaming setup! 🚀${NC}"
