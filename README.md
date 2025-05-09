# Arch Linux Minimal Installation 2025

This guid for installing minimal Arch linux in 2025

## Terminal Font

- setfont ter-132b

## Check System Platform size

- cat /sys/firmware/efi/fw_platform_size

## Setup Wifi Network

- iwctl
- iwctl --passphrase passphrase station wlo1 connect <AP_NAME>

## System Setup

- timedatectl
- lsblk
- cfdisk

## Format Partions

- mkfs.fat -F32 /dev/xxx1
- mkswap /dev/xxx2
- swapon /dev/xxx2
- mkfs.ext4 /dev/xxx3

## Mount Drives

- mount /dev/xxroot /mnt
- mount /dev/xxboot /mnt/boot
- mount /dev/xxhome /mnt/home

## Pacstrap arch

pacstrap -K /mnt base linux linux-firmware intel-ucode nano vim networkmanager wpa_supplicant sudo

## Post Installtion

- genfstab -U /mnt >> /mnt/etc/fstab
- arch-chroot /mnt
- ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
- hwclock --systohc
- nano /etc/locale.gen
- locale-gen
- echo LANG=en_US.UTF-8 > /etc/locale.conf

- nano /etc/hosts
    ```
    127.0.0.1     localhost
    ::1           localhost
    127.0.1.1     Archfish.localdomain    localhost
    ```

- mkinitcpio -P
- passwd
- useradd -m username
- usermod -aG wheel,storage,power username
- visudo
    ```
    Uncomment wheel
    ```
- passwd username

## Setup Boot Manager

- bootctl install
- nano /boot/loader/loader.conf
    ```
    default   arch.conf
    timeout   4
    console-mode max
    editor    no
    ```
- nano /boot/loader/entries/arch.conf
    ```
    title    Arch Linux
    linux    /vmlinuz-linux
    initrd   /initramfs-linux.img
    options  root=UUID=005c7ce2-7988-45b8-ba1a-6c38fd89fb1c rw
    ```

- reboot

## Configure NetworkManager

- sudo systemctl status NetworkManager
- sudo systemctl start NetworkManager
- sudo systemctl enable NetworkManager
- nmcli device
- sudo nmcli con up enp1s0

## Pacman Mirrors
- pacman -S reflector rsync curl
- cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
- sudo reflector --save /etc/pacman.d/mirrorlist --latest 10 --protocol https --sort rate

## Hardware modules checkups
- lspci -k | less
- lsmod | grep -i vga

## Install AUR helper
- sudo pacman -S --needed base-devel git
- git clone https://aur.archlinux.org/yay-bin.git
- cd yay-bin
- makepkg -si