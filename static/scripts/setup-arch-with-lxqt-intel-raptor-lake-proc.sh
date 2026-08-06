
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
sudo pacman -Sy --noconfirm --needed android-tools
sudo pacman -Sy --noconfirm --needed gvfs
sudo pacman -Sy --noconfirm --needed gvfs-mtp
sudo pacman -Sy --noconfirm --needed gvfs-goa 

# HD
sudo pacman -Sy --noconfirm --needed udisks2 udiskie gvfs ntfs-3g
sudo systemctl enable --now udisks2

# MOUSE e TOUCHPAD
sudo pacman -Sy --noconfirm --needed xf86-libinput libinput

# BLUETHOOT
sudo pacman -Sy --noconfirm --needed blueman bluez bluez-utils
sudo systemctl enable --now bluetooth

# AUDIO
sudo pacman -Sy --noconfirm --needed sof-firmware alsa-ucm-conf sof-tools
sudo pacman -Sy --noconfirm --needed pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber alsa-utils

# BROWSER e DOWNLOAD
sudo pacman -Sy --noconfirm --needed falkon
sudo pacman -Sy --noconfirm --needed uget aria2

# EREADERS
sudo pacman -Sy --noconfirm --needed calibre okular

# GIT
sudo pacman -Sy --noconfirm --needed git

# JAVA
sudo pacman -Sy --noconfirm --needed jdk21-openjdk

# MAVEN
sudo pacman -Sy --noconfirm --needed maven

# LOGIN
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
sudo pacman -Sy --noconfirm --needed qt5ct
sudo pacman -Sy --noconfirm --needed qt6ct
sudo pacman -Sy --noconfirm --needed kvantum
sudo pacman -Sy --noconfirm --needed lxappearance
sudo pacman -Sy --noconfirm --needed lxappearance-obconf
sudo pacman -Sy --noconfirm --needed obconf-qt


# TEMAS
sudo pacman -Sy --noconfirm --needed breeze
sudo pacman -Sy --noconfirm --needed breeze-gtk   
sudo pacman -Sy --noconfirm --needed kvantum-qt5
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
sudo pacman -Sy --noconfirm --needed adw-gtk-theme
sudo pacman -Sy --noconfirm --needed deepin-gtk-theme
sudo pacman -Sy --noconfirm --needed gtk-theme-elementary
sudo pacman -Sy --noconfirm --needed materia-gtk-theme
sudo pacman -Sy --noconfirm --needed pop-gtk-theme
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-all
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-black
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-blue
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-brown
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-dracula
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-green
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-grey
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-manjaro
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-nord
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-orange
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-pink
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-purple
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-red
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-standard
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-ubuntu
sudo pacman -Sy --noconfirm --needed tela-circle-icon-theme-yellow

# FONTES
sudo pacman -Sy --noconfirm --needed noto-fonts-extra
sudo pacman -Sy --noconfirm --needed opendesktop-fonts
sudo pacman -Sy --noconfirm --needed otf-atkinson-hyperlegible
sudo pacman -Sy --noconfirm --needed otf-atkinsonhyperlegiblemono-nerd
sudo pacman -Sy --noconfirm --needed ttf-fira-code
sudo pacman -Sy --noconfirm --needed ttf-fira-mono
sudo pacman -Sy --noconfirm --needed ttf-fira-sans
sudo pacman -Sy --noconfirm --needed ttf-firacode-nerd
sudo pacman -Sy --noconfirm --needed ttf-jetbrains-mono
sudo pacman -Sy --noconfirm --needed ttf-jetbrains-mono-nerd
sudo pacman -Sy --noconfirm --needed ttf-nerd-fonts-symbols
sudo pacman -Sy --noconfirm --needed ttf-nerd-fonts-symbols-common
sudo pacman -Sy --noconfirm --needed ttf-nerd-fonts-symbols-mono
sudo pacman -Sy --noconfirm --needed ttf-roboto
sudo pacman -Sy --noconfirm --needed ttf-roboto-mono
sudo pacman -Sy --noconfirm --needed ttf-roboto-mono-nerd
sudo pacman -Sy --noconfirm --needed ttf-space-mono-nerd
sudo pacman -Sy --noconfirm --needed ttf-ubuntu-font-family
sudo pacman -Sy --noconfirm --needed ttf-ubuntu-nerd
sudo pacman -Sy --noconfirm --needed ttf-victor-mono-nerd
sudo pacman -Sy --noconfirm --needed ttf-zed-mono-nerd

# DOCA
sudo pacman -Sy --noconfirm --needed plank

# SYS INFO
sudo pacman -Sy --noconfirm --needed fastfetch

# SSH
sudo pacman -Sy --noconfirm --needed openssh
sudo systemctl start sshd
sudo systemctl enable sshd

# FIREWALL IPTABLES
# INTRANET (LIBERA CONEXOES NO FIREWALL APENAS NA REDE LOCAL)
sudo iptables -A INPUT -p tcp -s 192.168.1.0/24 --dport 22 -j ACCEPT

sudo pacman -Sy --noconfirm --needed linux-firmware 
