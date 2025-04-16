#!/bin/bash

# Start ROS foxglove_bridge in background
roslaunch foxglove_bridge foxglove_bridge.launch &
ROS_PID=$!

# Wait briefly to let ROS initialize
sleep 3

# Start cloudflared and capture tunnel URL
cloudflared tunnel --url http://localhost:8765 2>&1 | while read line; do
    echo "$line" | grep -oP 'https://\K[\w.-]+(?=\.trycloudflare\.com)' | while read subdomain; do
        echo ""
        echo "✅ Public WebSocket URL:"
        echo "ws://${subdomain}.trycloudflare.com"
        echo ""
        break 2  # Exit both loops once URL is printed
    done
done &

CLOUDFLARED_PID=$!

# Wait for ROS process to finish
wait $ROS_PID

# Cleanup tunnel when ROS stops
kill $CLOUDFLARED_PID 2>/dev/null

