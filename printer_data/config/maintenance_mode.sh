#!/bin/bash

# List of timers you identified as risky
TIMERS="fstrim.timer dpkg-db-backup.timer systemd-tmpfiles-clean.timer"

if [ "$1" == "off" ]; then
    echo "Disabling background tasks for printing..."
    sudo systemctl stop cron
    sudo systemctl mask $TIMERS
elif [ "$1" == "on" ]; then
    echo "Enabling background tasks..."
    sudo systemctl unmask $TIMERS
    sudo systemctl start cron
    # Manually trigger a start for timers just in case they were missed
    sudo systemctl start $TIMERS
else
    echo "Usage: $0 {on|off}"
fi
