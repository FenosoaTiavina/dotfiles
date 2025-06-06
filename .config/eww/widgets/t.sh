#!/bin/bash
pgrep -f "python /home/fenosoa/.local/bin/idle-inhibitor.py --all" > /dev/null && echo 'on' || echo 'off'
