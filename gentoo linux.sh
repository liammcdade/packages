#!/bin/bash

# Gentoo Linux Installation Script with XFCE4 Desktop

# Set the desired variables
DISK="/dev/sda"
TIMEZONE="Europe/London"
HOSTNAME="gentoo"
USERNAME="liam"
PASSWORD="liam"

# Partition the disk
parted -s "${DISK}" mklabel gpt
parted -s "${DISK}" mkpart primary 1MiB 3MiB
parted -s "${DISK}" set 1 bios_grub on
parted -s "${DISK}" mkpart primary 3MiB 131MiB
parted -s "${DISK}" set 2 boot on
parted -s "${DISK}" mkpart primary 131MiB 100%

# Format the partitions
mkfs.ext2 "${DISK}1"
mkfs.ext4 "${DISK}2"

# Mount the root partition
mount "${DISK}2" /mnt/gentoo

# Set the date
ntpd -q -g

# Download the latest stage3 tarball
STAGE3_URL=$(curl -s https://www.gentoo.org/downloads/mirrors/ | grep -o 'https[^"]*stage3-amd64[^"]*tar.xz' | head -n 1)
wget "${STAGE3_URL}"
tar xpf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner -C /mnt/gentoo
rm stage3-*.tar.xz

# Download the latest portage snapshot
SNAPSHOT_URL=$(curl -s https://www.gentoo.org/downloads/mirrors/ | grep -o 'https[^"]*portage-latest.tar.xz' | head -n 1)
wget "${SNAPSHOT_URL}"
tar xpf portage-latest.tar.xz -C /mnt/gentoo/usr
rm portage-latest.tar.xz

# Configure Gentoo installation
cp -L /etc/resolv.conf /mnt/gentoo/etc/
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

# Chroot into the Gentoo environment
chroot /mnt/gentoo /bin/bash << "EOF"
source /etc/profile
export PS1="(chroot) ${PS1}"
mount /dev/${DISK}1 /boot

# Set the timezone
echo "${TIMEZONE}" > /etc/timezone
emerge --config sys-libs/timezone-data

# Set the system locale
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
eselect locale set en_US.utf8
env-update && source /etc/profile

# Configure the network
echo "hostname=\"${HOSTNAME}\"" > /etc/conf.d/hostname
echo "127.0.0.1    localhost ${HOSTNAME}" > /etc/hosts

# Set the root password
echo "root:${PASSWORD}" | chpasswd

# Configure the bootloader (GRUB)
emerge sys-boot/grub:2
grub-install "${DISK}"
grub-mkconfig -o /boot/grub/grub.cfg

# Install and configure the XFCE4 desktop environment
emerge --ask x11-base/xorg-server x11-drivers xf86-video-vesa xfce-base/xfce4-meta x11-misc/lightdm x11-themes/gentoo-artwork x11-misc/mousepad app-arch/unzip

rc-update add dbus default
rc-update add lightdm default

echo "exec startxfce4" > ~/.xinitrc

# Create a new user
useradd -m -G users,wheel,audio,video -s /bin/bash "${USERNAME}"
echo "${USERNAME}:${PASSWORD}" | chpasswd

EOF

# Unmount partitions and reboot
umount -R /mnt
reboot