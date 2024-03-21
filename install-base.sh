#!/bin/bash

sudo cp -f gamescope-session/usr/bin/export-gpu /usr/bin/export-gpu
sudo cp -f gamescope-session/usr/bin/gamescope-session-plus /usr/bin/gamescope-session-plus
sudo cp -f gamescope-session/usr/lib/systemd/user/gamescope-session-plus@.service /usr/lib/systemd/user/gamescope-session-plus@.service
sudo mkdir -p /usr/share/gamescope-session-plus 
sudo cp -f gamescope-session/usr/share/gamescope-session-plus/device-quirks /usr/share/gamescope-session-plus/device-quirks
sudo cp -f gamescope-session/usr/share/gamescope-session-plus/gamescope-session-plus /usr/share/gamescope-session-plus/gamescope-session-plus 

# mkdir -p ~/.config/environment.d/
# cp -f config/gamescope-session-plus.conf ~/.config/environment.d/gamescope-session-plus.conf