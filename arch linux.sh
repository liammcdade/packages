#!/bin/bash

# Arch Linux Installation Script with XFCE4 Desktop Environment

# Set up keyboard layout
loadkeys uk

# Connect to the internet
# If you're using a wired connection, this step may be skipped
wifi-menu

# Update the system clock
timedatectl set-ntp true

# Partition the disk
# Replace /dev/sda with your disk device
# Make sure to adjust the partition sizes and types as per your requirements
(
  echo o;
  echo n;
  echo;
  echo;
  echo;
  echo +500M;
  echo t;
  echo 1;
  echo n;
  echo;
  echo;
  echo;
  echo;
  echo t;
  echo 2;
  echo 24;
  echo w;
) | fdisk /dev/sda

# Format the partitions
mkfs.ext4 /dev/sda2
mkfs.fat -F32 /dev/sda1

# Mount the partitions
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

# Install the base system
pacstrap /mnt base linux linux-firmware

# Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt

# Set the time zone
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

# Configure the locale
echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf

# Set the hostname
echo "liam" >> /etc/hostname

# Configure the hosts file
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    liam.localdomain liam" >> /etc/hosts

# Set the root password
echo -e "liam\nliam" | passwd

# Install and configure the bootloader (GRUB)
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Install and configure the XFCE4 desktop environment
pacman -S xorg xorg-xinit xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
systemctl enable lightdm.service

# Create a new user
useradd -m -G wheel -s /bin/bash liam
echo -e "liam\nliam" | passwd liam
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Exit the chroot environment
exit

# Unmount partitions and reboot
umount -R /mnt
reboot
