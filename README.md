# dotfiles

Personal dotfiles for easy setup

## Overview

This project contains personal dotfiles and scripts to automate the setup process of a new system. It includes configurations and installations for various packages and tools to streamline the setup.

## Features

- Enables multilib repository
- Updates and upgrades the system
- Installs regular packages (e.g., Discord, Firefox, KeepassXC, mkinitcpio, Obsidian, yay)
- Installs AUR packages (e.g., Steam, SteamCMD, Visual Studio Code)
- Installs NVIDIA drivers and updates initramfs
- Regenerates GRUB configuration

## Usage

1. Clone the repository:
    ```sh
    git clone <repository-url>
    cd dotfiles
    ```

2. Run the installation script:
    ```sh
    ./install.sh
    ```

## Requirements

- Arch Linux or an Arch-based distribution
- `sudo` privileges

## Notes

- This project is intended for personal use only.
- Ensure you review the `install.sh` script before running it to understand the changes it will make to your system.
