#!/bin/bash


sudo cp -f gamescope-session-steam/usr/bin/jupiter-biosupdate /usr/bin/jupiter-biosupdate
sudo cp -f gamescope-session-steam/usr/bin/steam-http-loader /usr/bin/steam-http-loader
sudo cp -f gamescope-session-steam/usr/bin/steamos-select-branch /usr/bin/steamos-select-branch
sudo cp -f gamescope-session-steam/usr/bin/steamos-session-select /usr/bin/steamos-session-select
sudo cp -f gamescope-session-steam/usr/bin/steamos-update /usr/bin/steamos-update
sudo mkdir -p /usr/bin/steamos-polkit-helpers
sudo cp -f gamescope-session-steam/usr/bin/steamos-polkit-helpers/* /usr/bin/steamos-polkit-helpers/

sudo cp -f gamescope-session-steam/usr/share/applications/gamescope-mimeapps.list /usr/share/applications/gamescope-mimeapps.list 
sudo cp -f gamescope-session-steam/usr/share/applications/steam_http_loader.desktop /usr/share/applications/steam_http_loader.desktop

sudo mkdir -p /usr/share/gamescope-session-plus/sessions.d
sudo cp -f gamescope-session-steam/usr/share/gamescope-session-plus/sessions.d/steam /usr/share/gamescope-session-plus/sessions.d/steam

sudo cp -f gamescope-session-steam/usr/share/polkit-1/actions/org.chimeraos.update.policy /usr/share/polkit-1/actions/org.chimeraos.update.policy
sudo cp -f gamescope-session-steam/usr/share/wayland-sessions/gamescope-session-steam.desktop /usr/share/wayland-sessions/gamescope-session-steam.desktop 
sudo ln -s /usr/share/wayland-sessions/gamescope-session-steam.desktop /usr/share/wayland-sessions/gamescope-session.desktop