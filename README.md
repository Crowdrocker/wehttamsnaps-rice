# 🎮 WehttamSnaps Hyprland Gaming Setup

**A complete Arch Linux + Hyprland gaming and streaming environment with violet-to-cyan TokyoNight aesthetics**

![Hyprland](https://img.shields.io/badge/WM-Hyprland-7aa2f7?style=for-the-badge&logo=wayland&logoColor=white)
![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Gaming](https://img.shields.io/badge/Gaming-Ready-bb9af7?style=for-the-badge&logo=steam&logoColor=white)
![Streaming](https://img.shields.io/badge/Streaming-Optimized-f7768e?style=for-the-badge&logo=twitch&logoColor=white)

## 📋 Overview

This is a complete, production-ready Hyprland setup optimized for gaming and streaming on Arch Linux. Originally configured for a budget gaming PC (i5-4430 + RX 580 + 16GB RAM) but scales beautifully to higher-end hardware.

### ✨ Key Features

- **🎨 Beautiful TokyoNight Theme**: Violet-to-cyan gradient aesthetic throughout
- **🎮 Gaming Optimized**: GameMode, MangoHud, ZRAM, GPU optimizations
- **📺 Stream Ready**: OBS integration, brand asset organization, overlay support  
- **⚡ Performance Focused**: SSD-optimized configs, tearing allowance, low-latency settings
- **🎯 User-Friendly**: Welcome app, game launcher, intuitive keybindings
- **🔧 Fully Automated**: One-script installation with minimal user intervention

## 🖥️ System Requirements

### Minimum (Tested Configuration)
- **CPU**: Intel i5-4430 or equivalent
- **GPU**: AMD RX 580 or equivalent (8GB+ VRAM recommended)
- **RAM**: 16GB (works with 8GB but 16GB+ recommended)
- **Storage**: 1TB SSD (minimum 500GB)
- **OS**: Fresh Arch Linux installation

### Recommended
- **CPU**: Ryzen 5 3600 or newer / Intel i5-8400 or newer
- **GPU**: AMD RX 6600 XT+ / NVIDIA GTX 1660+ (with proper drivers)
- **RAM**: 32GB for streaming + gaming
- **Storage**: NVMe SSD for best performance

## 📦 What's Included

### Core Components
- **Window Manager**: Hyprland with custom gaming optimizations
- **Status Bar**: Waybar with gaming-specific modules (GameMode indicator, GPU stats)
- **Launcher**: Rofi + custom EWW game launcher
- **Terminal**: XFCE4 Terminal with TokyoNight theme
- **Shell**: ZSH with Oh My Zsh + Starship prompt
- **Login Manager**: SDDM with Sugar Candy theme

### Gaming Stack
- **Game Stores**: Steam, Lutris, Heroic Games Launcher
- **Performance**: GameMode, MangoHud, Gamescope
- **Optimization**: ZRAM swap, GPU performance profiles
- **Drivers**: Mesa, Vulkan, DXVK for compatibility

### Streaming & Content Creation
- **Recording**: OBS Studio with optimized settings
- **Communication**: Discord with gaming integrations
- **Music**: Spotify for background audio
- **Assets**: Organized brand directory structure

### Additional Tools
- **File Manager**: Thunar with plugins
- **Audio**: PipeWire + WirePlumber stack
- **Notifications**: Dunst with gaming-themed styling
- **Screenshots**: Hyprshot with region/window selection
- **Fonts**: JetBrains Mono Nerd Font, Orbitron, Exo 2

## 🚀 Installation

### Prerequisites
1. Fresh Arch Linux installation with base system
2. Network connectivity
3. Non-root user with sudo privileges

### Quick Install
```bash
# Clone or download the setup script
curl -L -o wehttam-setup.sh (https://github.com/Crowdrocker/wehttamsnaps-rice.git)
chmod +x wehttam-setup.sh
./wehttam-setup.sh
```

### Manual Installation
If you prefer to review before running:
```bash
# Download and inspect the script first
wget [YOUR_SCRIPT_URL] -O wehttam-setup.sh
less wehttam-setup.sh  # Review the script
chmod +x wehttam-setup.sh
./wehttam-setup.sh
```

The installation takes 15-30 minutes depending on your internet connection and hardware.

## ⌨️ Key Bindings

### Essential Controls
| Keybind | Action |
|---------|--------|
| `Super + Return` | Open Terminal |
| `Super + Space` | App Launcher (Rofi) |
| `Super + A` | Game Launcher (EWW) |
| `Super + E` | File Manager |
| `Super + Q` | Close Window |
| `Super + F` | Fullscreen Toggle |
| `Super + V` | Float Toggle |

### Gaming Specific
| Keybind | Action |
|---------|--------|
| `Super + G` | Enable GameMode |
| `Super + Shift + G` | Disable GameMode |
| `Print` | Screenshot Display |
| `Super + Print` | Screenshot Window |
| `Super + Shift + S` | Screenshot Region |

### Workspace Management
| Keybind | Action |
|---------|--------|
| `Super + 1-9` | Switch to Workspace |
| `Super + Shift + 1-9` | Move Window to Workspace |
| `Super + H/J/K/L` | Move Focus (Vim-style) |

### Audio & Media
| Keybind | Action |
|---------|--------|
| `Volume Up/Down` | Adjust System Volume |
| `Mute` | Toggle Audio Mute |
| `Media Keys` | Control Spotify/Media |

## 🎮 Gaming Features

### Performance Optimizations
- **GameMode**: Automatic CPU/GPU performance scaling
- **MangoHud**: Real-time performance overlay with FPS, temps, usage
- **ZRAM**: Compressed swap for better memory management  
- **Immediate Window Rules**: Eliminates input lag for games
- **Tearing Support**: Reduced latency for competitive gaming

### Game Launcher Integration
- Quick access to Steam, Lutris, Heroic Games Launcher
- Automatic workspace assignment (Steam → WS5, Lutris → WS6)
- GameMode status indicator in Waybar
- One-click game launching via EWW overlay

### Streaming Optimizations
- OBS Studio with scene templates
- Discord integration for chat overlay
- Spotify controls for background music
- Organized brand assets folder structure
- Low-latency audio pipeline

## 🎨 Customization

### Color Scheme (TokyoNight Variant)
- **Primary**: `#7aa2f7` (Blue)
- **Secondary**: `#bb9af7` (Purple/Violet) 
- **Accent**: `#7dcfff` (Cyan)
- **Background**: `#1a1b26` (Dark Navy)
- **Surface**: `#24283b` (Lighter Navy)
- **Text**: `#c0caf5` (Light Blue-Gray)

### Wallpaper
The script generates a custom violet-to-cyan gradient wallpaper. You can replace it with your own:
```bash
# Replace the generated wallpaper
cp your-wallpaper.jpg ~/Pictures/wallpapers/gaming-wallpaper.jpg
# Reload Hyprpaper
hyprctl dispatch exec hyprpaper
```

### Waybar Customization
Edit `~/.config/waybar/config` and `~/.config/waybar/style.css` for status bar modifications.

### Hyprland Tweaks
Main config: `~/.config/hypr/hyprland.conf`
- Window rules for specific games
- Animation preferences
- Workspace layouts
- Keybinding modifications

## 📊 System Monitoring

### Built-in Monitoring
- **Waybar Modules**: CPU, Memory, GPU, Temperature
- **GameMode Indicator**: Shows when gaming optimizations are active
- **MangoHud Overlay**: In-game performance metrics
- **System Info App**: Fastfetch integration in welcome screen

### Performance Tuning
The setup includes several performance monitoring tools:
```bash
btop          # Beautiful system monitor
htop          # Traditional system monitor  
fastfetch     # System information
mangohud      # Gaming performance overlay
```

## 🗂️ Directory Structure

```
~/
├── .config/
│   ├── hypr/           # Hyprland configuration
│   ├── waybar/         # Status bar config
│   ├── rofi/           # App launcher
│   ├── eww/            # Game launcher widget
│   └── MangoHud/       # Performance overlay
├── Scripts/
│   ├── wehttam-welcome.py    # Welcome application
│   ├── startup.sh            # System startup script
│   └── generate-wallpaper.py # Wallpaper generator
├── Pictures/wallpapers/      # Background images
└── WehttamSnaps-Brand/       # Streaming assets
    ├── logo/           # Brand logos
    ├── overlays/       # Stream overlays  
    ├── panels/         # Info panels
    ├── banners/        # Channel banners
    ├── scenes/         # OBS scenes
    ├── animated/       # Animated elements
    ├── editable/       # Source files
    └── fonts/          # Brand fonts
```

## 🛠️ Troubleshooting

### Common Issues

**Steam games not launching:**
```bash
# Enable Steam Proton for all games
steam -console
# In Steam console: enable_proton_for_all_titles 1
```

**Audio issues:**
```bash
# Restart audio services
systemctl --user restart pipewire pipewire-pulse
```

**GameMode not working:**
```bash
# Check GameMode status
gamemoded -s
# Manually start GameMode daemon
sudo systemctl start gamemode
```

**Low FPS in games:**
```bash
# Check GPU performance level
cat /sys/class/drm/card0/device/power_dpm_force_performance_level
# Force high performance
echo performance | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
```

**Waybar not loading:**
```bash
# Restart Waybar
pkill waybar && waybar &
# Check configuration
waybar --log-level debug
```

### Performance Tips

1. **SSD Optimization**: Ensure games are installed on SSD, not HDD
2. **ZRAM Configuration**: Verify ZRAM is active with `zramctl`
3. **GPU Drivers**: Keep AMD/NVIDIA drivers updated
4. **Game-Specific**: Use MangoHud to identify bottlenecks
5. **Streaming**: Use hardware encoding when available

## 🤝 Contributing

### Reporting Issues
- Include system specs (CPU, GPU, RAM)
- Describe the problem with steps to reproduce
- Include relevant log outputs
- Mention if it's gaming-related or general system

### Sharing Improvements
- Fork the repository
- Test changes on similar hardware
- Document any new features
- Submit pull request with detailed description

## 📺 Streaming Integration

### OBS Studio Setup
The installation includes OBS with optimized settings for:
- **Hardware encoding** (AMD/NVIDIA)
- **Low-latency streaming**  
- **Game capture** optimizations
- **Audio mixing** for game + mic + music

### Brand Assets Organization
```
WehttamSnaps-Brand/
├── logo/               # Channel logos (PNG, SVG)
├── overlays/           # Stream overlays
├── panels/             # Information panels  
├── banners/            # Social media banners
├── scenes/             # OBS scene collections
├── animated/           # GIF animations
├── editable/           # Source files (PSD, AI)
└── fonts/              # Brand typography
```

## 🎯 Workspaces Layout

The setup includes an organized workspace layout:

| Workspace | Purpose | Auto-assigned Apps |
|-----------|---------|-------------------|
| 1 | General/Terminal | Default workspace |
| 2 | Web Browser | Firefox, Chromium |
| 3 | Development | VSCode, editors |
| 4 | Communication | Discord, chat apps |
| 5 | Gaming Store | Steam client |
| 6 | Game Launchers | Lutris, Heroic |
| 7 | Streaming | OBS Studio |
| 8 | Music | Spotify |
| 9 | File Management | Thunar, archives |
| 10 | System Tools | Settings, monitors |

## 📝 License

This configuration is open source and available under the MIT License. Feel free to use, modify, and distribute.

## 🙏 Acknowledgments

- **Hyprland Community** - For the amazing window manager
- **TokyoNight Theme** - For the beautiful color scheme inspiration  
- **Arch Linux Community** - For the robust base system
- **Gaming on Linux Community** - For compatibility tools and support

## 📞 Support

- **GitHub Issues**: For bug reports and feature requests
- **Discord**: WehttamSnaps community server
- **Twitch**: Live troubleshooting and demos
- **Reddit**: r/hyprland, r/unixporn for community support

---

**⭐ If this setup helped you, please star the repository and share it with other gamers!**

*Built with ❤️ for the Linux gaming community*
