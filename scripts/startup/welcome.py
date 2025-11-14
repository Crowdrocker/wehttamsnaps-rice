#!/usr/bin/env python3
"""
WehttamSnaps Welcome Screen
https://github.com/Crowdrocker/wehttamsnaps-dotfiles

A branded first-boot welcome screen for WehttamSnaps Niri setup
"""

import gi
gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
from gi.repository import Gtk, Gdk, GdkPixbuf, GLib, Pango
import os
import json
import sys
import subprocess


class WehttamWelcome:
    def __init__(self):
        self.window = Gtk.Window()
        self.window.set_title("Welcome to WehttamSnaps")
        self.window.set_default_size(900, 700)
        self.window.set_position(Gtk.WindowPosition.CENTER)
        self.window.set_resizable(False)
        
        # Window properties
        self.window.set_modal(False)
        self.window.set_keep_above(False)
        self.window.set_focus_on_map(False)
        self.window.set_type_hint(Gdk.WindowTypeHint.NORMAL)
        
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        main_box.set_margin_start(0)
        main_box.set_margin_end(0)
        main_box.set_margin_top(0)
        main_box.set_margin_bottom(30)
        
        # Add logo image
        self.add_logo(main_box)
        
        # Add content
        self.add_content(main_box)
        
        # Add buttons
        self.add_buttons(main_box)
        
        self.window.add(main_box)
        self.window.connect("destroy", self.on_window_destroy)
        self.window.show_all()
        
        # Play J.A.R.V.I.S. startup sound if available
        self.play_jarvis_sound()
    
    def add_logo(self, container):
        """Add WehttamSnaps logo"""
        config_dir = os.path.expanduser("~/.config/wehttamsnaps")
        logo_path = os.path.join(config_dir, "assets", "logo.png")
        
        if os.path.exists(logo_path):
            try:
                pixbuf = GdkPixbuf.Pixbuf.new_from_file(logo_path)
                # Scale to 400px wide
                width = pixbuf.get_width()
                height = pixbuf.get_height()
                target_width = 400
                scale_factor = target_width / width
                new_height = int(height * scale_factor)
                pixbuf = pixbuf.scale_simple(
                    target_width, new_height, GdkPixbuf.InterpType.BILINEAR
                )
                
                image = Gtk.Image.new_from_pixbuf(pixbuf)
                image.set_halign(Gtk.Align.CENTER)
                container.pack_start(image, False, False, 10)
            except Exception as e:
                print(f"Could not load logo: {e}")
                self.add_ascii_logo(container)
        else:
            self.add_ascii_logo(container)
    
    def add_ascii_logo(self, container):
        """Fallback ASCII art logo"""
        logo_text = """
╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
        """
        
        label = Gtk.Label()
        label.set_markup(f'<span font_family="monospace" size="12000" foreground="#a6e3a1">{logo_text}</span>')
        label.set_halign(Gtk.Align.CENTER)
        container.pack_start(label, False, False, 10)
    
    def add_content(self, container):
        """Add main content"""
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled.set_size_request(-1, 350)
        
        textview = Gtk.TextView()
        textview.set_editable(False)
        textview.set_cursor_visible(False)
        textview.set_wrap_mode(Gtk.WrapMode.WORD)
        textview.set_left_margin(40)
        textview.set_right_margin(40)
        textview.set_top_margin(20)
        textview.set_bottom_margin(20)
        
        # Set font
        font_desc = Pango.FontDescription()
        font_desc.set_family("Fira Code")
        font_desc.set_size(11 * Pango.SCALE)
        textview.override_font(font_desc)
        
        buffer = textview.get_buffer()
        
        # Content
        content = self.get_welcome_content()
        iter_end = buffer.get_end_iter()
        
        for part in content:
            if isinstance(part, tuple):  # (text, tag_name)
                text, tag = part
                tag_obj = buffer.create_tag(tag, **self.get_tag_properties(tag))
                buffer.insert_with_tags(iter_end, text, tag_obj)
            else:
                buffer.insert(iter_end, part)
            iter_end = buffer.get_end_iter()
        
        # Connect click handler
        textview.connect("button-press-event", self.on_text_clicked)
        
        scrolled.add(textview)
        container.pack_start(scrolled, True, True, 0)
    
    def get_welcome_content(self):
        """Get welcome text content"""
        hw_info = self.get_hardware_info()
        
        return [
            ("Welcome to WehttamSnaps Setup\n\n", "title"),
            f"Hardware: {hw_info}\n",
            "Compositor: Niri (Wayland scrollable tiling)\n",
            "Shell: Noctalia (Quickshell-based)\n",
            "Terminal: Ghostty (GPU-accelerated)\n\n",
            
            ("🚀 QUICK START\n\n", "heading"),
            "This setup is optimized for photography and gaming workflows. "
            "Everything is keyboard-driven for maximum efficiency.\n\n",
            
            ("Essential Keybinds:\n", "subheading"),
            "• Mod+Space     → App Launcher\n",
            "• Mod+Return    → Terminal (Ghostty)\n",
            "• Mod+H         → KeyHints (show all binds)\n",
            "• Mod+S         → Control Center\n",
            "• Mod+B         → Browser\n",
            "• Mod+F         → File Manager\n",
            "• Mod+L         → Lock Screen\n",
            "• Mod+Q         → Close Window\n\n",
            
            ("Photography Workflow:\n", "subheading"),
            "• Mod+P         → Photography workspace layout\n",
            "• Mod+Shift+G   → GIMP\n",
            "• Mod+Shift+R   → Darktable\n",
            "• Mod+Shift+A   → RawTherapee\n",
            "• Mod+Shift+K   → Krita\n\n",
            
            ("Gaming Controls:\n", "subheading"),
            "• Mod+G         → Toggle Gamemode\n",
            "• Mod+Shift+G+S → Steam\n",
            "• Mod+Shift+G+L → Lutris\n",
            "• Mod+Shift+G+C → AMD GPU Control\n\n",
            
            ("Webapps:\n", "subheading"),
            "• Mod+Shift+Y   → YouTube\n",
            "• Mod+Shift+T   → Twitch\n",
            "• Mod+Shift+S   → Spotify\n",
            "• Mod+Shift+D   → Discord\n\n",
            
            ("🎯 PHILOSOPHY\n\n", "heading"),
            "WehttamSnaps is built for creators who need:\n",
            "• Fast, reliable performance for photo editing\n",
            "• Optimized gaming with AMD RX 580\n",
            "• Clean, distraction-free workflows\n",
            "• Complete control over your environment\n\n",
            
            "Everything is modular and customizable. Check the docs for advanced configs.\n\n",
            
            ("Enjoy your new setup! 📷🎮\n\n", "signature"),
            
            ("Links:\n", "subheading"),
            ("GitHub Repository", "link_github"),
            " | ",
            ("Twitch", "link_twitch"),
            " | ",
            ("YouTube", "link_youtube"),
        ]
    
    def get_tag_properties(self, tag_name):
        """Get text tag properties"""
        tags = {
            "title": {"scale": 1.8, "weight": Pango.Weight.BOLD, "foreground": "#a6e3a1"},
            "heading": {"scale": 1.3, "weight": Pango.Weight.BOLD, "foreground": "#89b4fa"},
            "subheading": {"scale": 1.1, "weight": Pango.Weight.BOLD, "foreground": "#f9e2af"},
            "signature": {"scale": 1.2, "foreground": "#f5c2e7"},
            "link_github": {"foreground": "#89b4fa", "underline": True},
            "link_twitch": {"foreground": "#89b4fa", "underline": True},
            "link_youtube": {"foreground": "#89b4fa", "underline": True},
        }
        return tags.get(tag_name, {})
    
    def get_hardware_info(self):
        """Get system hardware info"""
        try:
            # Try to get CPU info
            with open("/proc/cpuinfo", "r") as f:
                for line in f:
                    if "model name" in line:
                        cpu = line.split(":")[1].strip()
                        # Shorten CPU name
                        cpu = cpu.replace("Intel(R) Core(TM)", "").strip()
                        break
            
            # Try to get GPU info
            try:
                gpu_output = subprocess.check_output(
                    ["lspci"], stderr=subprocess.DEVNULL
                ).decode()
                for line in gpu_output.split("\n"):
                    if "VGA" in line or "Display" in line:
                        if "AMD" in line or "Radeon" in line:
                            gpu = "AMD RX 580"
                            break
            except:
                gpu = "Unknown GPU"
            
            return f"{cpu} | {gpu}"
        except:
            return "Dell XPS 8700 | i7-4790 | RX 580"
    
    def on_text_clicked(self, textview, event):
        """Handle link clicks"""
        if event.button == 1:
            x, y = textview.window_to_buffer_coords(
                Gtk.TextWindowType.WIDGET, int(event.x), int(event.y)
            )
            iter_result = textview.get_iter_at_location(x, y)
            
            if iter_result[0]:
                iter_pos = iter_result[1]
                tags = iter_pos.get_tags()
                
                for tag in tags:
                    if hasattr(tag, "get_property"):
                        tag_name = tag.get_property("name")
                        if tag_name == "link_github":
                            self.open_url("https://github.com/Crowdrocker/wehttamsnaps-dotfiles")
                        elif tag_name == "link_twitch":
                            self.open_url("https://twitch.tv/wehttamsnaps")
                        elif tag_name == "link_youtube":
                            self.open_url("https://youtube.com/@wehttamsnaps")
        return False
    
    def open_url(self, url):
        """Open URL in browser"""
        subprocess.Popen(["xdg-open", url], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
    def add_buttons(self, container):
        """Add action buttons"""
        button_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        button_box.set_halign(Gtk.Align.FILL)
        button_box.set_margin_start(40)
        button_box.set_margin_end(40)
        
        # Dismiss Forever button
        dismiss_button = Gtk.Button(label="Don't Show Again")
        dismiss_button.connect("clicked", self.on_dismiss_forever)
        dismiss_button.set_halign(Gtk.Align.START)
        button_box.pack_start(dismiss_button, False, False, 0)
        
        # Spacer
        spacer = Gtk.Box()
        button_box.pack_start(spacer, True, True, 0)
        
        # View Keybinds button
        keybinds_button = Gtk.Button(label="View All Keybinds")
        keybinds_button.connect("clicked", self.on_view_keybinds)
        button_box.pack_start(keybinds_button, False, False, 0)
        
        # Close button
        close_button = Gtk.Button(label="Let's Go!")
        close_button.connect("clicked", self.on_close)
        close_button.set_halign(Gtk.Align.END)
        button_box.pack_start(close_button, False, False, 0)
        
        container.pack_start(button_box, False, False, 0)
    
    def on_dismiss_forever(self, button):
        """Save dismissal preference"""
        config_dir = os.path.expanduser("~/.config/wehttamsnaps")
        os.makedirs(config_dir, exist_ok=True)
        
        config_file = os.path.join(config_dir, "welcome.json")
        config = {"dismissed": True, "timestamp": GLib.get_real_time()}
        
        try:
            with open(config_file, "w") as f:
                json.dump(config, f, indent=2)
            print("Welcome screen dismissed")
        except Exception as e:
            print(f"Error saving config: {e}")
        
        Gtk.main_quit()
    
    def on_view_keybinds(self, button):
        """Open keybinds script"""
        keyhints_script = os.path.expanduser("~/.config/wehttamsnaps/scripts/utils/keyhints.sh")
        if os.path.exists(keyhints_script):
            subprocess.Popen(["bash", keyhints_script])
    
    def on_close(self, button):
        """Close window"""
        Gtk.main_quit()
    
    def on_window_destroy(self, widget):
        """Handle window close"""
        Gtk.main_quit()
    
    def play_jarvis_sound(self):
        """Play J.A.R.V.I.S. startup sound if available"""
        sound_file = os.path.expanduser("~/.config/wehttamsnaps/sounds/jarvis-startup.mp3")
        if os.path.exists(sound_file):
            try:
                subprocess.Popen(
                    ["mpv", "--no-video", "--volume=60", sound_file],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL
                )
            except:
                pass


def should_show_welcome():
    """Check if welcome should be shown"""
    config_file = os.path.expanduser("~/.config/wehttamsnaps/welcome.json")
    
    if not os.path.exists(config_file):
        return True
    
    try:
        with open(config_file, "r") as f:
            config = json.load(f)
        return not config.get("dismissed", False)
    except:
        return True


def main():
    """Main entry point"""
    if len(sys.argv) > 1 and sys.argv[1] == "--force":
        pass  # Force show
    elif not should_show_welcome():
        print("Welcome screen dismissed")
        return
    
    # Apply CSS styling
    css_provider = Gtk.CssProvider()
    css_data = """
    * {
        font-family: "Fira Code", monospace;
    }
    
    window {
        background: #1e1e2e;
        color: #cdd6f4;
    }
    
    label {
        color: #cdd6f4;
    }
    
    textview {
        background: #1e1e2e;
        color: #cdd6f4;
        border: none;
    }
    
    textview text {
        background: #1e1e2e;
        color: #cdd6f4;
    }
    
    button {
        background: #89b4fa;
        color: #1e1e2e;
        border: none;
        border-radius: 8px;
        padding: 10px 20px;
        font-weight: bold;
        min-width: 120px;
        min-height: 36px;
    }
    
    button:hover {
        background: #b4befe;
    }
    
    scrolledwindow {
        border: none;
        background: #1e1e2e;
    }
    """
    
    css_provider.load_from_data(css_data.encode())
    screen = Gdk.Screen.get_default()
    Gtk.StyleContext.add_provider_for_screen(
        screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER
    )
    
    WehttamWelcome()
    Gtk.main()


if __name__ == "__main__":
    main()
