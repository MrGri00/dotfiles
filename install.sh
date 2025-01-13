#!/bin/bash

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

prompt_nvidia_installation() {
    if confirm "Do you want to install NVIDIA drivers? [y/N]"
        print_msg "Installing NVIDIA drivers..."
        sudo pacman -S --noconfirm nvidia-dkms nvidia-settings nvidia-utils
    fi
}

prompt_gaming_software_installation() {
    if confirm "Do you want to install gaming software? [y/N]"
        print_msg "Installing gaming software..."
        yay -S --noconfirm heroic-games-launcher steam steamcmd
    fi
}

# Enable multilib repository
print_msg "Enabling multilib repository..."
PACMAN_CONF="/etc/pacman.conf"
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
yay -S --noconfirm onlyoffice-bin visual-studio-code-bin

# NVIDIA drivers
prompt_nvidia_installation

# Gaming software
prompt_gaming_software_installation

# CLI configuration
print_msg "Configuring CLI..."
chsh -s $(which fish)
echo "starship init fish | source" >> ~/.config/fish/config.fish
for zip_file in ./fonts/*.zip; do
    folder_name=$(basename "$zip_file" .zip)
    sudo mkdir -p "/usr/local/share/fonts/ttf/$folder_name"
    sudo unzip -oq "$zip_file" -d "/usr/local/share/fonts/ttf/$folder_name"
    sudo find "/usr/local/share/fonts/ttf/$folder_name" -type f ! -name "*.ttf" -delete
done
cp ./files/starship.toml ~/.config/starship.toml

# Shell aliases
print_msg "Configuring shell aliases..."
echo 'alias update="sudo pacman -Syyu --noconfirm; and yay --noconfirm"' >> ~/.config/fish/config.fish

# Update initramfs
print_msg "Updating initramfs..."
sudo mkinitcpio -P --noconfirm

# Regenerate GRUB config
print_msg "Regenerating GRUB config..."
sudo grub-mkconfig -o /boot/grub/grub.cfg
