#!/bin/bash
# ===================================================================
# WehttamSnaps Plymouth Boot Theme - Animation Script
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# This creates the Plymouth script for animated spinning logo
# ===================================================================

# Plymouth script content (wehttamsnaps.script)
cat << 'PLYMOUTH_SCRIPT'
# WehttamSnaps Plymouth Theme
# Animated spinning camera aperture logo

# ===================================================================
# CONFIGURATION
# ===================================================================

# Colors (WehttamSnaps/Catppuccin Mocha)
bg_color_r = 0.118;  # 1e
bg_color_g = 0.118;  # 1e
bg_color_b = 0.180;  # 2e

primary_color_r = 0.651;  # a6
primary_color_g = 0.890;  # e3
primary_color_b = 0.631;  # a1

accent_color_r = 0.537;  # 89
accent_color_g = 0.706;  # b4
accent_color_b = 0.980;  # fa

text_color_r = 0.804;  # cd
text_color_g = 0.839;  # d6
text_color_b = 0.957;  # f4

# Animation settings
rotation_speed = 0.05;  # Speed of logo rotation
logo_scale = 1.0;

# ===================================================================
# INITIALIZE
# ===================================================================

# Screen dimensions
screen_width = Window.GetWidth();
screen_height = Window.GetHeight();

# Set background
Window.SetBackgroundTopColor(bg_color_r, bg_color_g, bg_color_b);
Window.SetBackgroundBottomColor(bg_color_r * 0.8, bg_color_g * 0.8, bg_color_b * 0.8);

# ===================================================================
# LOGO SETUP
# ===================================================================

# Load logo images
# You'll need: logo-center.png (static center) and logo-blades.png (rotating blades)
logo_center = Image("logo-center.png");
logo_blades = Image("logo-blades.png");

# Scale logos if needed
logo_center = logo_center.Scale(logo_center.GetWidth() * logo_scale, logo_center.GetHeight() * logo_scale);
logo_blades = logo_blades.Scale(logo_blades.GetWidth() * logo_scale, logo_blades.GetHeight() * logo_scale);

# Create sprites
logo_center_sprite = Sprite(logo_center);
logo_blades_sprite = Sprite(logo_blades);

# Position in center of screen
logo_x = screen_width / 2 - logo_center.GetWidth() / 2;
logo_y = screen_height / 2 - logo_center.GetHeight() / 2 - 50;

logo_center_sprite.SetPosition(logo_x, logo_y, 10);
logo_blades_sprite.SetPosition(logo_x, logo_y, 9);

# ===================================================================
# TEXT SETUP
# ===================================================================

# Brand name
brand_text = Image.Text("WehttamSnaps", text_color_r, text_color_g, text_color_b, 1.0, "Sans 20");
brand_sprite = Sprite(brand_text);
brand_sprite.SetPosition(screen_width / 2 - brand_text.GetWidth() / 2, logo_y + logo_center.GetHeight() + 30, 10);

# Subtitle
subtitle_text = Image.Text("Photography & Gaming", text_color_r * 0.8, text_color_g * 0.8, text_color_b * 0.8, 1.0, "Sans 12");
subtitle_sprite = Sprite(subtitle_text);
subtitle_sprite.SetPosition(screen_width / 2 - subtitle_text.GetWidth() / 2, logo_y + logo_center.GetHeight() + 60, 10);

# ===================================================================
# PROGRESS BAR
# ===================================================================

progress_bar_width = 300;
progress_bar_height = 6;
progress_bar_x = screen_width / 2 - progress_bar_width / 2;
progress_bar_y = screen_height - 100;

# Background
progress_bg = Image("progress_bg.png");
if (!progress_bg) {
    progress_bg = Image.CreateRectangle(progress_bar_width, progress_bar_height, bg_color_r * 1.5, bg_color_g * 1.5, bg_color_b * 1.5);
}
progress_bg_sprite = Sprite(progress_bg);
progress_bg_sprite.SetPosition(progress_bar_x, progress_bar_y, 5);

# Foreground (animated)
progress_fg = Image.CreateRectangle(1, progress_bar_height, accent_color_r, accent_color_g, accent_color_b);
progress_fg_sprite = Sprite(progress_fg);
progress_fg_sprite.SetPosition(progress_bar_x, progress_bar_y, 6);

# Status text
status_text = Image.Text("Starting...", text_color_r * 0.7, text_color_g * 0.7, text_color_b * 0.7, 1.0, "Sans 10");
status_sprite = Sprite(status_text);
status_sprite.SetPosition(screen_width / 2 - status_text.GetWidth() / 2, progress_bar_y - 25, 10);

# ===================================================================
# ANIMATION LOOP
# ===================================================================

rotation_angle = 0;

fun refresh_callback() {
    # Rotate the logo blades
    rotation_angle += rotation_speed;
    if (rotation_angle >= 360) rotation_angle = 0;
    
    # Apply rotation to blades sprite
    # Plymouth's Image.Rotate() takes angle in degrees
    rotated_blades = logo_blades.Rotate(rotation_angle);
    logo_blades_sprite.SetImage(rotated_blades);
    
    # Update progress bar
    progress = Plymouth.GetBootProgress();
    if (progress) {
        new_width = progress_bar_width * progress;
        progress_fg = Image.CreateRectangle(new_width, progress_bar_height, accent_color_r, accent_color_g, accent_color_b);
        progress_fg_sprite.SetImage(progress_fg);
    }
}

Plymouth.SetRefreshFunction(refresh_callback);

# ===================================================================
# BOOT PROGRESS MESSAGES
# ===================================================================

fun display_normal_callback() {
    status_sprite.SetOpacity(1);
}

fun display_password_callback(prompt, bullets) {
    prompt_text = Image.Text(prompt, text_color_r, text_color_g, text_color_b, 1.0, "Sans 12");
    prompt_sprite = Sprite(prompt_text);
    prompt_sprite.SetPosition(screen_width / 2 - prompt_text.GetWidth() / 2, progress_bar_y + 40, 10);
    
    # Display bullets for password
    bullets_text = Image.Text(bullets, primary_color_r, primary_color_g, primary_color_b, 1.0, "Sans 12");
    bullets_sprite = Sprite(bullets_text);
    bullets_sprite.SetPosition(screen_width / 2 - bullets_text.GetWidth() / 2, progress_bar_y + 60, 10);
}

fun display_message_callback(message) {
    msg_text = Image.Text(message, text_color_r * 0.7, text_color_g * 0.7, text_color_b * 0.7, 1.0, "Sans 10");
    status_sprite.SetImage(msg_text);
    status_sprite.SetPosition(screen_width / 2 - msg_text.GetWidth() / 2, progress_bar_y - 25, 10);
}

Plymouth.SetDisplayNormalFunction(display_normal_callback);
Plymouth.SetDisplayPasswordFunction(display_password_callback);
Plymouth.SetMessageFunction(display_message_callback);

# ===================================================================
# QUIT CALLBACK
# ===================================================================

fun quit_callback() {
    # Fade out animation
    logo_center_sprite.SetOpacity(0);
    logo_blades_sprite.SetOpacity(0);
    brand_sprite.SetOpacity(0);
    subtitle_sprite.SetOpacity(0);
}

Plymouth.SetQuitFunction(quit_callback);

PLYMOUTH_SCRIPT

# ===================================================================
# CREATE PLYMOUTH THEME DEFINITION
# ===================================================================

# Plymouth theme file (wehttamsnaps.plymouth)
cat << 'PLYMOUTH_THEME'
[Plymouth Theme]
Name=WehttamSnaps
Description=WehttamSnaps Photography & Gaming Boot Theme with Animated Logo
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/wehttamsnaps
ScriptFile=/usr/share/plymouth/themes/wehttamsnaps/wehttamsnaps.script
PLYMOUTH_THEME

echo "✅ Plymouth theme scripts created!"
echo ""
echo "Next steps:"
echo "1. Place your logo images in the theme directory:"
echo "   - logo-center.png (static center circle)"
echo "   - logo-blades.png (aperture blades to rotate)"
echo ""
echo "2. Install the theme:"
echo "   sudo cp -r theme_directory /usr/share/plymouth/themes/wehttamsnaps"
echo "   sudo plymouth-set-default-theme wehttamsnaps"
echo "   sudo update-initramfs -u"
echo ""
echo "3. Test the theme:"
echo "   sudo plymouthd --debug --tty=$(tty)"
echo "   sudo plymouth show-splash"
echo "   sudo killall plymouthd"
