#!/bin/bash
# === WEHTTAMSNAPS AUDIO SETUP ===
# Configure PipeWire virtual sinks for streaming and recording

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}[INFO] Setting up WehttamSnaps audio routing...${NC}"

# Create virtual sinks for streaming
create_virtual_sinks() {
    echo -e "${YELLOW}[SETUP] Creating virtual sinks...${NC}"
    
    # Game audio sink
    pactl load-module module-null-sink sink_name=Game sink_properties=device.description="Game_Audio"
    
    # Microphone sink
    pactl load-module module-null-sink sink_name=Mic sink_properties=device.description="Microphone_Virtual"
    
    # Media sink (music/browser)
    pactl load-module module-null-sink sink_name=Media sink_properties=device.description="Media_Audio"
    
    # Chat sink (Discord/VOIP)
    pactl load-module module-null-sink sink_name=Chat sink_properties=device.description="Chat_Audio"
    
    # Mix sink for recording
    pactl load-module module-null-sink sink_name=Mix sink_properties=device.description="Recording_Mix"
    
    echo -e "${GREEN}[OK] Virtual sinks created${NC}"
}

# Set up loopback connections
setup_loopbacks() {
    echo -e "${YELLOW}[SETUP] Configuring loopback connections...${NC}"
    
    # Connect virtual sinks to recording mix
    pactl load-module module-loopback source=Game.monitor sink=Mix
    pactl load-module module-loopback source=Mic.monitor sink=Mix
    pactl load-module module-loopback source=Media.monitor sink=Mix
    pactl load-module module-loopback source=Chat.monitor sink=Mix
    
    echo -e "${GREEN}[OK] Loopback connections configured${NC}"
}

# Set default devices
set_defaults() {
    echo -e "${YELLOW}[SETUP] Setting default devices...${NC}"
    
    # Set system output
    pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
    
    # Set system input
    pactl set-default-source alsa_input.pci-0000_00_1b.0.analog-stereo
    
    echo -e "${GREEN}[OK] Default devices set${NC}"
}

# Create application routing rules
create_routing_rules() {
    echo -e "${YELLOW}[SETUP] Creating routing rules...${NC}"
    
    # Create directory for custom rules
    mkdir -p ~/.config/wehttamsnaps/audio
    
    # Write routing configuration
    cat > ~/.config/wehttamsnaps/audio/routing.conf << 'EOF'
# WehttamSnaps Audio Routing Configuration
# Rules for automatic application routing

[Game Applications]
steam.exe
gamescope.exe
lutris.exe
proton.exe
wine.exe
Target Sink: Game

[Media Applications]
brave-browser
firefox
chromium
mpv
vlc
Target Sink: Media

[Chat Applications]
Discord
Teamspeak
Mumble
Target Sink: Chat

[Recording Applications]
obs
audacity
 Ardour
Target Source: Mix.monitor
EOF
    
    echo -e "${GREEN}[OK] Routing rules created${NC}"
}

# Create Qpwgraph preset
create_qpwgraph_preset() {
    echo -e "${YELLOW}[SETUP] Creating Qpwgraph preset...${NC}"
    
    mkdir -p ~/.config/qpwgraph
    
    cat > ~/.config/qpwgraph/WehttamSnaps.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<preset name="WehttamSnaps Streaming" version="0.3.8">
  <metadata>
    <creator>WehttamSnaps</creator>
    <comments>Streaming setup with virtual sinks</comments>
  </metadata>
  <graph>
    <node id="1" name="Game" type="sink"/>
    <node id="2" name="Media" type="sink"/>
    <node id="3" name="Chat" type="sink"/>
    <node id="4" name="Mix" type="sink"/>
    <node id="5" name="System Output" type="sink"/>
    <connection source="Game.monitor" target="Mix"/>
    <connection source="Media.monitor" target="Mix"/>
    <connection source="Chat.monitor" target="Mix"/>
    <connection source="Mix.monitor" target="System Output"/>
  </graph>
</preset>
EOF
    
    echo -e "${GREEN}[OK] Qpwgraph preset created${NC}"
}

# Create EasyEffects presets
create_easyeffects_presets() {
    echo -e "${YELLOW}[SETUP] Creating EasyEffects presets...${NC}"
    
    preset_dir="$HOME/.config/easyeffects/output"
    mkdir -p "$preset_dir"
    
    # Gaming preset (low latency)
    cat > "$preset_dir/Gaming.json" << 'EOF'
{
  "output": {
    "blocksize": 128,
    "buffer": 64,
    "bypass": false,
    "plugins_order": [
      "limiter"
    ],
    "limiter": {
      "bypass": false,
      "input-gain": 0,
      "limit": 0,
      "lookahead": 5,
      "mode": "Herm widest",
      "output-gain": 0,
      "release": 50,
      "sidechain": {
        "input": "Left/Right",
        "mode": "RMS",
        "preamp": 0,
        "reactivity": 10,
        "source": "Input"
      }
    }
  }
}
EOF
    
    # Music preset
    cat > "$preset_dir/Music.json" << 'EOF'
{
  "output": {
    "blocksize": 512,
    "buffer": 128,
    "bypass": false,
    "plugins_order": [
      "equalizer",
      "limiter"
    ],
    "equalizer": {
      "bypass": false,
      "input-gain": 0,
      "output-gain": 0,
      "mode": "IIR",
      "num-bands": 10,
      "split-channels": false,
      "bands": [
        {"freq": 32, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 64, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 125, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 250, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 500, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 1000, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 2000, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 4000, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 8000, "gain": 0, "q": 1, "type": "peaking"},
        {"freq": 16000, "gain": 0, "q": 1, "type": "peaking"}
      ]
    },
    "limiter": {
      "bypass": false,
      "input-gain": 0,
      "limit": -1,
      "lookahead": 5,
      "mode": "Herm widest",
      "output-gain": 0,
      "release": 200,
      "sidechain": {
        "input": "Left/Right",
        "mode": "RMS",
        "preamp": 0,
        "reactivity": 10,
        "source": "Input"
      }
    }
  }
}
EOF
    
    echo -e "${GREEN}[OK] EasyEffects presets created${NC}"
}

# Test audio setup
test_audio() {
    echo -e "${YELLOW}[TEST] Testing audio configuration...${NC}"
    
    # Test speaker output
    if speaker-test -t wav -c 2 -l 1; then
        echo -e "${GREEN}[OK] Speaker test passed${NC}"
    else
        echo -e "${YELLOW}[WARN] Speaker test failed${NC}"
    fi
    
    # List available sinks
    echo -e "${BLUE}[INFO] Available audio sinks:${NC}"
    pactl list sinks short
    
    # List available sources
    echo -e "${BLUE}[INFO] Available audio sources:${NC}"
    pactl list sources short
}

# Main function
main() {
    # Check if PipeWire is running
    if ! pgrep -x pipewire > /dev/null; then
        echo -e "\033[0;31m[ERROR] PipeWire is not running. Please start your session first.\033[0m"
        exit 1
    fi
    
    create_virtual_sinks
    setup_loopbacks
    set_defaults
    create_routing_rules
    create_qpwgraph_preset
    create_easyeffects_presets
    test_audio
    
    echo ""
    echo -e "${GREEN}🎵 WehttamSnaps audio setup complete!${NC}"
    echo ""
    echo -e "${YELLOW}📋 Audio sinks created:${NC}"
    echo -e "   • Game (for gaming audio)"
    echo -e "   • Media (for music/browser)"
    echo -e "   • Chat (for Discord/VOIP)"
    echo -e "   • Mix (for recording)"
    echo ""
    echo -e "${YELLOW}🔧 Tools to use:${NC}"
    echo -e "   • EasyEffects: System audio effects"
    echo -e "   • Qpwgraph: Audio routing and connections"
    echo -e "   • Pavucontrol: Volume control"
    echo ""
    echo -e "${BLUE}💡 Next steps:${NC}"
    echo -e "   1. Open Qpwgraph to verify connections"
    echo -e "   2. Test with your favorite applications"
    echo -e "   3. Adjust routing as needed"
}

# Run setup
main "$@"