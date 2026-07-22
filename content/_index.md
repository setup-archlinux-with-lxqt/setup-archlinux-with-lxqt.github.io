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

10. Instale ambiente grafico de sua preferencia
    Por exemplo, lxqt
    ```bash
    sudo pacman -S lxqt lxqt-archiver sddm
    sudo systemctl enable sddm
    ```

### Vá em frente
- Voce vai precisar instalar os drivers de audio
- Voce vai precisar instalar os drivers de bluetooth


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



### Links úteis

https://aur.archlinux.org/packages/brave-bin

https://aur.archlinux.org/brave-bin.git

https://www.jetbrains.com/pt-br/idea/download/other/#releases-2024

https://download.jetbrains.com/idea/ideaIC-2023.2.5.tar.gz

https://www.jetbrains.com/pt-br/webstorm/download/other/#releases-2024

https://download.jetbrains.com/webstorm/WebStorm-2024.1.7.tar.gz

