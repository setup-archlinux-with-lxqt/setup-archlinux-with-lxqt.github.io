#!/bin/bash

# MIRRORS
sudo pacman -Sy --noconfirm --needed reflector
sudo reflector --country Brazil --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy
sudo reflector --country Brazil --latest 5 --sort rate

# LXQT
sudo pacman -Sy --noconfirm --needed lxqt lxqt-archiver
sudo pacman -Sy --noconfirm --needed xsettingsd

# OPENBOX
sudo pacman -Sy --noconfirm --needed openbox

# USB
sudo pacman -Sy --noconfirm --needed usbutils
sudo pacman -Sy --noconfirm --needed intel-ucode
sudo pacman -Sy --noconfirm --needed bolt

# HD
sudo pacman -Sy --noconfirm --needed udisks2 udiskie gvfs ntfs-3g

# MOUSE e TOUCHPAD
sudo pacman -Sy --noconfirm --needed xf86-libinput libinput

# BLUETHOOT
sudo pacman -Sy --noconfirm --needed blueman bluez bluez-utils

# AUDIO
sudo pacman -Sy --noconfirm --needed sof-firmware alsa-ucm-conf sof-tools
sudo pacman -Sy --noconfirm --needed pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber alsa-utils

# BROWSER e DOWNLOAD
sudo pacman -Sy --noconfirm --needed falkon
sudo pacman -Sy --noconfirm --needed uget aria2

sudo systemctl enable sddm    # Pra KDE, LXQt, Cinnamon, Deepin, Budgie, i3, Sway
#sudo systemctl enable gdm --now     # Pra GNOME
#sudo systemctl enable lightdm --now # Pra XFCE, MATE, Openbox

# DRIVERS
sudo pacman -Sy --noconfirm --needed intel-media-driver
sudo pacman -Sy --noconfirm --needed libva-intel-driver
sudo pacman -Sy --noconfirm --needed libva-utils
sudo pacman -Sy --noconfirm --needed mesa
sudo pacman -Sy --noconfirm --needed vulkan-intel
sudo pacman -Sy --noconfirm --needed vulkan-tools
sudo pacman -Sy --noconfirm --needed ffmpeg
sudo pacman -Sy --noconfirm --needed vulkan-tools
sudo pacman -Sy --noconfirm --needed vulkan-tools
sudo pacman -Sy --noconfirm --needed gst-plugins-good 
sudo pacman -Sy --noconfirm --needed gst-plugins-bad 
sudo pacman -Sy --noconfirm --needed gst-plugins-ugly 
sudo pacman -Sy --noconfirm --needed gst-libav
sudo pacman -Sy --noconfirm --needed thermald 
sudo pacman -Sy --noconfirm --needed tuned 
sudo pacman -Sy --noconfirm --needed linux-firmware 
sudo pacman -Sy --noconfirm --needed intel-ucode 
sudo pacman -Sy --noconfirm --needed base-devel 
sudo pacman -Sy --noconfirm --needed dkms

# MONITORES
sudo pacman -Sy --noconfirm --needed arandr

# APARENCIA 
sudo pacman -Sy --noconfirm --needed breeze-gtk   
sudo pacman -Sy --noconfirm --needed papirus-icon-theme
sudo pacman -Sy --noconfirm --needed plasma-workspace-wallpapers
sudo pacman -Sy --noconfirm --needed elementary-wallpapers
sudo pacman -Sy --noconfirm --needed deepin-wallpapers
sudo pacman -Sy --noconfirm --needed cosmic-wallpapers
sudo pacman -Sy --noconfirm --needed archlinux-wallpapers
sudo pacman -Sy --noconfirm --needed ttf-atkinson-hyperlegible
sudo pacman -Sy --noconfirm --needed sound-theme-freedesktop
sudo pacman -Sy --noconfirm --needed pop-icon-theme 
sudo pacman -Sy --noconfirm --needed papirus-icon-theme
sudo pacman -Sy --noconfirm --needed oxygen-sounds
sudo pacman -Sy --noconfirm --needed oxygen-icons
sudo pacman -Sy --noconfirm --needed orchis-theme
sudo pacman -Sy --noconfirm --needed ocean-sound-theme
sudo pacman -Sy --noconfirm --needed obsidian-icon-theme
sudo pacman -Sy --noconfirm --needed materia-gtk-theme
sudo pacman -Sy --noconfirm --needed mate-icon-theme
sudo pacman -Sy --noconfirm --needed lxqt-themes
sudo pacman -Sy --noconfirm --needed lxde-icon-theme
sudo pacman -Sy --noconfirm --needed gtk-theme-elementary
sudo pacman -Sy --noconfirm --needed elementary-icon-theme
sudo pacman -Sy --noconfirm --needed sound-theme-elementary
sudo pacman -Sy --noconfirm --needed deepin-sound-theme 
sudo pacman -Sy --noconfirm --needed deepin-icon-theme
sudo pacman -Sy --noconfirm --needed deepin-gtk-theme
sudo pacman -Sy --noconfirm --needed cosmic-sound-theme
sudo pacman -Sy --noconfirm --needed cosmic-icon-theme
sudo pacman -Sy --noconfirm --needed breeze-icons
sudo pacman -Sy --noconfirm --needed breeze-gtk
sudo pacman -Sy --noconfirm --needed adwaita-icon-theme
sudo pacman -Sy --noconfirm --needed adw-gtk-theme
sudo pacman -Sy --noconfirm --needed adapta-gtk-theme

sudo pacman -Sy --noconfirm --needed linux-firmware 


sudo systemctl enable --now bluetooth
