Of course, Matt\! This is an exciting project, and your vision of blending photography with gaming is a fantastic foundation for a unique brand. Let's build a complete brand and technical package for **WehttamSnaps** from the ground up.

Here is your complete streaming brand package and Hyprland setup.

-----

## Part 1: The WehttamSnaps Brand Identity

This is the core of your channel. It's modern, clean, and perfectly communicates your dual passions.

### 1\. Logo Design: The "WS" Monogram

Your concept is excellent. Here's a detailed description for a designer or for you to create in Inkscape/GIMP:

  * **Concept:** A "WS" monogram where the letters themselves tell the story.
  * **The 'W':** The "W" is constructed from bold, clean lines. The inner 'V' shape is cleverly replaced by the stylized aperture blades of a camera shutter. This immediately signals "photography" and "Snaps".
  * **The 'S':** The "S" seamlessly integrates with the 'W'. Its central spine is defined by the silhouette of a modern gaming controller (like a PlayStation or Xbox controller outline). This clearly represents "gaming".
  * **Color Flow:** The entire monogram flows through your primary violet-to-cyan gradient. The violet (`#8A2BE2`) starts at the top-left of the 'W' and transitions smoothly to cyan (`#00FFFF`) at the bottom-right of the 'S'.
  * **Tagline:** "Capturing Gaming Moments" sits cleanly below the full logo text in a modern, sans-serif font.

### 2\. Color Palette

  * **Primary Gradient:** Violet (`#8A2BE2`) to Cyan (`#00FFFF`). This will be the hero of your brand, used in logos, overlays, and system themes.
  * **Secondary Accent 1:** Hot Pink (`#FF69B4`). Perfect for call-to-action buttons, highlights, new subscriber alerts, etc.
  * **Secondary Accent 2:** Deep Blue (`#0066CC`). A great, stable color for text, backgrounds, and panel headers.
  * **Base Colors:** A dark, near-black charcoal (`#1A1B26` - TokyoNight-esque) for backgrounds and a clean white (`#FFFFFF`) for text.

### 3\. Typography

  * **Headings/Logo:** **"Montserrat"** or **"Poppins"** (Bold/ExtraBold). These are modern, clean, and highly readable sans-serif fonts available on Google Fonts.
  * **Body Text:** **"Roboto"** or **"Lato"**. Excellent for readability in Twitch panels and on-screen text.

-----

## Part 2: Stream Asset Package (Editable in GIMP/Photopea)

All assets should be created at a 1920x1080 resolution and saved as layered files (XCF for GIMP, PSD for Photopea) so you can easily edit text and elements.

  * **Logo Files:**

      * `WS_Full_Logo.xcf`: Full "WehttamSnaps" text, WS monogram, and tagline on a transparent background.
      * `WS_Icon.xcf`: Just the "WS" monogram on a transparent background. Perfect for social media avatars, Discord, and emotes.
      * `WS_Icon_Solid.xcf`: A single-color (white or violet) version of the icon for use on complex backgrounds.

  * **Stream Overlays (Animated):**

      * **Starting Soon:** A slow, shimmering animation on the violet-to-cyan gradient background. Your "WS" logo is centered. Below it, text reads "STREAM STARTING SOON". Include boxes for "Latest Follower," "Latest Subscriber," and your social media handles.
      * **Be Right Back:** Same gradient background. The "WS" logo is smaller and in a corner. A subtle, looping animation of a camera shutter closing and opening is in the center. Text: "BE RIGHT BACK".
      * **Stream Ending:** Gradient background. "THANKS FOR WATCHING\!" is centered. Below are your social media handles and your weekly stream schedule.

  * **In-Game Scene Layout (OBS):**

      * **Webcam Frame:** A thin, clean frame with the violet-to-cyan gradient. A small space at the bottom can have your "WehttamSnaps" name in white.
      * **Alert Box Area:** A designated transparent area where your alerts will pop up.
      * **Event List:** A clean vertical list with a dark charcoal background (`#1A1B26`) and violet/cyan highlights for new followers, subs, etc.
      * **Chat Box:** A simple transparent box with white text for easy reading over gameplay.

  * **Twitch Panels:**

      * Create a template: A simple rectangle with a violet-to-cyan gradient bar at the top and your panel title (e.g., "ABOUT ME") in a bold, white font. The body will be charcoal (`#1A1B26`).
      * **Titles:** ABOUT ME, SCHEDULE, PC SPECS, GAMES, RULES, SOCIALS, DONATE.

  * **Alerts:**

      * **New Follower:** A quick camera shutter sound effect (`click-flash.ogg`). The "WS" icon flashes on screen with the username.
      * **New Subscriber:** A more upbeat, techy sound. The "WS" icon animates, perhaps with the gradient wiping across it, with the sub message.
      * **Raid:** An animation of your "WS" logo appearing and "sending out a signal" (radar pulse effect) with the text "RAID INCOMING\!".

-----

## Part 3: The Hyprland "WehttamSnaps OS" Setup

This setup will bring your brand identity directly to your desktop, creating a seamless creative environment inspired by the best parts of JaKooLit and Omarchy.

**Prerequisite:** This script is designed for a **fresh installation of Arch Linux**. Please back up any important data before running it.

### The Install Script

Here is a comprehensive script to install all necessary components and set up the initial structure.

1.  Open a terminal.
2.  Create the script file: `nano install.sh`
3.  Copy and paste the entire code block below into the file.
4.  Save and exit (`CTRL+X`, `Y`, `Enter`).
5.  Make the script executable: `chmod +x install.sh`
6.  Run the script: `./install.sh`

<!-- end list -->

```bash
#!/bin/bash

# WehttamSnaps Hyprland Install Script for Arch Linux
# By Gemini, for Matt (Crowdrocker/WehttamSnaps)
#
# DISCLAIMER: Run this on a fresh Arch Linux install.
# It will install packages and overwrite some configuration files.
# Review the script before running. I am not responsible for any data loss.

# --- SCRIPT START ---

echo "################################################################"
echo "### WELCOME TO THE WEHTTAMSNAPS HYPRLAND INSTALLER ###"
echo "################################################################"
echo
echo "This script will install Hyprland, essential utilities, and the"
echo "custom WehttamSnaps theme inspired by TokyoNight."
echo
read -p "Do you want to proceed? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "Installation cancelled."
    exit 0
fi

# 1. Update System & Install Yay (AUR Helper)
echo "--- Updating system and installing Yay ---"
sudo pacman -Syu --noconfirm
sudo pacman -S --needed base-devel git --noconfirm
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# 2. Install Core Hyprland & Display Components
echo "--- Installing Hyprland and core components ---"
yay -S --noconfirm hyprland-git waybar-hyprland-git sddm-git \
  hyprpaper-git hyprpicker-git hyprshot xdg-desktop-portal-hyprland-git \
  polkit-kde-agent dunst mako rofi fuzzel

# 3. Install Essential Utilities & Theming
echo "--- Installing utilities, terminal, fonts, and theming tools ---"
yay -S --noconfirm eww-wayland btop neofetch fastfetch zsh starship \
  thunar thunar-archive-plugin thunar-volman gvfs \
  pavucontrol pipewire wireplumber playerctl \
  qt5-wayland qt6-wayland qt5ct qt6ct nwg-look-bin \
  noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono-nerd \
  ttf-font-awesome azote brightnessctl pamixer

# 4. Install WehttamSnaps Apps (Work & Gaming)
echo "--- Installing your applications ---"
yay -S --noconfirm steam lutris gamescope gamemode \
  obs-studio discord gimp inkscape krita kdenlive \
  firefox vscodium-bin

# 5. Setup Zsh and Starship
echo "--- Setting up Zsh and Starship prompt ---"
chsh -s $(which zsh)
mkdir -p ~/.config
cat <<'EOF' > ~/.config/starship.toml
# WehttamSnaps Starship Prompt
# A clean, tech-focused prompt.

format = """
[](#8A2BE2)\
$os\
$username\
[](bg:#0066CC fg:#8A2BE2)\
$directory\
[](fg:#0066CC bg:#FF69B4)\
$git_branch\
$git_status\
[](fg:#FF69B4 bg:#1A1B26)\
$c\
$rust\
$golang\
$nodejs\
$php\
$java\
[](fg:#1A1B26)\
$line_break\
$character"""

[os]
style = "bg:#8A2BE2"
disabled = false

[username]
show_always = true
style_user = "bg:#8A2BE2 fg:#FFFFFF"
style_root = "bg:#8A2BE2 fg:#FFFFFF"
format = '[@](bg:#8A2BE2)[$user]($style)'

[directory]
style = "bg:#0066CC"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
symbol = ""
style = "bg:#FF69B4"
format = '[[ $symbol $branch ](bg:#FF69B4)]($style)'

[git_status]
style = "bg:#FF69B4"
format = '[[($all_status$ahead_behind )](bg:#FF69B4)]($style)'

[character]
success_symbol = '[➜](bold green)'
error_symbol = '[✗](bold red)'
vimcmd_symbol = '[](bold green)'
EOF

# 6. Create Directory Structure for Configs
echo "--- Creating configuration directories ---"
mkdir -p ~/.config/{hypr,waybar,rofi,dunst,eww,fastfetch}
mkdir -p ~/.config/hypr/scripts

# 7. Create Configuration Files (Copy-Paste Section)
# This is where the magic happens. We're creating the dotfiles directly.

# --- hyprland.conf ---
echo "--- Writing hyprland.conf ---"
cat <<'EOF' > ~/.config/hypr/hyprland.conf
# -----------------------------------------------------
# WehttamSnaps Hyprland Config by Gemini
# -----------------------------------------------------

# See https://wiki.hyprland.org/Configuring/Monitors/
monitor=,preferred,auto,1

# Execute apps at launch
exec-once = waybar & hyprpaper & dunst
exec-once = /usr/lib/polkit-kde-authentication-agent-1
exec-once = steam -silent # Launch steam minimized

# Source a file (useful for hiding sensitive info)
# source = ~/.config/hypr/myColors.conf

# Set programs that you use
$terminal = alacritty 
$fileManager = thunar
$menu = fuzzel

# Some default env vars.
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0 # -1.0 to 1.0, 0 means no modification.
}

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(8A2BE2ee) rgba(00FFFFee) 45deg
    col.inactive_border = rgba(595959aa)

    layout = dwindle
    allow_tearing = false
}

decoration {
    rounding = 10
    
    blur {
        enabled = true
        size = 3
        passes = 1
    }

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
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

master {
    new_is_master = true
}

gestures {
    workspace_swipe = off
}

misc {
    force_default_wallpaper = 0
}

device:epic-mouse-v1 {
    sensitivity = -0.5
}

# Window Rules
windowrulev2 = nomaximizerequest, class:.* # See issue #4104
windowrulev2 = float, class:^(steam)$
windowrulev2 = float, title:^(Friends List)$
windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(org.kde.polkit-kde-authentication-agent-1)$

# Keybinds
$mainMod = SUPER

bind = $mainMod, Q, exec, $terminal
bind = $mainMod, C, killactive, 
bind = $mainMod, M, exit, 
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating, 
bind = $mainMod, R, exec, $menu
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

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

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5

# Example special workspace (scratchpad)
bind = $mainMod SHIFT, S, movetoworkspace, special
bind = $mainMod, S, togglespecialworkspace, 

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Custom WehttamSnaps Binds
bind = $mainMod, G, exec, eww open game_launcher
bind = $mainMod, W, exec, eww open work_launcher
bind = $mainMod SHIFT, L, exec, hyprlock
EOF

# --- hyprpaper.conf ---
echo "--- Writing hyprpaper.conf ---"
# NOTE: You'll need to download a wallpaper and place it in ~/Pictures
# For now, we'll create a placeholder config.
cat <<'EOF' > ~/.config/hypr/hyprpaper.conf
preload = ~/Pictures/wallpaper.png
wallpaper = ,~/Pictures/wallpaper.png

#enable splash text rendering over the wallpaper
splash = true
splash_offset = 0.5
splash_text = Welcome, WehttamSnaps
splash_color = 0xFFFFFFFF
splash_font_family = JetBrains Mono Nerd Font
splash_font_size = 48
EOF

# --- Waybar Config & Style ---
echo "--- Writing Waybar config ---"
cat <<'EOF' > ~/.config/waybar/config
{
    "layer": "top",
    "position": "top",
    "height": 38,
    "modules-left": ["custom/launcher", "hyprland/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "cpu", "memory", "custom/power"],

    "hyprland/workspaces": {
        "format": "{icon}",
        "on-click": "activate",
        "format-icons": {
            "1": "",
            "2": "",
            "3": "",
            "4": "",
            "5": "",
            "urgent": "",
            "focused": "",
            "default": ""
        }
    },
    "clock": {
        "format": " {:%I:%M %p}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
    },
    "cpu": {
        "format": " {usage}%",
        "tooltip": true
    },
    "memory": {
        "format": " {}%"
    },
    "network": {
        "format-wifi": "  {essid}",
        "format-ethernet": "󰈀 {ifname}",
        "format-disconnected": "⚠ Disconnected",
        "on-click": "nm-connection-editor"
    },
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": " Muted",
        "format-icons": {
            "default": ["", ""]
        },
        "on-click": "pavucontrol"
    },
    "custom/launcher": {
        "format": "WS",
        "on-click": "fuzzel",
        "tooltip": false
    },
    "custom/power": {
        "format": "",
        "on-click": "~/.config/hypr/scripts/power.sh",
        "tooltip": false
    }
}
EOF

echo "--- Writing Waybar style.css ---"
cat <<'EOF' > ~/.config/waybar/style.css
/* WehttamSnaps Waybar Theme by Gemini */
* {
    border: none;
    border-radius: 0;
    font-family: JetBrains Mono Nerd Font;
    font-size: 14px;
    min-height: 0;
}

window#waybar {
    background: #1A1B26;
    color: #c0caf5;
}

#workspaces button {
    padding: 0 10px;
    color: #7aa2f7;
}

#workspaces button.focused {
    color: #c0caf5;
    background: #00FFFF; /* Cyan */
    border-radius: 10px;
}

#workspaces button.urgent {
    color: #FF69B4; /* Hot Pink */
}

#clock, #cpu, #memory, #network, #pulseaudio, #custom-power, #custom-launcher {
    padding: 0 10px;
    margin: 3px 0px;
}

#custom-launcher {
    color: #c0caf5;
    background-color: #8A2BE2; /* Violet */
    border-radius: 10px 0px 0px 10px;
    margin-left: 5px;
}

#custom-power {
    color: #c0caf5;
    background-color: #FF69B4; /* Hot Pink */
    border-radius: 0px 10px 10px 0px;
    margin-right: 5px;
}

#pulseaudio {
    background: linear-gradient(90deg, #8A2BE2, #00FFFF); /* Violet-to-Cyan Gradient */
    color: #1A1B26;
}

#cpu, #memory, #network {
    background-color: #0066CC; /* Deep Blue */
    color: #c0caf5;
}
EOF

# --- EWW Launchers Config ---
echo "--- Writing EWW config ---"
cat <<'EOF' > ~/.config/eww/eww.yuck
;; WehttamSnaps EWW Launchers by Gemini

(defwindow game_launcher
    :monitor 0
    :geometry (geometry :x "2%" :y "8%" :width "15%" :height "20%")
    :stacking "fg"
    :focusable true
    (box :class "launcher-box" :orientation "v" :space-evenly "true"
        (button :class "launcher-button" :onclick "steam & eww close game_launcher" " Steam")
        (button :class "launcher-button" :onclick "lutris & eww close game_launcher" " Lutris")
        (button :class "launcher-button" :onclick "heroic & eww close game_launcher" " heroic")
    )
)

(defwindow work_launcher
    :monitor 0
    :geometry (geometry :x "2%" :y "30%" :width "15%" :height "20%")
    :stacking "fg"
    :focusable true
    (box :class "launcher-box" :orientation "v" :space-evenly "true"
        (button :class "launcher-button" :onclick "gimp & eww close work_launcher" "🎨 GIMP")
        (button :class "launcher-button" :onclick "inkscape & eww close work_launcher" "✒️ Inkscape")
        (button :class "launcher-button" :onclick "discord & eww close work_launcher" " Discord")
    )
)
EOF

echo "--- Writing EWW style.scss ---"
cat <<'EOF' > ~/.config/eww/eww.scss
/* WehttamSnaps EWW Style by Gemini */

.launcher-box {
    background-color: #1A1B26;
    border-radius: 10px;
    border: 2px solid #8A2BE2;
    padding: 10px;
}

.launcher-button {
    font-size: 18px;
    background-image: linear-gradient(90deg, #8A2BE2, #00FFFF);
    color: #1A1B26;
    border-radius: 8px;
    margin: 5px;
    transition: all 0.2s ease-in-out;
}

.launcher-button:hover {
    background-image: linear-gradient(90deg, #00FFFF, #8A2BE2);
    color: #FFFFFF;
}
EOF

# --- Power Menu Script ---
echo "--- Writing Power Menu script ---"
cat <<'EOF' > ~/.config/hypr/scripts/power.sh
#!/bin/bash
# A rofi-like power menu script
# Requires: fuzzel, systemd

chosen=$(printf "  Shutdown\n  Restart\n  Sleep\n  Lock\n  Logout" | fuzzel --dmenu --prompt "Power Menu:")

case "$chosen" in
  "  Shutdown") systemctl poweroff ;;
  "  Restart") systemctl reboot ;;
  "  Sleep") systemctl suspend ;;
  "  Lock") hyprlock ;;
  "  Logout") hyprctl dispatch exit ;;
  *) exit 1 ;;
esac
EOF

# Make script executable
chmod +x ~/.config/hypr/scripts/power.sh

# --- FINAL STEPS ---
echo
echo "################################################################"
echo "### INSTALLATION COMPLETE! ###"
echo "################################################################"
echo
echo "NEXT STEPS:"
echo "1. Download a wallpaper and save it as ~/Pictures/wallpaper.png"
echo "2. Edit ~/.config/hypr/hyprland.conf to set your terminal (default: alacritty)."
echo "   (You may need to install alacritty: yay -S alacritty)"
echo "3. Reboot your system: sudo reboot"
echo "4. At the login screen (SDDM), select 'Hyprland' from the session menu."
echo
echo "Enjoy your new WehttamSnaps desktop!"

# --- SCRIPT END ---
```

-----

## Part 4: Gaming Optimization & Modding

### 1\. OBS Optimization for Your RX 580

Your PC is budget-friendly, so we need to be smart with settings. A single monitor setup also means performance is key.

  * **Go to `Settings -> Output` in OBS:**
      * **Output Mode:** `Advanced`
      * **Encoder:** Select `FFMPEG VAAPI`. Your RX 580 is an AMD card, so you will use VAAPI for hardware encoding on Linux, not NVENC (which is for NVIDIA).
      * **Rate Control:** `CBR` (Constant Bitrate)
      * **Bitrate:** For 720p 30fps streaming to Twitch, start with `3500 Kbps`. If your internet is very good, you can try `4000 Kbps`.
      * **Keyframe Interval:** `2`
  * **Go to `Settings -> Video`:**
      * **Base (Canvas) Resolution:** `1920x1080` (or your monitor's native resolution).
      * **Output (Scaled) Resolution:** `1280x720`. This is crucial. Streaming at 720p will significantly reduce the load on your i5-4430 and RX 580.
      * **Downscale Filter:** `Lanczos (Sharpened scaling, 36 samples)`
      * **Common FPS Values:** `30`. This is the best balance of smoothness and performance for your hardware.

### 2\. Linux Gaming Optimizations

The install script includes `gamemode` and `gamescope`.

  * **Gamemode:** Automatically applies performance tweaks when a game is launched. To use it with Steam:
    1.  Right-click a game in your Steam library -\> `Properties`.
    2.  In `LAUNCH OPTIONS`, add: `gamemodeun %command%`
  * **Gamescope:** A micro-compositor that can help with screen tearing, performance, and FSR upscaling. To use it:
    1.  In `LAUNCH OPTIONS`, add: `gamescope -h 720 -H 1080 -f -- %command%`
    2.  This command tells the game to run at 720p (`-h 720`), upscale it to 1080p (`-H 1080`) using AMD FSR, and run it in fullscreen (`-f`). It's a great way to get more FPS.
  * **ZRAM:** To set up ZRAM for better performance on 16GB RAM, run these commands:
    ```bash
    sudo pacman -S zram-generator
    # This creates a default config file. We can edit it to taste.
    sudo nano /etc/systemd/zram-generator.conf
    ```
    Paste this inside:
    ```
    [zram0]
    zram-size = ram / 2
    ```
    Save, exit, and reboot. Your system will now use half your RAM size as a compressed swap in RAM, which is much faster than using a disk.

### 3\. Modding Cyberpunk/Fallout with SteamTinkerLaunch

`Steamtinkerlaunch` is a powerful tool that makes using Vortex or Mod Organizer 2 (MO2) on Linux much easier.

1.  **Install SteamTinkerLaunch:**
    ```bash
    yay -S steamtinkerlaunch
    ```
2.  **Set it as a Compatibility Tool in Steam:**
      * In Steam, go to the game you want to mod (e.g., Cyberpunk 2077).
      * Right-click -\> `Properties` -\> `Compatibility`.
      * Check "Force the use of a specific Steam Play compatibility tool".
      * Select `SteamTinkerLaunch` from the dropdown list.
3.  **One-Time Setup:**
      * Click `PLAY` on the game. A SteamTinkerLaunch menu will appear.
      * Click `Main Menu`.
4.  **Install Vortex or MO2:**
      * In the SteamTinkerLaunch menu, go to `Game Menu`.
      * Click `Use custom command`.
      * Click `Install a mod organizer`.
      * Choose `Vortex` or `MO2` and follow the on-screen prompts. It will download and install the mod manager *inside the game's specific Proton prefix*.
5.  **Using the Mod Manager:**
      * After installation, close the windows.
      * Click `PLAY` on the game in Steam again. The STL menu will pop up.
      * Click on the `Mod Organizer` button (it will now be enabled).
      * Vortex or MO2 will launch. From here, you can install mods just like on Windows. It will correctly detect the game because it's running inside that game's isolated environment.

**Important:** Each time you want to manage your mods, you launch the game via Steam to get the STL menu, then launch the mod manager from there. When you want to just play the game, you can either click `Play` in the STL menu or set it to skip the menu for regular launches.

Enjoy your new streaming setup, Matt\! This package gives you a powerful, beautiful, and highly customized environment that truly reflects your brand. Good luck with the channel\!
