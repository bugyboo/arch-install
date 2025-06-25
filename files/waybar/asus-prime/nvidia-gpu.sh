#!/bin/bash

# Fetch GPU memory details using nvidia-smi
total_mem=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
used_mem=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
free_mem=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits)
reserved_mem=$(nvidia-smi --query-gpu=memory.reserved --format=csv,noheader,nounits)

# Calculate percentage of memory used
percent_used=$(echo "scale=2; ($used_mem / $total_mem) * 100" | bc | awk '{printf "%.0f", $0}')

# Create tooltip with detailed information
tooltip="GPU Memory:\nTotal: $total_mem MiB\nUsed: $used_mem MiB\nFree: $free_mem MiB\nReserved: $reserved_mem MiB"

# Output JSON for Waybar
echo "{\"text\": \"$percent_used%\", \"tooltip\": \"$tooltip\"}"