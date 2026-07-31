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
    Baixe-o [aqui](https://drive.google.com/drive/folders/13tuAH1TGpU4rDZynqm2xRj9N3ifgbEEw?usp=sharing) depois rode no terminal com
    ```bash
    sh setup-arch-with-lxqt-intel-raptor-lake-proc.sh
    ```

    ```bash

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

    #adb devices

    # HD
    sudo pacman -Sy --noconfirm --needed udisks2 udiskie gvfs ntfs-3g
    sudo systemctl enable --now udisks2
    
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

    # GIT
    sudo pacman -Sy --noconfirm --needed git
    
    # JAVA
    sudo pacman -Sy --noconfirm --needed jdk21-openjdk
    
    # MAVEN
    sudo pacman -Sy --noconfirm --needed maven


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

    # DOCA
    sudo pacman -Sy --noconfirm --needed plank


    sudo pacman -Sy --noconfirm --needed linux-firmware 


    sudo systemctl enable --now bluetooth

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

adapta-gtk-theme 3.95.0.11-4
adw-gtk-theme 6.5-1
alsa-utils 1.2.16-1
arandr 0.1.11-6
base 3-3
blueman 2.4.6-2
bluez-utils 5.87-2
bolt 0.9.11-1
breeze 6.7.3-1
breeze-cursors 6.7.3-1
breeze-gtk 6.7.3-1
cosmic-icon-theme 1:1.4.0-1
cosmic-sound-theme 1.4.0-1
cosmic-wallpapers 2:1.4.0-1
deepin-gtk-theme 1:25.3.7-2
deepin-icon-theme 2026.02.27-1
deepin-sound-theme 15.10.6-2
deepin-wallpapers 1:1.7.26-1
dhcpcd 10.3.2-1
efibootmgr 18-4
elementary-icon-theme 8.2.0-2
elementary-wallpapers 8.0.0-2
falkon 26.04.3-1
featherpad 1.6.3-1
grub 2:2.14-1
gtk-theme-elementary 8.2.2-2
htop 3.5.2-1
intel-ucode 20260512-1
iwd 3.12-1
layer-shell-qt 6.7.3-1
less 1:704-1
libkscreen 6.7.3-1
lightdm 1:1.32.0-9
lightdm-gtk-greeter 1:2.0.9-2
linux 7.1.4.arch1-1
linux-firmware 20260622-1
linux-headers 7.1.4.arch1-1
lxde-icon-theme 0.5.2-2
lximage-qt 2.4.0-1
lxqt-about 2.4.0-1
lxqt-admin 2.4.0-1
lxqt-archiver 1.4.0-1
lxqt-config 2.4.0-1
lxqt-globalkeys 2.4.0-1
lxqt-menu-data 2.4.0-1
lxqt-notificationd 2.4.0-1
lxqt-openssh-askpass 2.4.0-1
lxqt-panel 2.4.1-1
lxqt-policykit 2.4.0-1
lxqt-powermanagement 2.4.0-1
lxqt-qtplugin 2.4.0-2
lxqt-runner 2.4.0-1
lxqt-session 2.4.0-2
lxqt-sudo 2.4.0-1
lxqt-themes 2.4.0-1
mate-icon-theme 1.28.0-2
networkmanager 1.58.0-1
obconf-qt 0.16.6-1
obsidian-icon-theme 4.15-3
ocean-sound-theme 6.7.3-1
openbox 3.6.1-14
orchis-theme 2026_07_07-1
os-prober 1.84-1
oxygen-icons 1:6.28.0-1
oxygen-sounds 6.7.3-1
papirus-icon-theme 20250501-1
pavucontrol-qt 2.4.0-1
pcmanfm-qt 2.4.0-1
pipewire-alsa 1:1.6.8-1
pipewire-jack 1:1.6.8-1
plasma-workspace-wallpapers 6.7.3-1
pop-icon-theme 3.5.1-1
qterminal 2.4.0-1
screengrab 3.2.0-1
sddm 0.21.0-7
sof-firmware 2025.12.2-1
sof-tools 2025.12.2-1
sound-theme-elementary 1.1.0-4
sudo 1.9.17.p2-6
swaylock 1.8.6-1
ttf-atkinson-hyperlegible 1.006-2
usbutils 019-1
vim 9.2.0804-1
xdg-desktop-portal-lxqt 1.4.0-1
zram-generator 1.2.1-1


```


### Links úteis

https://www.jetbrains.com/pt-br/idea/download/other/#releases-2024
https://download.jetbrains.com/idea/ideaIC-2023.2.5.tar.gz
https://www.jetbrains.com/pt-br/webstorm/download/other/#releases-2024
https://download.jetbrains.com/webstorm/WebStorm-2024.1.7.tar.gz

