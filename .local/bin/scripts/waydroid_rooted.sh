#!/usr/bin/env bash

# Check the status of Waydroid session
waydroid_status=$(waydroid status | grep -E 'Session:')

if grep -q "RUNNING" <<< "$waydroid_status"; then
    waydroid show-full-ui
elif grep -q "STOPPED" <<< "$waydroid_status"; then
    waydroid show-full-ui &  # Start Waydroid environment in the background
    notify-send "Waydroid is starting"
    sleep 10
    pkexec waydroid shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh
else
    notify-send "Waydroid status is unknown or not found"
fi
