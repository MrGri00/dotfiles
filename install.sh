#!/bin/bash

# Function to print messages
print_msg() {
    echo -e "\e[32m$1\e[0m"
}

# Enable multilib repository
print_msg "Enabling multilib repository..."
PACMAN_CONF="/etc/pacman.conf"
sudo sed -i '/^\s*#\[multilib\]/s/^#//' "$PACMAN_CONF"
sudo sed -i '/^\s*#Include = \/etc\/pacman.d\/mirrorlist/s/^#//' "$PACMAN_CONF"

echo "[multilib] section has been uncommented in $PACMAN_CONF"

# Update and upgrade
print_msg "Updating and upgrading..."
sudo pacman -Syyu --noconfirm

# Install regular packages
print_msg "Installing regular packages..."
sudo pacman -S --noconfirm discord docker firefox keepassxc mkinitcpio obsidian yay

# Install AUR packages
print_msg "Installing AUR packages..."
yay -S --noconfirm steam steamcmd visual-studio-code-bin

# Install NVIDIA drivers
print_msg "Installing NVIDIA drivers..."
sudo pacman -S --noconfirm nvidia-dkms nvidia-settings nvidia-utils

# Update initramfs
print_msg "Updating initramfs..."
sudo mkinitcpio -P --noconfirm

# Regenerate GRUB config
print_msg "Regenerating GRUB config..."
sudo grub-mkconfig -o /boot/grub/grub.cfg
