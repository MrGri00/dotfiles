#!/bin/bash

# Variables
PACMAN_CONF="/etc/pacman.conf"
FISH_CONFIG_FILE=~/.config/fish/config.fish
LOGO_DIR=/usr/share/$(whoami)/logos

# Functions
print_msg() {
    echo -e "\e[32m$1\e[0m"
}

confirm() {
    print_msg $1
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        return true
    else
        return false
    fi
}

# Enable multilib repository
print_msg "Enabling multilib repository..."
sudo sed -i '/^\s*#\[multilib\]/s/^#//' "$PACMAN_CONF"
sudo sed -i '/^\s*#Include = \/etc\/pacman.d\/mirrorlist/s/^#//' "$PACMAN_CONF"

# Update and upgrade
print_msg "Updating and upgrading..."
sudo pacman -Syyu --noconfirm

# Install regular packages
print_msg "Installing regular packages..."
sudo pacman -S --noconfirm discord docker fastfetch firefox fish keepassxc mkinitcpio obsidian starship yay

# Install AUR packages
print_msg "Installing AUR packages..."
yay -S --noconfirm brave-bin onlyoffice-bin visual-studio-code-bin

# NVIDIA drivers (comment out if not needed)
print_msg "Installing NVIDIA drivers..."
sudo pacman -S --noconfirm nvidia-dkms nvidia-settings nvidia-utils

# Gaming software (comment out if not needed)
print_msg "Installing gaming software..."
yay -S --noconfirm heroic-games-launcher steam steamcmd

# CLI configuration
print_msg "Configuring CLI..."
chsh -s $(which fish)
sed -i '/if status is-interactive/,/end/ {
    /fastfetch/d
}' "$FISH_CONFIG_FILE"
echo "starship init fish | source" >> $FISH_CONFIG_FILE
echo 'set fish_greeting ""' >> $FISH_CONFIG_FILE
for zip_file in ./fonts/*.zip; do
    folder_name=$(basename "$zip_file" .zip)
    sudo mkdir -p "/usr/local/share/fonts/ttf/$folder_name"
    sudo unzip -oq "$zip_file" -d "/usr/local/share/fonts/ttf/$folder_name"
    sudo find "/usr/local/share/fonts/ttf/$folder_name" -type f ! -name "*.ttf" -delete
done
cp ./files/starship.toml ~/.config/starship.toml
sudo mkdir -p $LOGO_DIR
sudo cp ./files/custom_logos/*.png $LOGO_DIR

# Shell aliases
print_msg "Configuring shell aliases..."
echo 'alias update="sudo pacman -Syyu --noconfirm; and yay --noconfirm"' >> $FISH_CONFIG_FILE

# Update initramfs
print_msg "Updating initramfs..."
sudo mkinitcpio -P --noconfirm

# Regenerate GRUB config
print_msg "Regenerating GRUB config..."
sudo grub-mkconfig -o /boot/grub/grub.cfg
