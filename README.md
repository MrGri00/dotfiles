# dotfiles

Personal dotfiles for easy setup

## Overview

This project contains personal dotfiles and scripts to automate the setup process of a new system. It includes configurations and installations for various packages, tools, and software to streamline system setup.

## Features

- Enables the multilib repository for additional package support.
- Updates and upgrades the system.
- Installs essential packages, including:
  - Regular packages: Discord, Docker, Firefox, Fish shell, KeepassXC, mkinitcpio, Obsidian, Starship prompt, yay.
  - AUR packages: OnlyOffice, Visual Studio Code.
- Optional installations:
  - NVIDIA drivers (with confirmation prompt).
  - Gaming software (Heroic Games Launcher, Steam, SteamCMD, with confirmation prompt).
- Configures the Fish shell and CLI with Starship prompt.
- Installs custom fonts from the `./fonts/` directory.
- Updates `initramfs` and regenerates the GRUB configuration.

## Usage

1. Clone the repository:
    ```sh
    git clone https://github.com/MrGri00/dotfiles
    cd dotfiles
    ```

2. Review the installation script:
    The script is located at `install.sh`. Open it to understand the actions it will perform.

3. Run the installation script:
    ```sh
    ./install.sh
    ```

    During the execution, you will be prompted to confirm certain optional installations (e.g., NVIDIA drivers, gaming software).

## Requirements

- Arch Linux or an Arch-based distribution.
- `sudo` privileges.

## Notes

- This project is intended for personal use only.
- Ensure you review the `install.sh` script before running it to avoid unintended changes to your system.
- Custom configurations (e.g., Starship prompt, Fish shell) are tailored to personal preferences and may require adjustment for your setup.
