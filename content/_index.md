---
title: "Configurar Archlinux com Lxqt "
date: 2026-07-19
draft: false
---

# Archlinux + Lxqt
Este site serve como guia para os interessados em instalar e configurar seu proprio ambiente arch.

## Motivação

Eu tenho um notebook limitado a 8GB de memoria ram soldada, ou seja, nao é possivel efetuar atualização neste componente,
o que gerava lentidão no meu fluxo de estudo e consumos de midias em alta definição. No ambiente anterior com Fedora + KDE Plasma, em idle consumia 2GB de memoria ram, e outra tentativa com Windows 10 aplicando
um processo com debloat agressivo, o mesmo valor.

Com a crescente inserção de IA em todos os programas e ferramentas, o efeito colateral percebido por mim, foi que ao abrir o seguinte conjunto: 
 - 1 Instância do IDEA mais recente (recursos massivos de IA)
 - 2 Abas Edge navegador integrado 
 - 1 Instância do WSL2
 
Esse conjuntos de ferramentas somadas ao Windows ou ate mesmo no Fedora, atingiam o limite de 8GB da memoria RAM.
Ao consultar o preço atualizado de peças, computadores e notebooks, me levou a pensar em alternativas para conseguir usar meu notebook sem todo esse custo computacional jogado ao colo do usuario final

Do ponto de vista no uso de inteligencia artifical no meu dia-a-dia, ela se encaixa perfeitamente como motor consultivo (tradução, duvidas, comparativo, sumarização, tabulação, exemplos, duvidas e etc), portanto não faz sentido eu receber atualizacoes de software com recursos de IA, que nao tem sentido algum para meu uso final, a nao ser consumir recursos computacional do notebook, impossibilitando o uso.

<b>EXECUTADO EM PROCESSADORES INTEL, SERIE RAPTOR LAKE</b>

### 0 - BIOS
Entre na bios do seu computador, e desative o fast bios mode.


### 1 - Baixe o Archlinux

Baixe o Ventoy, efetue a extração e efetue a formatação do pendrive com este programa
Após, copie e cole a ISO do archlinux no pendrive

[Ventoy](https://www.ventoy.net/en/index.html)
[Arch](https://archlinux.org/download/)

### 2 - Inicialize o Archlinux

Acesse a bios do seu computador, e defina a ordem do boot para o pendrive com o ventoy,
apos o restart, a tela do ventoy aparecerá, selecione o arch e pressione enter.

### 3 - Instalar o Archlinux

#### 3.1 - Conectar na Internet

```bash
iwctl
station wlan0 scan
station wlan0 get-networks  
station wlan0 connect NOME_DA_REDE
exit
```

Teste com
```bash
ping archlinux.org
```
para interromper, pressione CTRL+C

#### 3.2 Particione o disco (atenção) e instale o Arch
1. Particiona o disco
Se for instalar do zero:
```bash
fdisk -l
cfdisk /dev/SEU_DISCO  # troca pelo seu disco
```
Atenção: 
Cria 2 partições: 1GB EFI tipo ef00 + resto Linux filesystem

2. Formata e monta
```bash
mkfs.fat -F32 /dev/SEU_DISCO_PARTICAO1
mkfs.ext4 /dev/SEU_DISCO_PARTICAO2

mount /dev/SEU_DISCO_PARTICAO2 /mnt
mkdir /mnt/boot
mount /dev/SEU_DISCO_PARTICAO1 /mnt/boot



```
Exemplo: nvme0n1p1 e nvme0n1p2

3. Instala o sistema base (esse passo pode demorar)
```bash
pacstrap -K /mnt base linux linux-firmware networkmanager

mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

```

4. Gera fstab e entra no sistema

```bash
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

```

5. Configurações básicas dentro do chroot

```bash
# FUSO BR
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

# LANG BR
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

# NOME DO PC
echo "arch" > /etc/hostname

# DEFINA A SENHA DO USUARIO ROOT
passwd

# GRUB
pacman -S --noconfirm grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

```

6. Crie seu usuário
```bash
pacman -S --noconfirm sudo
useradd -m -G wheel user
passwd pass
EDITOR=nano visudo  # descomenta a linha %wheel ALL=(ALL:ALL) ALL
```

7. Habilita a Internet
```bash
systemctl enable NetworkManager
```

8. Sai e reinicia
```bash
exit
umount -R /mnt
reboot
```

Após reiniciar, o sistema solicitará seu usario e senha para acesso via terminal
Login feito, entao:

9. Conecte no Wifi

10. Instale ambiente grafico e demais dependencias
    Por exemplo, lxqt
    ```bash

    # LXQt
    sudo pacman -Sy --noconfirm lxqt lxqt-archiver sddm

    # OPENBOX
    sudo pacman -Sy --noconfirm openbox

    # USB
    sudo pacman -Sy --noconfirm usbutils
    sudo pacman -Sy --noconfirm intel-ucode
    sudo pacman -Sy --noconfirm bolt
    
    # MOUSE and TOUCHPAD
    sudo pacman -Sy --noconfirm xf86-libinput libinput
    
    # BLUETHOOT
    sudo pacman -Sy --noconfirm bluez bluez-utils
    
    # AUDIO
    sudo pacman -Sy --noconfirm sof-firmware alsa-ucm-conf sof-tools
    sudo pacman -Sy --noconfirm pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber alsa-utils
    
    # BROWSER
    sudo pacman -Sy --noconfirm falkon
    
    sudo systemctl enable sddm    # Pra KDE, LXQt, Cinnamon, Deepin, Budgie, i3, Sway
    #sudo systemctl enable gdm --now     # Pra GNOME
    #sudo systemctl enable lightdm --now # Pra XFCE, MATE, Openbox
    
    sudo pacman -Sy --noconfirm --needed --noconfirm \
    intel-media-driver libva-intel-driver libva-utils \
    mesa vulkan-intel vulkan-tools \
    ffmpeg gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav \
    thermald tuned \
    linux-firmware \
    intel-ucode base-devel dkms

    # MONITORES
    sudo pacman -Sy --noconfirm arandr

    # APARENCIA 
    sudo pacman -Sy --noconfirm --needed kvantum
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

    sudo pacman -Sy --noconfirm linux-firmware 
    
    ```

### Recomendações
1. Troca o bash pelo fish
2. Limite a carga do journald na ram
   O systemd-journald come RAM guardando log:
   ```bash
   sudo vim /etc/systemd/journald.conf
   ```
   Edite com estes valores
   SystemMaxUse=10M
   Storage=volatile
   Depois: 
   ```bash
   sudo systemctl restart systemd-journald
   ```
3. Instalar Fish
   ```bash
   sudo pacman -S fish
   chsh -s /usr/bin/fish
   ```
   Depois faz logout e login. Fish já vem com autocomplete e gasta parecido com bash, mas é mais rápido.
   
4. Mudar NetworkManager por iwd + dhcpcd
   Instalar
   ```bash
   sudo pacman -S iwd dhcpcd
   ```

   Desativar NetworkManager e ativar iwd e dhcpcd
   ```bash
   sudo systemctl disable NetworkManager
   sudo systemctl stop NetworkManager
   sudo systemctl enable iwd
   sudo systemctl start iwd
   sudo systemctl enable dhcpcd
   sudo systemctl start dhcpcd
   
   ```

   Pra conectar wifi no iwd depois do reboot:
   ```bash
   iwctl
   station wlan0 scan
   station wlan0 get-networks
   station wlan0 connect NOME_DA_REDE
   # DIGITA SUA SENHA
   exit
   ```
   Teste se conectou com <code> ping archlinux.org </code>


### Pacotes
```bash

a52dec
abseil-cpp
acl
adapta-gtk-theme
adw-gtk-theme
adwaita-cursors
adwaita-fonts
adwaita-icon-theme
adwaita-icon-theme-legacy
alsa-card-profiles
alsa-lib
alsa-topology-conf
alsa-ucm-conf
alsa-utils
analitza
aom
apache
appstream
apr
apr-util
arandr
archlinux-keyring
at-spi2-core
attica
attr
audit
avahi
avogadro-crystals
avogadro-fragments
avogadro-molecules
avogadrolibs
avogadrolibs-qt
base
bash
binutils
bluez
bluez-libs
bluez-obex
bolt
boost-libs
breeze
breeze-cursors
breeze-gtk
breeze-icons
brotli
bubblewrap
bzip2
ca-certificates
ca-certificates-mozilla
ca-certificates-utils
cairo
cairomm-1.16
caja-extensions-common
colord-gtk-common
colord-gtk4
confuse
coordgen
coreutils
cosmic-icon-theme
cosmic-sound-theme
cosmic-wallpapers
cpupower
cronie
cryptsetup
cups-pk-helper
curl
dav1d
db5.3
dbus
dbus-broker
dbus-broker-units
dbus-units
dconf
deepin-gtk-theme
deepin-icon-theme
deepin-sound-theme
deepin-wallpapers
default-cursors
desktop-file-utils
device-mapper
dhcpcd
diffutils
docbook-xml
docbook-xsl
double-conversion
duktape
e2fsprogs
efibootmgr
efivar
elementary-icon-theme
elementary-wallpapers
ell
expat
faad2
falkon
featherpad
ffmpeg
fftw
file
filesystem
findutils
flac
fmt
fontconfig
frameworkintegration
freerdp
freetype2
fribidi
fuse-common
fuse3
gammastep
gawk
gcc-libs
gcr-4
gdbm
gdk-pixbuf2
gettext
giflib
glew
glib-networking
glib2
glibc
glibmm-2.68
glslang
glu
glycin
gmp
gnome-bluetooth-3.0
gnome-keybindings
gnome-menus
gnome-online-accounts
gnu-free-fonts
gnulib-l10n
gnupg
gnutls
gobject-introspection-runtime
gperftools
gpgme
gpgmepp
gpm
granite
graphene
graphite
grep
grim
grub
gsettings-desktop-schemas
gsettings-system-schemas
gsm
gsound
gssdp
gst-plugins-bad-libs
gst-plugins-base-libs
gstreamer
gtest
gtk-session-lock
gtk-theme-elementary
gtk-update-icon-cache
gtk3
gtk4
gtklock
gtkmm-4.0
gupnp
gupnp-igd
gzip
harfbuzz
hdf5
hicolor-icon-theme
hidapi
highway
htop
hunspell
hwdata
hwloc
iana-etc
icu
imagemagick
imlib2
inchi
intel-ucode
iproute2
iptables
iputils
iso-codes
iwd
jansson
jbigkit
jkqtplotter
json-c
json-glib
karchive
kbd
kbookmarks
kcachegrind-common
kcmutils
kcodecs
kcolorscheme
kcompletion
kconfig
kconfigwidgets
kcoreaddons
kcrash
kdbusaddons
kdecoration
kdiagram
kdoctools
keyutils
kglobalaccel
kguiaddons
ki18n
kiconthemes
kidletime
kio
kirigami
kitemviews
kjobwidgets
kmod
knewstuff
knotifications
kpackage
kpmcore
kqtquickcharts
krb5
kservice
ktexttemplate
kunitconversion
kvantum
kwallet
kwidgetsaddons
kwindowsystem
kxmlgui
l-smash
lame
layer-shell-qt
lcms2
leancrypto
less
libadwaita
libaec
libao
libappindicator
libarchive
libasan
libass
libassuan
libasyncns
libatasmart
libatomic
libavc1394
libavif
libb2
libblake3
libblockdev
libblockdev-crypto
libblockdev-fs
libblockdev-loop
libblockdev-mdraid
libblockdev-nvme
libblockdev-part
libblockdev-smart
libblockdev-swap
libbluray
libbpf
libbs2b
libbsd
libbytesize
libcamera
libcamera-ipa
libcanberra
libcap
libcap-ng
libcbor
libcloudproviders
libcolord
libcups
libdaemon
libdatrie
libdbusmenu-glib
libdbusmenu-gtk3
libdbusmenu-lxqt
libdeflate
libdovi
libdrm
libdvdnav
libdvdread
libebml
libebur128
libedit
libelf
libepoxy
libev
libevdev
libevent
libexif
libfdk-aac
libffi
libfido2
libfm-extra
libfm-qt
libfontenc
libfreeaptx
libfyaml
libgcc
libgcrypt
libgee
libgfortran
libgirepository
libglvnd
libgoa
libgomp
libgpg-error
libgudev
libhwasan
libical
libice
libidn2
libiec61883
libimagequant
libimobiledevice
libimobiledevice-glue
libinih
libinput
libjpeg-turbo
libjxl
libksba
libkscreen
liblc3
libldac
libldap
liblqr
liblsan
liblxqt
libmakepkg-dropins
libmatekbd
libmatemixer
libmatroska
libmd
libmm-glib
libmnl
libmodplug
libmsym
libmysofa
libndp
libnetfilter_conntrack
libnewt
libnfnetlink
libnftnl
libnghttp2
libnghttp3
libngtcp2
libnice
libnl
libnm
libnma
libnma-common
libnotify
libnsl
libnvme
libobjc
libogg
libopenmpt
libp11-kit
libpcap
libpciaccess
libpgm
libpipewire
libplacebo
libplist
libpng
libproxy
libpsl
libpulse
libqtxdg
libquadmath
libraqm
libraw1394
librest
librsvg
libsamplerate
libsasl
libseccomp
libsecret
libshout
libsigc++-3.0
libsm
libsndfile
libsodium
libsoup3
libsoxr
libssh
libssh2
libstdc++
libstemmer
libsynctex
libsysprof-capture
libtasn1
libtatsu
libteam
libthai
libtheora
libtiff
libtirpc
libtool
libtsan
libubsan
libunibreak
libunistring
libunwind
liburing
libusb
libusbmuxd
libva
libvdpau
libverto
libvlc
libvorbis
libvpl
libvpx
libwacom
libwebp
libwireplumber
libx11
libxau
libxcb
libxcomposite
libxcrypt
libxcursor
libxcvt
libxdamage
libxdmcp
libxext
libxfixes
libxfont2
libxft
libxi
libxinerama
libxkbcommon
libxkbcommon-x11
libxkbfile
libxklavier
libxml2
libxmlb
libxmu
libxrandr
libxrender
libxshmfence
libxslt
libxss
libxt
libxtst
libxv
libxxf86vm
libyaml
libyuv
licenses
lightdm
lightdm-gtk-greeter
lilv
linux
linux-api-headers
linux-firmware
linux-firmware-amdgpu
linux-firmware-atheros
linux-firmware-broadcom
linux-firmware-cirrus
linux-firmware-intel
linux-firmware-mediatek
linux-firmware-nvidia
linux-firmware-other
linux-firmware-radeon
linux-firmware-realtek
linux-firmware-whence
linux-headers
llvm-libs
lm_sensors
lmdb
lua
lua54
lv2
lxde-icon-theme
lximage-qt
lxqt-about
lxqt-admin
lxqt-archiver
lxqt-config
lxqt-globalkeys
lxqt-menu-data
lxqt-notificationd
lxqt-openssh-askpass
lxqt-panel
lxqt-policykit
lxqt-powermanagement
lxqt-qtplugin
lxqt-runner
lxqt-session
lxqt-sudo
lxqt-themes
lz4
lzo
maeparser
marble-common
mate-icon-theme
materia-gtk-theme
mathjax2
md4c
mdadm
media-player-info
menu-cache
mesa
minizip
mkinitcpio
mkinitcpio-busybox
mobile-broadband-provider-info
mod_dnssd
mpdecimal
mpfr
mpg123
mtdev
muparser
ncurses
nettle
networkmanager
nftables
nm-connection-editor
noto-fonts
npth
nspr
nss
obconf-qt
obsidian-icon-theme
ocean-sound-theme
ocl-icd
onetbb
openbabel
openbox
opencore-amr
openh264
openjpeg2
openssh
openssl
opus
opusfile
orc
orchis-theme
os-prober
oxygen-icons
oxygen-sounds
p11-kit
pacman
pacman-mirrorlist
pahole
pam
pambase
pango
pangomm-2.48
papirus-icon-theme
parted
pavucontrol-qt
pciutils
pcmanfm-qt
pcre
pcre2
pcsclite
perl
phonon-qt6
phonon-qt6-vlc
pinentry
pipewire
pipewire-alsa
pipewire-audio
pipewire-jack
pipewire-pulse
pipewire-session-manager
pixman
plasma-workspace-wallpapers
polkit
polkit-qt6
pop-icon-theme
popt
portaudio
procps-ng
protobuf
psmisc
pugixml
pulse-native-provider
python
python-cairo
python-cairocffi
python-cairosvg
python-cffi
python-cssselect2
python-defusedxml
python-gobject
python-packaging
python-pillow
python-pycparser
python-pyparsing
python-pyudev
python-svgwrite
python-systemd
python-tinycss2
python-webencodings
qca-qt6
qt6-5compat
qt6-base
qt6-declarative
qt6-positioning
qt6-shadertools
qt6-svg
qt6-translations
qt6-webchannel
qt6-webengine
qterminal
qtermwidget
qtkeychain-qt6
qtxdg-tools
rav1e
re2
readline
rubberband
run-parts
sbc
screengrab
sddm
sdl2-compat
sdl3
sdl3_ttf
sed
serd
shaderc
shadow
shared-mime-info
slang
slurp
smartmontools
snappy
sndio
socat
sof-firmware
sof-tools
solid
sord
sound-theme-elementary
sound-theme-freedesktop
spandsp
speex
speexdsp
spglib
spirv-tools
sqlite
sratom
srt
startup-notification
sudo
svt-av1
swaybg
swayidle
swaylock
syndication
systemd
systemd-libs
systemd-sysvcompat
taglib
tar
tdb
tecla
tinysparql
tpm2-tss
tslib
ttf-atkinson-hyperlegible
twolame
tzdata
udisks2
upower
usbutils
util-linux
util-linux-libs
v4l-utils
vapoursynth
vid.stab
vim
vim-runtime
vlc-plugin-a52dec
vlc-plugin-alsa
vlc-plugin-archive
vlc-plugin-dav1d
vlc-plugin-dbus
vlc-plugin-dbus-screensaver
vlc-plugin-faad2
vlc-plugin-flac
vlc-plugin-gnutls
vlc-plugin-inflate
vlc-plugin-journal
vlc-plugin-jpeg
vlc-plugin-matroska
vlc-plugin-mpg123
vlc-plugin-ogg
vlc-plugin-opus
vlc-plugin-png
vlc-plugin-shout
vlc-plugin-speex
vlc-plugin-tag
vlc-plugin-theora
vlc-plugin-twolame
vlc-plugin-vorbis
vlc-plugin-vpx
vlc-plugin-xml
vlc-plugins-base
vmaf
volume_key
vorbis-tools
vulkan-icd-loader
wayland
wdisplays
webrtc-audio-processing-1
wf-recorder
wireless_tools
wireplumber
wlopm
wpa_supplicant
x264
x265
xapian-core
xcb-proto
xcb-util
xcb-util-cursor
xcb-util-image
xcb-util-keysyms
xcb-util-renderutil
xcb-util-wm
xcb-util-xrm
xdg-desktop-portal
xdg-desktop-portal-gtk
xdg-desktop-portal-lxqt
xdg-desktop-portal-wlr
xdg-user-dirs
xdg-utils
xf86-input-libinput
xkeyboard-config
xorg-fonts-encodings
xorg-server
xorg-server-common
xorg-setxkbmap
xorg-xauth
xorg-xkbcomp
xorg-xmodmap
xorg-xprop
xorg-xrandr
xorg-xrdb
xorgproto
xprintidle
xvidcore
xxhash
xz
yajl
zeromq
zimg
zip
zix
zlib
zram-generator
zstd


```


### Links úteis

https://www.jetbrains.com/pt-br/idea/download/other/#releases-2024
https://download.jetbrains.com/idea/ideaIC-2023.2.5.tar.gz
https://www.jetbrains.com/pt-br/webstorm/download/other/#releases-2024
https://download.jetbrains.com/webstorm/WebStorm-2024.1.7.tar.gz

