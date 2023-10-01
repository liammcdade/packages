#!/bin/bash/
emerge --ask xfce-base/xfce4-meta
env-update && . /etc/profile
emerge --ask x11-terms/xfce4-terminal
emerge --ask xfce-extra/xfce4-pulseaudio-plugin xfce-extra/xfce4-taskmanager x11-themes/xfwm4-themes app-editors/mousepad xfce-base/xfce4-power-manager x11-terms/xfce4-terminal xfce-base/thunar
