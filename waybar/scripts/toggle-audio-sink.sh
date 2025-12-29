#!/usr/bin/env bash
set -euo pipefail

########################################
# File to remember last-used sink
########################################
DEFAULT_FILE="$HOME/.current_sink"

########################################
# Collect all available sinks (Node IDs + names)
########################################

mapfile -t sinks < <(
  pw-dump | jq -r '
    [
      .[] |
      select(.type=="PipeWire:Interface:Node") |
      select(.info.props."media.class" == "Audio/Sink") |
      select(.info.props."node.disabled" != "true") |
      {
        id: .id,
        name: (.info.props."node.nick" // .info.props."node.name")
      }
    ]
    | unique_by(.name)
    | sort_by(
        if (.name | test("Plantronics|BT|Bluetooth"; "i")) then 0
        elif (.name | test("USB"; "i")) then 1
        elif (.name | test("ALC|Analog"; "i")) then 2
        elif (.name | test("HDMI"; "i")) then 3
        else 4 end
      )
    | .[]
    | "\(.id)|\(.name)"
  '
)

# No sinks? exit
(( ${#sinks[@]} > 0 )) || exit 0

########################################
# Determine current sink from last-used file
########################################

current=""
if [[ -f "$DEFAULT_FILE" ]]; then
    current=$(<"$DEFAULT_FILE")
fi

########################################
# Select next sink in the array
########################################

next_id=""
next_name=""

for i in "${!sinks[@]}"; do
    IFS='|' read -r id name <<< "${sinks[$i]}"
    if [[ "$id" == "$current" ]]; then
        next_index=$(( (i + 1) % ${#sinks[@]} ))
        IFS='|' read -r next_id next_name <<< "${sinks[$next_index]}"
        break
    fi
done

# fallback if current not found
if [[ -z "$next_id" ]]; then
    IFS='|' read -r next_id next_name <<< "${sinks[0]}"
fi

########################################
# Switch default sink
########################################

wpctl set-default "$next_id"

# Save last-used sink
echo "$next_id" > "$DEFAULT_FILE"

########################################
# Move all active streams to new sink
########################################

wpctl status |
  awk '/Streams:/,/Sinks:/' |
  grep -E '^[[:space:]]*[0-9]+\.' |
  sed -E 's/^[^0-9]*([0-9]+).*/\1/' |
  while read -r stream; do
    wpctl move "$stream" "$next_id" >/dev/null 2>&1 || true
  done

########################################
# Send a notification (Wayland-safe)
########################################

if command -v notify-send >/dev/null; then
    notify-send \
      "Audio Output Switched" \
      "$next_name" \
      -h string:x-canonical-private-synchronous:audio
fi

