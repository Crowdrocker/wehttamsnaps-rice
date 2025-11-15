#!/usr/bin/env python3

# === WEHTTAMSNAPS WELCOME APP ===
# GitHub: https://github.com/Crowdrocker
# Branded welcome app for Niri + Noctalia setup

import gi
gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
from gi.repository import Gtk, Gdk, GdkPixbuf, GLib, Pango
import os
import json
import sys

class WehttamSnapsWelcome:
    def __init__(self):
        self.window = Gtk.Window()
        self.window.set_title("Welcome to WehttamSnaps")
        self.window.set_default_size(800, 600)
        self.window.set_position(Gtk.WindowPosition.CENTER)
        self.window.set_resizable(False)
        
        # Make window explicitly non-modal
        self.window.set_modal(False)
        self.window.set_keep_above(False)
        self.window.set_focus_on_map(False)
        self.window.set_type_hint(Gdk.WindowTypeHint.NORMAL)

        # Create main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        main_box.set_margin_start(0)
        main_box.set_margin_end(0)
        main_box.set_margin_top(0)
        main_box.set_margin_bottom(30)

        # Add welcome image
        self.add_welcome_image(main_box)

        # Add main text
        self.add_main_text(main_box)

        # Add buttons
        self.add_buttons(main_box)

        self.window.add(main_box)
        self.window.connect("destroy", self.on_window_destroy)
        self.window.show_all()

    def add_welcome_image(self, container):
        # Add WehttamSnaps logo
        home_dir = os.environ.get("HOME") or os.path.expanduser("~")
        image_path = os.path.join(
            home_dir, ".config", "wehttamsnaps", "assets", "ws-logo.png"
        )

        if os.path.exists(image_path):
            try:
                # Load and scale the image
                pixbuf = GdkPixbuf.Pixbuf.new_from_file(image_path)
                width = pixbuf.get_width()
                height = pixbuf.get_height()
                target_width = int(800 * 0.6)  # 480px
                scale_factor = target_width / width
                new_width = target_width
                new_height = int(height * scale_factor)
                pixbuf = pixbuf.scale_simple(
                    new_width, new_height, GdkPixbuf.InterpType.BILINEAR
                )

                image = Gtk.Image.new_from_pixbuf(pixbuf)
                image.set_halign(Gtk.Align.FILL)
                container.pack_start(image, False, False, 0)
            except Exception as e:
                print(f"Could not load ws-logo.png: {e}")

    def add_main_text(self, container):
        # Read version from VERSION file
        version = self.get_wehttamsnaps_version()

        # Create scrollable text view
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled_window.set_size_request(-1, 400)

        text_view = Gtk.TextView()
        text_view.set_editable(False)
        text_view.set_cursor_visible(False)
        text_view.set_wrap_mode(Gtk.WrapMode.WORD)
        text_view.set_left_margin(40)
        text_view.set_right_margin(40)
        text_view.set_top_margin(20)
        text_view.set_bottom_margin(20)

        # Set font for text view
        font_desc = Pango.FontDescription()
        font_desc.set_family("Fira Code")
        font_desc.set_size(12 * Pango.SCALE)
        text_view.override_font(font_desc)

        buffer = text_view.get_buffer()

        # Create text with WehttamSnaps branding
        text_content_parts = [
            f"Welcome to WehttamSnaps v{version}\n\n",
            "WehttamSnaps is built on Niri, a modern Wayland compositor optimized for AMD GPUs. "
            "This setup combines the best of JaKooLit theming with Omarchy workflow, "
            "powered by Noctalia shell for a seamless experience.\n\n",
            "\ud83d\ude80 QUICK START\n\n",
            "While you can use the Quickshell launcher, keyboard shortcuts are the heart of WehttamSnaps:\n\n",
            "Essential Shortcuts:\n",
            "\u2022 SUPER + SPACE   \u2192  Application Launcher\n",
            "\u2022 SUPER + S       \u2192  Control Center\n",
            "\u2022 SUPER + D       \u2192  App Launcher (Fuzzel)\n",
            "\u2022 SUPER + ENTER   \u2192  Ghostty Terminal\n",
            "\u2022 SUPER + B       \u2192  Brave Browser\n",
            "\u2022 SUPER + H       \u2192  Help Screen\n",
            "\u2022 SUPER + Q       \u2192  Close Window\n",
            "\u2022 SUPER + F       \u2192  File Manager (Thunar)\n\n",
            "Photography & Design:\n",
            "\u2022 SUPER + SHIFT + D  \u2192  Darktable\n",
            "\u2022 SUPER + SHIFT + R  \u2192  RawTherapee\n",
            "\u2022 SUPER + SHIFT + G  \u2192  GIMP\n",
            "\u2022 SUPER + SHIFT + I  \u2192  Inkscape\n\n",
            "Gaming & Streaming:\n",
            "\u2022 SUPER + SHIFT + G  \u2192  Toggle Game Mode\n",
            "\u2022 SUPER + SHIFT + O  \u2192  OBS Studio\n",
            "\u2022 SUPER + SHIFT + S  \u2192  Steam\n",
            "\u2022 SUPER + SHIFT + Y  \u2192  YouTube WebApp\n",
            "\u2022 SUPER + SHIFT + T  \u2192  Twitch WebApp\n\n",
            "Audio & System:\n",
            "\u2022 XF86Audio Keys      \u2192  Volume Control (via Noctalia)\n",
            "\u2022 PRINT                \u2192  Screenshot\n",
            "\u2022 SUPER + PRINT       \u2192  Region Screenshot\n",
            "\u2022 CTRL + ALT + L      \u2192  Lock Screen\n\n",
            "\ud83c\udfaf PHILOSOPHY\n\n",
            "WehttamSnaps respects your creativity while providing an intuitive experience. "
            "Everything is configurable, and you're encouraged to make it your own. "
            "This setup is optimized for photography, gaming, and content creation on AMD hardware.\n\n",
            "RX 580 Optimizations:\n",
            "\u2022 Vulkan and AMDGPU drivers pre-configured\n",
            "\u2022 Gaming mode with performance tweaks\n",
            "\u2022 Audio routing for streaming\n",
            "\u2022 Color-accurate photography workflow\n\n",
            "Enjoy exploring your new WehttamSnaps environment! \ud83d\udcf8\ud83c\udfae\ud83c\udfac",
        ]

        # Insert text parts
        iter_end = buffer.get_end_iter()
        for part in text_content_parts:
            buffer.insert(iter_end, part)
            iter_end = buffer.get_end_iter()

        # Insert signature
        signature_tag = buffer.create_tag("signature", scale=1.2)
        buffer.insert_with_tags(iter_end, "\n\n\ud835\udce8\ud835\udcf2\ud835\udcfb\ud835\udcf8\ud835\udcee\ud835\udcfa\ud835\udce4\ud835\udced\ud835\udce8\ud835\udcf8\ud835\udcf5 \ud835\udcf1\ud835\udced\ud835\udcfa\ud835\udced\ud835\udce2", signature_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, "\n\n")
        iter_end = buffer.get_end_iter()

        # Insert clickable links
        github_tag = buffer.create_tag(
            "github_link", foreground="#89b4fa", underline=True
        )
        buffer.insert_with_tags(iter_end, "WehttamSnaps on GitHub", github_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, " | ")
        iter_end = buffer.get_end_iter()

        youtube_tag = buffer.create_tag(
            "youtube_link", foreground="#ff0000", underline=True
        )
        buffer.insert_with_tags(iter_end, "WehttamSnaps on YouTube", youtube_tag)
        iter_end = buffer.get_end_iter()

        # Connect click events for links
        text_view.connect("button-press-event", self.on_text_clicked)

        scrolled_window.add(text_view)
        container.pack_start(scrolled_window, True, True, 0)

    def add_buttons(self, container):
        # Create button box
        button_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        button_box.set_halign(Gtk.Align.FILL)
        button_box.set_margin_start(40)
        button_box.set_margin_end(40)

        # Dismiss Forever button (left)
        dismiss_button = Gtk.Button(label="Dismiss Forever")
        dismiss_button.connect("clicked", self.on_dismiss_forever)
        dismiss_button.set_halign(Gtk.Align.START)
        button_box.pack_start(dismiss_button, False, False, 0)

        # Spacer
        spacer = Gtk.Box()
        button_box.pack_start(spacer, True, True, 0)

        # Close button (right)
        close_button = Gtk.Button(label="Close")
        close_button.connect("clicked", self.on_close)
        close_button.set_halign(Gtk.Align.END)
        button_box.pack_start(close_button, False, False, 0)

        container.pack_start(button_box, False, False, 0)

    def on_dismiss_forever(self, button):
        # Create config directory if it doesn't exist
        config_dir = os.path.expanduser("~/.config/wehttamsnaps")
        os.makedirs(config_dir, exist_ok=True)

        # Write welcome.json to indicate welcome has been dismissed
        welcome_config = {"dismissed": True, "timestamp": GLib.get_real_time()}

        config_file = os.path.join(config_dir, "welcome.json")
        try:
            with open(config_file, "w") as f:
                json.dump(welcome_config, f, indent=2)
            print("Welcome dismissed forever")
        except Exception as e:
            print(f"Error saving welcome config: {e}")

        Gtk.main_quit()

    def on_close(self, button):
        Gtk.main_quit()

    def on_text_clicked(self, text_view, event):
        """Handle clicks on text view to open links"""
        if event.button == 1:  # Left click
            x, y = text_view.window_to_buffer_coords(
                Gtk.TextWindowType.WIDGET, int(event.x), int(event.y)
            )
            iter_result = text_view.get_iter_at_location(x, y)

            if iter_result[0]:  # Check if location was found
                iter_pos = iter_result[1]
                tags = iter_pos.get_tags()

                for tag in tags:
                    if hasattr(tag, "get_property"):
                        tag_name = tag.get_property("name")
                        if tag_name == "youtube_link":
                            os.system("xdg-open https://youtube.com/@WehttamSnaps &")
                            return True
                        elif tag_name == "github_link":
                            os.system(
                                "xdg-open https://github.com/Crowdrocker &"
                            )
                            return True

        return False

    def get_wehttamsnaps_version(self):
        """Read WehttamSnaps version from VERSION file"""
        home_dir = os.environ.get("HOME") or os.path.expanduser("~")
        version_path = os.path.join(home_dir, ".config", "wehttamsnaps", "VERSION")

        try:
            with open(version_path, "r") as f:
                version = f.read().strip()
                return version
        except Exception as e:
            print(f"Could not read version file: {e}")
            return "1.0.0"

    def on_window_destroy(self, widget):
        """Handle window destruction"""
        Gtk.main_quit()


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
    if len(sys.argv) > 1 and sys.argv[1] == "--force":
        # Force show welcome even if dismissed
        pass
    elif not should_show_welcome():
        print("Welcome has been dismissed")
        return

    # Set up CSS for styling
    css_provider = Gtk.CssProvider()
    css_data = """
    * {
        font-family: "Fira Code", "Symbols Nerd Font", "Symbols Nerd Font Mono", monospace;
    }

    window {
        background: rgba(17, 17, 27, 1.0);
        color: #cdd6f4;
        font-family: "Fira Code", "Symbols Nerd Font", "Symbols Nerd Font Mono", monospace;
    }

    label {
        color: #cdd6f4;
        font-family: "Fira Code", "Symbols Nerd Font", "Symbols Nerd Font Mono", monospace;
    }

    textview {
        background: rgba(17, 17, 27, 1.0);
        color: #cdd6f4;
        border: none;
        font-family: "Fira Code", "Symbols Nerd Font", "Symbols Nerd Font Mono", monospace;
    }

    textview text {
        background: rgba(17, 17, 27, 1.0);
        color: #cdd6f4;
        font-family: "Fira Code", "Symbols Nerd Font", "Symbols Nerd Font Mono", monospace;
    }

    button {
        background: rgba(88, 91, 174, 1.0);
        color: #ffffff;
        border: none;
        border-radius: 8px;
        padding: 8px 16px;
        font-weight: bold;
        min-width: 100px;
        min-height: 32px;
        font-family: "Fira Code", "Symbols Nerd Font", "Symbols Nerd Font Mono", monospace;
    }

    button:hover {
        background: rgba(111, 118, 214, 1.0);
    }

    scrolledwindow {
        border: none;
        background: rgba(17, 17, 27, 1.0);
    }
    """

    css_provider.load_from_data(css_data.encode())

    # Apply CSS to default screen
    screen = Gdk.Screen.get_default()
    Gtk.StyleContext.add_provider_for_screen(
        screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER
    )

    WehttamSnapsWelcome()

    # Run the main loop
    Gtk.main()


if __name__ == "__main__":
    main()