#!/bin/sh

# Function to reassign workspaces to a specific monitor
reassign_workspaces() {
  local target_monitor=$1
  for i in $(seq 1 10); do
    hyprctl keyword workspace "$i, monitor:$target_monitor"
    hyprctl dispatch moveworkspacetomonitor "$i $target_monitor"
  done
}

handle() {
  hyprctl keyword animations:enabled 0

  if hyprctl monitors all | grep -q "HDMI-A-1"; then
    hyprctl keyword monitor "HDMI-A-1, 2560x1440@144, 0x0, 1.25"
    sleep 0.3
    reassign_workspaces "HDMI-A-1"
    hyprctl dispatch focusmonitor "HDMI-A-1"
    hyprctl keyword monitor "eDP-1, disable"
  else
    hyprctl keyword monitor "eDP-1, 1920x1080@144, 1920x0, 1"
    sleep 0.3
    reassign_workspaces "eDP-1"
    hyprctl dispatch focusmonitor "eDP-1"
  fi

  sleep 0.5
  hyprctl keyword animations:enabled 1
}

handle

# Listen for monitor events (socat path will be handled by Nix environment)
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
  if echo "$line" | grep -qE "monitoradded|monitorremoved"; then
    handle
  fi
done
