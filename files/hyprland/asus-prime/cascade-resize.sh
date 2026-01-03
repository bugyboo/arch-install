#!/bin/bash
# Get window count on workspace 1
count=$(hyprctl clients -j | jq '[.[] | select(.workspace.id == 1)] | length')

# scale=$(echo "0.9 ^ ($count - 1)" | bc -l)
# width=$(echo "3072 * $scale" | bc | cut -d. -f1)  # 80% of 3840
# height=$(echo "1728 * $scale" | bc | cut -d. -f1) # 80% of 2160
# hyprctl dispatch resizeactive exact $width $height

# Base offset from corner for first window
base_offset=100

# Calculate offset based on window count (cascade effect)
offset=$(( base_offset + (count - 1) * 50 ))

# Move window to cascaded position
hyprctl dispatch moveactive exact $offset $offset