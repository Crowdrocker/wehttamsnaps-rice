#!/bin/bash
# ===================================================================
# WehttamSnaps Audio Routing Setup
# https://github.com/Crowdrocker/wehttamsnaps-dotfiles
#
# Creates virtual audio sinks for streaming/recording
# Similar to Voicemeeter on Windows
# ===================================================================

echo "🎵 WehttamSnaps Audio Routing Setup"
echo "====================================="
echo ""

# Check for PipeWire
if ! command -v pw-cli &>/dev/null; then
    echo "❌ PipeWire not found"
    echo "Install with: sudo pacman -S pipewire wireplumber pipewire-pulse"
    exit 1
fi

# Check for wpctl
if ! command -v wpctl &>/dev/null; then
    echo "❌ wpctl not found (part of WirePlumber)"
    exit 1
fi

CONFIG_DIR="$HOME/.config/wehttamsnaps/audio"
mkdir -p "$CONFIG_DIR"

# ===================================================================
# CREATE VIRTUAL SINKS
# ===================================================================

echo "Creating virtual audio sinks..."
echo ""

# Remove existing sinks (clean slate)
pactl list short modules | grep "module-null-sink" | awk '{print $1}' | xargs -I {} pactl unload-module {} 2>/dev/null

# 1. Game Audio Sink
GAME_SINK=$(pactl load-module module-null-sink \
    sink_name=game_audio \
    sink_properties=device.description="Game Audio" \
    rate=48000 \
    channels=2)
echo "  ✓ Game Audio Sink created (ID: $GAME_SINK)"

# 2. Music/Media Sink
MUSIC_SINK=$(pactl load-module module-null-sink \
    sink_name=music_audio \
    sink_properties=device.description="Music/Media Audio" \
    rate=48000 \
    channels=2)
echo "  ✓ Music/Media Sink created (ID: $MUSIC_SINK)"

# 3. Browser Audio Sink
BROWSER_SINK=$(pactl load-module module-null-sink \
    sink_name=browser_audio \
    sink_properties=device.description="Browser Audio" \
    rate=48000 \
    channels=2)
echo "  ✓ Browser Audio Sink created (ID: $BROWSER_SINK)"

# 4. Chat/Comms Sink
CHAT_SINK=$(pactl load-module module-null-sink \
    sink_name=chat_audio \
    sink_properties=device.description="Chat/Discord Audio" \
    rate=48000 \
    channels=2)
echo "  ✓ Chat/Discord Sink created (ID: $CHAT_SINK)"

# 5. System Sounds Sink
SYSTEM_SINK=$(pactl load-module module-null-sink \
    sink_name=system_audio \
    sink_properties=device.description="System Sounds" \
    rate=48000 \
    channels=2)
echo "  ✓ System Sounds Sink created (ID: $SYSTEM_SINK)"

echo ""

# ===================================================================
# CREATE COMBINED SINK (Master Output)
# ===================================================================

echo "Creating combined master output..."

# Get default output device
DEFAULT_SINK=$(pactl get-default-sink)

# Create combined sink that mixes all virtual sinks
COMBINED_SINK=$(pactl load-module module-combine-sink \
    sink_name=master_output \
    sink_properties=device.description="Master Output (Mixed)" \
    slaves="$DEFAULT_SINK,game_audio,music_audio,browser_audio,chat_audio,system_audio")

echo "  ✓ Master Output created (ID: $COMBINED_SINK)"
echo ""

# ===================================================================
# LOOPBACK CONNECTIONS
# ===================================================================

echo "Creating loopback connections to headphones..."

# Each virtual sink needs a loopback to the actual output
pactl load-module module-loopback source=game_audio.monitor sink="$DEFAULT_SINK" latency_msec=1
pactl load-module module-loopback source=music_audio.monitor sink="$DEFAULT_SINK" latency_msec=1
pactl load-module module-loopback source=browser_audio.monitor sink="$DEFAULT_SINK" latency_msec=1
pactl load-module module-loopback source=chat_audio.monitor sink="$DEFAULT_SINK" latency_msec=1
pactl load-module module-loopback source=system_audio.monitor sink="$DEFAULT_SINK" latency_msec=1

echo "  ✓ Loopback connections created"
echo ""

# ===================================================================
# SAVE CONFIGURATION
# ===================================================================

# Save module IDs for later cleanup
cat > "$CONFIG_DIR/sinks.conf" << EOF
# WehttamSnaps Audio Routing Configuration
# Created: $(date)

GAME_SINK=$GAME_SINK
MUSIC_SINK=$MUSIC_SINK
BROWSER_SINK=$BROWSER_SINK
CHAT_SINK=$CHAT_SINK
SYSTEM_SINK=$SYSTEM_SINK
COMBINED_SINK=$COMBINED_SINK
DEFAULT_SINK=$DEFAULT_SINK
EOF

echo "  ✓ Configuration saved to $CONFIG_DIR/sinks.conf"
echo ""

# ===================================================================
# APPLICATION ROUTING RULES
# ===================================================================

echo "Setting up application routing rules..."

# Create PipeWire configuration for automatic routing
mkdir -p "$HOME/.config/pipewire/pipewire.conf.d"

cat > "$HOME/.config/pipewire/pipewire.conf.d/wehttamsnaps-routing.conf" << 'EOF'
# WehttamSnaps Audio Routing Rules

context.exec = [
    # Route Steam games to game_audio sink
    { path = "pactl" args = "load-module module-match source-output-by-application-name=steam.* sink=game_audio" }
    
    # Route browsers to browser_audio sink
    { path = "pactl" args = "load-module module-match source-output-by-application-name=brave.* sink=browser_audio" }
    { path = "pactl" args = "load-module module-match source-output-by-application-name=firefox.* sink=browser_audio" }
    { path = "pactl" args = "load-module module-match source-output-by-application-name=chromium.* sink=browser_audio" }
    
    # Route media players to music_audio sink
    { path = "pactl" args = "load-module module-match source-output-by-application-name=spotify.* sink=music_audio" }
    { path = "pactl" args = "load-module module-match source-output-by-application-name=mpv.* sink=music_audio" }
    
    # Route Discord/chat apps to chat_audio sink
    { path = "pactl" args = "load-module module-match source-output-by-application-name=discord.* sink=chat_audio" }
    { path = "pactl" args = "load-module module-match source-output-by-application-name=telegram.* sink=chat_audio" }
]
EOF

echo "  ✓ Automatic routing rules created"
echo ""

# ===================================================================
# QPWGRAPH LAYOUT (OPTIONAL)
# ===================================================================

if command -v qpwgraph &>/dev/null; then
    echo "Creating qpwgraph layout..."
    
    mkdir -p "$HOME/.config/rncbc.org"
    
    cat > "$HOME/.config/rncbc.org/qpwgraph.conf" << EOF
[Defaults]
ConnectThroughNodes=true
ConnectType=0

[Geometry]
qpwgraphForm=@ByteArray()

[PatchBay]
Enabled=true
Path=$CONFIG_DIR/qpwgraph.xml
EOF

    # Create patch bay layout
    cat > "$CONFIG_DIR/qpwgraph.xml" << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE qpwgraph>
<qpwgraph version="0.5.0">
 <patchbay name="WehttamSnaps">
  <rack name="WehttamSnaps Audio Routing">
   <!-- Game Audio -->
   <node type="audio-sink" name="game_audio"/>
   
   <!-- Music Audio -->
   <node type="audio-sink" name="music_audio"/>
   
   <!-- Browser Audio -->
   <node type="audio-sink" name="browser_audio"/>
   
   <!-- Chat Audio -->
   <node type="audio-sink" name="chat_audio"/>
   
   <!-- Master Output -->
   <node type="audio-sink" name="master_output"/>
  </rack>
 </patchbay>
</qpwgraph>
EOF

    echo "  ✓ qpwgraph layout created"
    echo "  → Launch qpwgraph to view/edit audio routing"
    echo ""
fi

# ===================================================================
# OBS STUDIO CONFIGURATION
# ===================================================================

echo "OBS Studio Configuration Tips:"
echo "────────────────────────────────"
echo ""
echo "In OBS, add these audio sources:"
echo "  1. Game Audio    → Monitor: game_audio.monitor"
echo "  2. Music         → Monitor: music_audio.monitor"
echo "  3. Browser       → Monitor: browser_audio.monitor"
echo "  4. Chat/Discord  → Monitor: chat_audio.monitor"
echo "  5. Microphone    → Your physical mic input"
echo ""
echo "This gives you independent volume control for each source!"
echo ""

# ===================================================================
# USAGE INSTRUCTIONS
# ===================================================================

echo "📋 Usage Instructions:"
echo "────────────────────────"
echo ""
echo "Manual routing (if auto-routing doesn't work):"
echo "  1. Open pavucontrol (or qpwgraph)"
echo "  2. Go to 'Playback' tab"
echo "  3. For each app, select the appropriate sink:"
echo "     • Steam/Games     → Game Audio"
echo "     • Spotify/Media   → Music/Media Audio"
echo "     • Browser         → Browser Audio"
echo "     • Discord/Chat    → Chat/Discord Audio"
echo ""
echo "For streaming/recording:"
echo "  • In OBS, capture the .monitor sources"
echo "  • Each source has independent volume control"
echo "  • Mute/unmute specific sources without affecting others"
echo ""
echo "Remove this setup:"
echo "  bash $HOME/.config/wehttamsnaps/scripts/audio/audio-cleanup.sh"
echo ""

# ===================================================================
# CREATE CLEANUP SCRIPT
# ===================================================================

cat > "$HOME/.config/wehttamsnaps/scripts/audio/audio-cleanup.sh" << 'EOF'
#!/bin/bash
# Cleanup audio routing setup

echo "Removing audio routing setup..."

# Read module IDs
source "$HOME/.config/wehttamsnaps/audio/sinks.conf"

# Unload modules
pactl unload-module $GAME_SINK 2>/dev/null
pactl unload-module $MUSIC_SINK 2>/dev/null
pactl unload-module $BROWSER_SINK 2>/dev/null
pactl unload-module $CHAT_SINK 2>/dev/null
pactl unload-module $SYSTEM_SINK 2>/dev/null
pactl unload-module $COMBINED_SINK 2>/dev/null

# Remove loopback modules
pactl list short modules | grep module-loopback | awk '{print $1}' | xargs -I {} pactl unload-module {}

echo "✓ Audio routing removed"
EOF

chmod +x "$HOME/.config/wehttamsnaps/scripts/audio/audio-cleanup.sh"

echo "✅ Audio routing setup complete!"
echo ""
echo "Restart PipeWire to apply all changes:"
echo "  systemctl --user restart pipewire pipewire-pulse wireplumber"
echo ""

exit 0